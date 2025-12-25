package com.sdr.service;

import com.sdr.allUtils.EmailUtil;
import com.sdr.allUtils.OtpUtil;
import com.sdr.allUtils.PasswordUtil;
import com.sdr.dao.UserDAO;
import com.sdr.entity.User;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

        if (user == null) {
            return null; // account not found
        }

        if (!PasswordUtil.checkPassword(rawPassword, user.getPassword())) {
            // WRONG PASSWORD → do NOT update DB
            user.setPassword(null);
            return user;
        }

        return user; // SUCCESS
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


    @Override
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    

}
