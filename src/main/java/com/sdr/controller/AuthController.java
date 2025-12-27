package com.sdr.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sdr.allUtils.PasswordUtil;
import com.sdr.entity.User;
import com.sdr.service.UserService;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    /* =========================
       BASIC ROUTES
       ========================= */

    @GetMapping("/")
    public String start() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    /* =========================
       LOGIN
       ========================= */

    @PostMapping("/login")
    public String loginUser(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        User user = userService.getUserByEmail(email);

        // Email not found
        if (user == null) {
            model.addAttribute("error", "Account does not exist. Please register.");
            return "login";
        }

        // Password wrong
        if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            model.addAttribute("error", "Please Enter Valid password.");
            return "login";
        }

        // Success
        session.setAttribute("loggedUser", user);
        return "redirect:/dashboard";
    }



    /* =========================
       FORGOT PASSWORD (OLD FLOW – UNTOUCHED)
       ========================= */

    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/send-otp")
    public String sendForgotOtp(@RequestParam String email, Model model) {

        boolean sent = userService.sendOtp(email); // existing user only

        if (!sent) {
            model.addAttribute("error", "Account not found");
            return "forgot-password";
        }

        model.addAttribute("email", email);
        return "verify-otp";
    }

    @PostMapping("/verify-otp")
    public String verifyForgotOtp(
            @RequestParam String email,
            @RequestParam String otp,
            @RequestParam String confirmOtp,
            Model model) {

        if (!otp.equals(confirmOtp)) {
            model.addAttribute("error", "OTP does not match");
            model.addAttribute("email", email);
            return "verify-otp";
        }

        userService.verifyOtp(email, otp); // VOID METHOD (unchanged)

        model.addAttribute("email", email);
        return "reset-password";
    }

    @PostMapping("/reset-password")
    public String resetPassword(
            @RequestParam String email,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            Model model) {

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            model.addAttribute("email", email);
            return "reset-password";
        }

        userService.resetPassword(email, newPassword);
        return "redirect:/login";
    }

    /* =========================
       REGISTRATION WITH OTP (FIXED)
       ========================= */

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(
            User user,
            @RequestParam("profileImage") MultipartFile profileImage,
            HttpServletRequest request,
            Model model) {

        try {
            if (userService.getUserByEmail(user.getEmail()) != null) {
                model.addAttribute("error", "Email already registered");
                return "register";
            }

            String uploadDir = request.getServletContext()
                    .getRealPath("/uploads/profile/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            if (!profileImage.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_"
                        + profileImage.getOriginalFilename();
                profileImage.transferTo(new File(uploadDir + File.separator + fileName));
                user.setProfilePhoto(fileName);
            } else {
                user.setProfilePhoto("default.png");
            }

            userService.registerUser(user);
            return "redirect:/login";

        } catch (Exception e) {
            e.printStackTrace(); // 👈 DO NOT REMOVE UNTIL FIXED
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }



   

    /* =========================
       PROFILE
       ========================= */

    @GetMapping("/profile")
    public String profilePage(HttpSession session) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }
        return "profile";
    }

    @PostMapping("/update-profile")
    public String updateProfile(
            @RequestParam String phone,
            @RequestParam String state,
            @RequestParam MultipartFile profileImage,
            HttpSession session,
            HttpServletRequest request,
            Model model) {

        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        try {
            user.setPhone(phone);
            user.setState(state);

            if (!profileImage.isEmpty()) {
                String uploadDir = request.getServletContext()
                        .getRealPath("/uploads/profile/");
                new File(uploadDir).mkdirs();

                String fileName = System.currentTimeMillis() + "_"
                        + profileImage.getOriginalFilename();
                profileImage.transferTo(new File(uploadDir + fileName));
                user.setProfilePhoto(fileName);
            }

            userService.updateUser(user);
            session.setAttribute("loggedUser", user);

            model.addAttribute("success", "Profile updated");
            return "profile";

        } catch (Exception e) {
            model.addAttribute("error", "Update failed");
            return "profile";
        }
    }

    /* =========================
       LOGOUT
       ========================= */

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
