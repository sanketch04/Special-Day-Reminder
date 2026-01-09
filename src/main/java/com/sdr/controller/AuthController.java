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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sdr.allUtils.PasswordUtil;
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
    public String loginUser(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        User user = userService.getUserByEmail(email);

        if (user == null) {
            model.addAttribute("error", "Account does not exist. Please register.");
            return "login";
        }

        if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            model.addAttribute("error", "Please Enter Valid password.");
            return "login";
        }

        session.setAttribute("loggedUser", user);
        return "redirect:/dashboard";
    }

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

        try {
            userService.verifyOtp(email, otp);
        } catch (IllegalArgumentException ex) {
            model.addAttribute("error", ex.getMessage());
            model.addAttribute("email", email);
            return "verify-otp";
        }

        // 3️⃣ Success → go to reset password
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
            HttpSession session,
            Model model) {

        try {
            // ✅ CHECK EMAIL VERIFIED FROM SESSION (NOT DB)
            Boolean verified = (Boolean) session.getAttribute("EMAIL_VERIFIED");

            if (verified == null || !verified) {
                model.addAttribute("error", "Please verify your email first");
                return "register";
            }

            // ✅ CHECK IF EMAIL ALREADY REGISTERED (REAL USERS ONLY)
            if (userService.getUserByEmail(user.getEmail()) != null) {
                model.addAttribute("error", "Email already registered");
                return "register";
            }

            // upload profile image
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

            // ✅ REGISTER USER (NOW ALL FIELDS ARE PRESENT)
            userService.registerUser(user);

            // ✅ CLEANUP SESSION
            session.removeAttribute("EMAIL_VERIFIED");
            session.removeAttribute("REG_OTP");
            session.removeAttribute("REG_EMAIL");

            return "redirect:/login";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Registration failed");
            return "register";
        }
    }



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
    
    @PostMapping("/send-register-otp")
    @ResponseBody
    public String sendRegisterOtp(
            @RequestParam String email,
            HttpSession session) {

        boolean sent = userService.sendEmailVerificationOtp(email, session);
        return sent ? "OTP_SENT" : "EMAIL_EXISTS";
    }


    @PostMapping("/verify-register-otp")
    @ResponseBody
    public String verifyRegisterOtp(
            @RequestParam String email,
            @RequestParam String otp,
            HttpSession session) {

        try {
            userService.verifyEmailOtp(email, otp, session);
            return "VERIFIED";
        } catch (Exception e) {
            return e.getMessage();
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
