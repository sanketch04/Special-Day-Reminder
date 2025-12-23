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
    public User login(String email, String password) {
        return userDAO.login(email, password);
    }

    @Override
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }
}
