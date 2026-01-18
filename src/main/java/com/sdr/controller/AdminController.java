package com.sdr.controller;
import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
    public String adminLogin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        Admin admin = adminService.login(email, password);

        if (admin == null) {
            model.addAttribute("error", "Invalid credentials");
            return "admin-login";
        }

        session.setAttribute("loggedAdmin", admin);

        return "redirect:/admin/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session,Model model) {
        if (session.getAttribute("loggedAdmin") == null) {
            return "redirect:/admin/login";
        }
        long tUsers=adminService.countUsers();
        model.addAttribute("tUser",tUsers);
        long tEvents=adminService.countEvents();
        model.addAttribute("tEvents",tEvents);
        return "admin-dashboard";
    }

    @GetMapping("/eventsAdmin")
    public String adminEvents(Model model, HttpSession session) {
        if (session.getAttribute("loggedAdmin") == null) {
            return "redirect:/admin/login";
        }

        model.addAttribute("events", adminService.getAll());
        return "admin-events";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("loggedAdmin");
        if (admin == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("admin", admin);
        return "admin-profile";
    }

    @GetMapping("/users")
    public String viewUsers(HttpSession session, Model model) {

        Admin admin = (Admin) session.getAttribute("loggedAdmin");

        if (admin == null) {
            return "redirect:/admin/login";
        }

        List<User> users = userService.getVerifiedUsers();
        model.addAttribute("users", users);
        
        return "admin-users";
    }
    
    //upload
    @GetMapping("/upload-festival")
    public String festivLadminAdd(HttpSession session) {
        if (session.getAttribute("loggedAdmin") == null) {
            return "redirect:/admin/login";
        }
        return "admin-festival-upload";
    }
    
    @PostMapping("/festival/upload")
	public String uploadFestivalImages(
	        @RequestParam String month,
	        @RequestParam MultipartFile[] images,
	        HttpServletRequest request) throws IOException {

	    String path = request.getServletContext()
	        .getRealPath("/assets/festivals/" + month);

	    File dir = new File(path);
	    if (!dir.exists()) dir.mkdirs();

	    for (MultipartFile img : images) {
	        img.transferTo(new File(dir, img.getOriginalFilename()));
	    }

	    return "admin-dashboard";
	}

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
}
