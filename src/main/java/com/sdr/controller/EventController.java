package com.sdr.controller;

import com.sdr.entity.Event;
import com.sdr.entity.User;
import com.sdr.service.EventService;

import java.time.LocalDate;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/event")
public class EventController {

    @Autowired
    private EventService eventService;

    @GetMapping("/add")
    public String addEventPage(HttpSession session) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }
        return "addEvent";
    }

    @PostMapping("/save")
    @ResponseBody
    public String saveEvent(@ModelAttribute Event event, HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) {
            return "NOT_LOGGED_IN";
        }

        // attach logged-in user to event
        event.setUser(user);

        eventService.saveEvent(event);

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
