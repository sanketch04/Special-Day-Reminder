package com.sdr.dao;

import java.util.List;

import com.sdr.entity.User;

public interface UserDAO {
    void saveUser(User user);
    User getUserByEmail(String email);
    User login(String email, String password);
    void updateUser(User user);
    List<User> getAll();
    List<User> getAllUsers();



}
