package com.sdr.controller;

import com.sdr.entity.AdminEvent;
import com.sdr.service.AdminEventService;
import com.sdr.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminEventController {

    private final AdminService adminService;

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

    // ADD / UPDATE EVENT
    @PostMapping("/events/save")
    public String save(AdminEvent event, HttpSession session) {

        if (session.getAttribute("loggedAdmin") == null) {
            return "redirect:/admin/login";
        }

        adminService.save(event);

        return "redirect:/admin/eventsAdmin";
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


}
