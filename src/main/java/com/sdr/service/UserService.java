package com.sdr.service;

import com.sdr.entity.User;

public interface UserService {
    void registerUser(User user);
    String login(String email, String password);
    User getUserByEmail(String email);
}
