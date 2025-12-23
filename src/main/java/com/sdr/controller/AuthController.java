package com.sdr.controller;

import com.sdr.entity.User;
import com.sdr.service.UserService;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session) {
        User user = userService.login(email, password);
        if (user != null) {
            session.setAttribute("loggedUser", user);
            return "redirect:/dashboard";
        }
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(User user,Model model) {
    	 try {
    	        userService.registerUser(user);
    	        return "redirect:/login";
    	    } catch (Exception e) {
    	        model.addAttribute("error", "Email already exists");
    	        return "register";
    	    }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
