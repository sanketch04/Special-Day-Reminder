package com.sdr.dao;

import java.util.List;

import com.sdr.entity.User;

public interface UserDAO {
    void saveUser(User user);
    User getUserByEmail(String email);

    void updateUser(User user);
    List<User> getAll();
    List<User> getAllUsers();



}
