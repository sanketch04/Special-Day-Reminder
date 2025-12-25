package com.sdr.controller;

import com.sdr.entity.AdminEvent;
import com.sdr.service.AdminEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminEventController {

    @Autowired
    private AdminEventService adminEventService;

    // ADMIN PANEL PAGE
    @GetMapping("/events")
    public String adminEvents(Model model) {
        model.addAttribute("events", adminEventService.getAll());
        return "admin-events";
    }

    // ADD / UPDATE EVENT
    @PostMapping("/events/save")
    public String save(AdminEvent event) {
        adminEventService.save(event);
        return "redirect:/admin/events";
    }

    // DELETE EVENT
    @GetMapping("/events/delete/{id}")
    public String delete(@PathVariable int id) {
        adminEventService.delete(id);
        return "redirect:/admin/events";
    }

    // API FOR CALENDAR
    @GetMapping("/api/events")
    @ResponseBody
    public List<AdminEvent> calendarEvents(@RequestParam int month) {
        return adminEventService.getByMonth(month);
    }


}
