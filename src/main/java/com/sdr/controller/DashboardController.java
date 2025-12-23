package com.sdr.controller;

import com.sdr.entity.User;
import com.sdr.service.EventService;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;

@Controller
public class DashboardController {

    @Autowired
    private EventService eventService;
    
    @GetMapping("/calendar")
    public String calendar() {
        return "calendar";
    }

    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "redirect:/login";
        }

        LocalDate today = LocalDate.now();

        model.addAttribute("todayEvents",
                eventService.getUpcomingEvents(user.getId(), today, today));

        model.addAttribute("next7Events",
                eventService.getUpcomingEvents(user.getId(), today, today.plusDays(7)));

        model.addAttribute("next30Events",
                eventService.getUpcomingEvents(user.getId(), today, today.plusDays(30)));

        return "dashboard";
    }
}
