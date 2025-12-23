package com.sdr.service;

import com.sdr.dao.UserDAO;
import com.sdr.entity.User;
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
        userDAO.saveUser(user);
    }

    @Override
    public String login(String email, String password) {

        // 1. Check email
        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            return "NOT_FOUND";
        }

        // 2. Check password
        if (!user.getPassword().equals(password)) {
            return "WRONG_PASSWORD";
        }

        // 3. Success
        return "SUCCESS";
    }

    @Override
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }
}
