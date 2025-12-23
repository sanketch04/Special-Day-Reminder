package com.sdr.dao;

import com.sdr.entity.User;

public interface UserDAO {
    void saveUser(User user);
    User getUserByEmail(String email);
    User login(String email, String password);
    public User findByEmail(String email);
}
