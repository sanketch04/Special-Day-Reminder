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

import com.sdr.entity.User;
import com.sdr.service.UserService;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String start() {
        return "redirect:/login";
    }
    
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    

    @PostMapping("/login")
    public String loginUser(@RequestParam String email,
                            @RequestParam String password,
                            HttpSession session,
                            Model model) {

        User user = userService.login(email, password);

        if (user == null) {
            model.addAttribute("error",
                    "Account not found, please register first");
            return "login";
        }

        if (user.getPassword() == null) {
            model.addAttribute("error",
                    "Account exists but password is incorrect");
            return "login";
        }

        user.setPassword(null); // NEVER store password in session
        session.setAttribute("loggedUser", user);
        return "redirect:/dashboard";
    }

    
    @GetMapping("/forgot-password")
    public String forgotPasswordPage() {
        return "forgot-password";
    }

    @GetMapping("/send-otp")
    public String sendOtpGet() {
        return "redirect:/forgot-password";
    }
    
    @PostMapping("/send-otp")
    public String sendOtp(@RequestParam("email") String email, Model model) {

        boolean sent = userService.sendOtp(email);

        if (!sent) {
            model.addAttribute("error", "Account not found");
            return "forgot-password";
        }

        model.addAttribute("email", email);
        return "verify-otp";
    }

    
    @PostMapping("/verify-otp")
    public String verifyOtp(
            @RequestParam String email,
            @RequestParam String otp,
            @RequestParam String confirmOtp,
            Model model) {

        if (!otp.equals(confirmOtp)) {
            model.addAttribute("error", "OTP does not match");
            model.addAttribute("email", email);
            return "verify-otp";
        }

        userService.verifyOtp(email, otp);

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
            // ===== 1. Upload directory =====
            String uploadDir = request.getServletContext()
                    .getRealPath("/uploads/profile/");

            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // ===== 2. Save image =====
            if (!profileImage.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" +
                                  profileImage.getOriginalFilename();

                File savedFile = new File(uploadDir + File.separator + fileName);
                profileImage.transferTo(savedFile);

                // save filename in DB
                user.setProfilePhoto(fileName);
            }

            // ===== 3. Save user =====
            userService.registerUser(user);

            return "redirect:/login";

        } catch (Exception e) {
            model.addAttribute("error", "Email already exists");
            return "register";
        }
    }
    
    @GetMapping("/profile")
    public String profilePage(HttpSession session) {
        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null) {
            return "redirect:/login";
        }
        return "profile";
    }
    
    @PostMapping("/update-profile")
    public String updateProfile(
            @RequestParam("phone") String phone,
            @RequestParam("state") String state,
            @RequestParam("profileImage") MultipartFile profileImage,
            HttpSession session,
            HttpServletRequest request,
            Model model) {

        User loggedUser = (User) session.getAttribute("loggedUser");

        if (loggedUser == null) {
            return "redirect:/login";
        }

        try {
            // update simple fields
            loggedUser.setPhone(phone);
            loggedUser.setState(state);

            // upload folder
            String uploadDir = request.getServletContext()
                    .getRealPath("/uploads/profile/");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            // update photo if selected
            if (!profileImage.isEmpty()) {

                // delete old photo
                if (loggedUser.getProfilePhoto() != null &&
                    !loggedUser.getProfilePhoto().equals("default.png")) {

                    File old = new File(uploadDir + loggedUser.getProfilePhoto());
                    if (old.exists()) old.delete();
                }

                String fileName = System.currentTimeMillis() + "_" +
                                  profileImage.getOriginalFilename();
                profileImage.transferTo(new File(uploadDir + fileName));
                loggedUser.setProfilePhoto(fileName);
            }

            userService.updateUser(loggedUser);
            session.setAttribute("loggedUser", loggedUser);

            model.addAttribute("success", "Profile updated successfully");
            return "profile";

        } catch (Exception e) {
            model.addAttribute("error", "Profile update failed");
            return "profile";
        }
    }

    

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
