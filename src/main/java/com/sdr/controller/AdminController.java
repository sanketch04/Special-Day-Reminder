package com.sdr.controller;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sdr.entity.Admin;
import com.sdr.entity.User;
import com.sdr.service.AdminService;
import com.sdr.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired   
    private UserService userService;
    
    @GetMapping("/login")
    public String loginPage() {
        return "admin-login";
    }

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session
    ) {
        Admin admin = adminService.login(email, password);

        if (admin == null) {
            return "redirect:/admin/login?error";
        }

        session.setAttribute("ADMIN_LOGGED_IN", admin);
        return "redirect:/admin/dashboard";
    }
    
    @GetMapping("/eventsAdmin")
    public String adminEvents(Model model, HttpSession session) {

        if (session.getAttribute("ADMIN_LOGGED_IN") == null) {
            return "redirect:/admin/login";
        }

        model.addAttribute("events", adminService.getAll());
        return "admin-events";
    }

    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session) {
        if (session.getAttribute("ADMIN_LOGGED_IN") == null) {
            return "redirect:/admin/login";
        }
        return "admin-dashboard";
    }  
    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("ADMIN_LOGGED_IN");
        model.addAttribute("admin", admin);
        return "admin-profile";
    }
    
    @GetMapping("/users")
    public String showAllUsers(Model model, HttpSession session) {

        if (session.getAttribute("ADMIN_LOGGED_IN") == null) {
            return "redirect:/admin/login";
        }

        List<User> users = userService.getAllUsers();


        model.addAttribute("users", users);
        return "admin-users";
    }

   

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
    
    
}
