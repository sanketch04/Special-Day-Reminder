package com.sdr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sdr.entity.ScheduledEmail;
import com.sdr.entity.User;
import com.sdr.service.ScheduledEmailService;

@Controller
@RequestMapping("/email")
public class ScheduledEmailController {

    @Autowired
    private ScheduledEmailService service;

    // 1️⃣ SHOW EMAIL FORM
    @GetMapping("/schedule")
    public String showScheduleForm() {
        return "sendEmail"; // sendEmail.jsp
    }

    // 2️⃣ HANDLE FORM SUBMIT
    @PostMapping("/schedule")
    public String scheduleEmail(
            @ModelAttribute ScheduledEmail email,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        email.setUser(user);

        service.save(email);
        return "redirect:/email/list";
    }


    // 3️⃣ SUCCESS PAGE
    @GetMapping("/success")
    public String success() {
        return "emailScheduled"; // emailScheduled.jsp
    }
    
    @GetMapping("/list")
    public String listEmails(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");

        model.addAttribute(
            "emails",
            service.getAllByUser(user.getId())
        );

        return "scheduledEmailList";
    }


    
    @GetMapping("/edit/{id}")
    public String edit(
            @PathVariable int id,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("loggedUser");
        ScheduledEmail email = service.getById(id);

        // not found OR not owner
        if (email == null || email.getUser().getId() != user.getId()) {
            return "redirect:/access-denied";
        }

        if (email.isSent()) {
            return "redirect:/email/list";
        }

        model.addAttribute("email", email);
        return "editScheduledEmail";
    }

    
    @PostMapping("/update")
    public String update(
            @ModelAttribute ScheduledEmail email,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        ScheduledEmail existing = service.getById(email.getId());

        if (existing == null || existing.getUser().getId() != user.getId()) {
            return "redirect:/access-denied";
        }

        if (existing.isSent()) {
            return "redirect:/email/list";
        }

        email.setUser(existing.getUser());
        email.setSent(existing.isSent());

        service.update(email);
        return "redirect:/email/list";
    }


    
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable int id, HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        ScheduledEmail email = service.getById(id);

        if (email == null || email.getUser().getId() != user.getId()) {
            return "redirect:/access-denied";
        }

        service.delete(id);
        return "redirect:/email/list";
    }

}
