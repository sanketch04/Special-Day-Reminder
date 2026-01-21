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

import com.sdr.entity.Event;
import com.sdr.entity.User;
import com.sdr.service.EventService;

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
