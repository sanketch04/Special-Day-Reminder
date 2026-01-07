package com.sdr.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.allUtils.EmailUtil;
import com.sdr.allUtils.OtpUtil;
import com.sdr.allUtils.PasswordUtil;
import com.sdr.dao.UserDAO;
import com.sdr.entity.User;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDAO userDAO;

    @Override
    public void registerUser(User user) {
        String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
        user.setPassword(hashedPassword);

        userDAO.saveUser(user);
    }


    @Override
    public User login(String email, String rawPassword) {

        User user = userDAO.getUserByEmail(email);

        // 1️⃣ Email not found
        if (user == null) {
            return null;
        }

        // 2️⃣ Password incorrect
        if (!PasswordUtil.checkPassword(rawPassword, user.getPassword())) {
            return null;
        }

        // 3️⃣ Login success
        return user;
    }





    @Override
    public void verifyOtp(String email, String otp) {

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            throw new IllegalArgumentException("Account not found");
        }

        if (user.getResetOtp() == null ||
            !user.getResetOtp().equals(otp)) {

            throw new IllegalArgumentException("Invalid OTP");
        }

        if (user.getOtpExpiry().isBefore(LocalDateTime.now())) {
            throw new IllegalArgumentException("OTP expired");
        }
    }
    
    @Override
    public void resetPassword(String email, String newPassword) {

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            throw new IllegalArgumentException("Account not found");
        }

        String hashed = PasswordUtil.hashPassword(newPassword);
        user.setPassword(hashed);

        user.setResetOtp(null);
        user.setOtpExpiry(null);

        userDAO.updateUser(user);
    }




    @Override
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }
    
    @Override
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }
    
    @Override
    public boolean sendOtp(String email) {

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            return false;
        }

        String otp = OtpUtil.generateOtp();

        user.setResetOtp(otp);
        user.setOtpExpiry(LocalDateTime.now().plusMinutes(5));

        userDAO.updateUser(user);

        //  EMAIL
        EmailUtil.sendOtpEmail(email, otp);

        return true;
    }
    
    public boolean emailExists(String email) {
        return userDAO.getUserByEmail(email) != null;
    }



    @Override
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    @Override
    public boolean sendEmailVerificationOtp(String email, HttpSession session) {

        // ✅ If email already belongs to a REAL registered user → block
        User existing = userDAO.getUserByEmail(email);
        if (existing != null) {
            return false; // email already registered
        }

        // ✅ Generate OTP
        String otp = String.valueOf(100000 + new Random().nextInt(900000));

        // ✅ Store OTP in SESSION (NOT DB)
        session.setAttribute("REG_EMAIL", email);
        session.setAttribute("REG_OTP", otp);
        session.setAttribute("REG_OTP_EXPIRY",
                LocalDateTime.now().plusMinutes(5));

        // ✅ Send email
        EmailUtil.sendOtpEmail(email, otp);

        return true;
    }

    @Override
    public void verifyEmailOtp(String email, String otp, HttpSession session) {

        String sessionEmail = (String) session.getAttribute("REG_EMAIL");
        String sessionOtp = (String) session.getAttribute("REG_OTP");
        LocalDateTime expiry =
                (LocalDateTime) session.getAttribute("REG_OTP_EXPIRY");

        if (sessionEmail == null || !sessionEmail.equals(email)) {
            throw new IllegalArgumentException("OTP not found");
        }

        if (!otp.equals(sessionOtp)) {
            throw new IllegalArgumentException("Invalid OTP");
        }

        if (expiry.isBefore(LocalDateTime.now())) {
            throw new IllegalArgumentException("OTP expired");
        }

        // ✅ Mark verified
        session.setAttribute("EMAIL_VERIFIED", true);
    }
    
    public List<User> getVerifiedUsers() {
        return userDAO.getVerifiedUsers();
    }





}
