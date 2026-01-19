package com.sdr.controller;

import com.sdr.entity.AdminEvent;
import com.sdr.entity.Event;
import com.sdr.entity.User;
import com.sdr.service.AdminEventService;
import com.sdr.service.AdminService;
import com.sdr.service.EventService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminEventController {

    private final AdminService adminService;
    
    @Autowired
    private  EventService eventService;

    @Autowired
    private AdminEventService adminEventService;

    AdminEventController(AdminService adminService) {
        this.adminService = adminService;
    }

    // ADMIN PANEL PAGE
    @GetMapping("/events")
    public String adminEvents(Model model) {
        model.addAttribute("events", adminEventService.getAll());
        return "admin-events";
    }

    @PostMapping("/event/save")
    @ResponseBody
    public String saveFromCalendar(
            @RequestParam String eventDate,
            @RequestParam String title,
            @RequestParam String category,
            @RequestParam String description,
            @RequestParam int reminderDaysBefore,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        System.out.println("SESSION ID = " + session.getId());
        System.out.println("SESSION USER = " + user);

        if (user == null) {
            return "NOT_LOGGED_IN";
        }

        String[] parts = eventDate.split("-");
        LocalDate date = LocalDate.of(
                Integer.parseInt(parts[0]),
                Integer.parseInt(parts[1]),
                Integer.parseInt(parts[2])
        );

        Event event = new Event();
        event.setTitle(title);
        event.setCategory(category);
        event.setDescription(description);
        event.setEventDate(date);
        event.setReminderDaysBefore(reminderDaysBefore);
        event.setUser(user);

        eventService.saveEvent(event);

        return "SUCCESS";
    }



    // DELETE EVENT
    @GetMapping("/events/delete/{id}")
    public String delete(@PathVariable int id) {
        adminEventService.delete(id);
        return "redirect:/admin/eventsAdmin";
    }
    
    
    
    

    // API FOR CALENDAR
    @GetMapping("/api/events")
    @ResponseBody
    public List<AdminEvent> calendarEvents(@RequestParam int month) {
        return adminEventService.getByMonth(month);
    }
    
    @GetMapping("/events/edit/{id}")
    public String editEvent(
            @PathVariable int id,
            Model model,
            HttpSession session) {

        if (session.getAttribute("loggedAdmin") == null) {
            return "redirect:/admin/login";
        }

        AdminEvent event = adminEventService.getById(id);

        if (event == null) {
            return "redirect:/admin/eventsAdminList";
        }

        model.addAttribute("event", event);
        return "adminEditEvent";
    }
    
    
    @PostMapping("/eventsUpdate")
    public String updateEvent(
            AdminEvent event,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        if (session.getAttribute("loggedAdmin") == null) {
            return "redirect:/login";
        }

        adminEventService.update(event);

        redirectAttributes.addFlashAttribute("success", "Event updated successfully");
        return "redirect:/admin/eventsAdminList";
    }



}
