package com.sdr.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sdr.entity.DayPlanner;
import com.sdr.entity.User;
import com.sdr.service.DayPlannerService;

@Controller
@RequestMapping("/planner")
public class DayPlannerController {

    @Autowired
    private DayPlannerService service;

    // ✅ 1. OPEN DAY PLANNER (TODAY)
    @GetMapping
    public String todayPlanner(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedUser");
        LocalDate today = LocalDate.now();

        model.addAttribute("plans",
                service.getPlans(user.getId(), today));
        model.addAttribute("planDate", today);

        return "day-planner";
    }

    // ✅ 2. OPEN DAY PLANNER BY DATE
    @GetMapping("/{date}")
    public String viewPlanner(
            @PathVariable String date,
            HttpSession session,
            Model model) {

        User user = (User) session.getAttribute("loggedUser");
        LocalDate planDate = LocalDate.parse(date);

        model.addAttribute("plans",
                service.getPlans(user.getId(), planDate));
        model.addAttribute("planDate", planDate);

        return "day-planner";
    }

    // ✅ 3. ADD PLAN
    @PostMapping("/add")
    public String addPlan(
            @ModelAttribute DayPlanner plan,
            HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        plan.setUser(user);
        plan.setStatus("UPCOMING");

        service.addPlan(plan);

        // redirect back to same date
        return "redirect:/planner/" + plan.getPlanDate() + "?saved=true";
    }
    
    @GetMapping("/notifications")
    @ResponseBody
    public List<DayPlanner> getNotifications(HttpSession session) {

        User user = (User) session.getAttribute("loggedUser");

        List<DayPlanner> list =
            service.getRecentlyUpdatedPlans(user.getId());

        // 🔥 THIS IS THE CONNECTION YOU WERE ASKING ABOUT
        list.forEach(p -> {
            p.setUiNotified(true);   // mark as delivered
            service.update(p);
        });

        return list;
    }




}
