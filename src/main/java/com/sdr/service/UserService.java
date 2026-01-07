package com.sdr.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.sdr.entity.User;

public interface UserService {
    void registerUser(User user);
    User login(String email, String password);
    User getUserByEmail(String email);
    void updateUser(User user);
    boolean sendOtp(String email);
    List<User> getAllUsers();
    void verifyOtp(String email, String otp);
    void resetPassword(String email, String newPassword);
    boolean sendEmailVerificationOtp(String email, HttpSession session);

    void verifyEmailOtp(String email, String otp, HttpSession session);
	List<User> getVerifiedUsers();
}

