package com.sdr.controller;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sdr.entity.Event;
import com.sdr.entity.ScheduledEmail;
import com.sdr.entity.User;
import com.sdr.service.EventService;
import com.sdr.service.ScheduledEmailService;

@Controller
@RequestMapping("/event")
public class EventController {

    @Autowired
    private EventService eventService;
    
    @Autowired
    private ScheduledEmailService scheduledEmailService;

    @GetMapping("/add")
    public String addEventPage(HttpSession session) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }
        return "addEvent";
    }

    @PostMapping("/save")
    public String saveEvent(@ModelAttribute Event event, HttpSession session,Model model) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
        	
            return "redirect:/login";
        }

        // attach logged-in user to event
        event.setUser(user);

        eventService.saveEvent(event);
        
        return "redirect:/event/list?updated=true";
    }
    
    
    @PostMapping("/save-ajax")
    @ResponseBody
    public String saveEventAjax(
            @RequestParam
            String eventDate,
            @RequestParam String title,
            @RequestParam String description,
            @RequestParam(required = false, defaultValue = "false") boolean enableEmail,
            @RequestParam(required = false) String receiverEmail,
            @RequestParam(required = false)
            @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate sendDate,
            @RequestParam(required = false)
            @DateTimeFormat(pattern = "HH:mm") LocalTime sendTime,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "NOT_LOGGED_IN";

        // 1️⃣ SAVE EVENT
        Event event = new Event();
        event.setEventDate(LocalDate.parse(eventDate));
        event.setTitle(title);
        event.setDescription(description);
        event.setUser(user);

        eventService.saveEvent(event);

        // 2️⃣ SAVE SCHEDULED EMAIL
        if (enableEmail) {
            ScheduledEmail email = new ScheduledEmail();
            email.setEventInfo(title);
            email.setReceiverEmail(receiverEmail);
            email.setMessage(description);
            email.setSendDate(sendDate);
            email.setSendTime(sendTime);
            email.setUser(user);
            email.setSent(false);

            scheduledEmailService.save(email);
        }

        return "SUCCESS";
    }



    @GetMapping("/list")
    public String listEvents(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("events",
                eventService.getEventsByUser(user.getId()));
        return "viewEvents";
    }

    @GetMapping("/delete/{id}")
    public String deleteEvent(@PathVariable int id) {
        eventService.deleteEvent(id);
        return "redirect:/event/list";
    }

    @GetMapping("/edit/{id}")
    public String editEvent(@PathVariable int id, Model model) {
        model.addAttribute("event", eventService.getEventById(id));
        return "editEvent";
    }
}
