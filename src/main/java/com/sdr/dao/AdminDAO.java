package com.sdr.dao;

import java.util.List;

import com.sdr.entity.Admin;
import com.sdr.entity.AdminEvent;

public interface AdminDAO {
    void save(Admin admin);
    Admin findByEmailAndPassword(String email, String password);
    List<AdminEvent> getAll();
    void save(AdminEvent event);
    void delete(int id);
}
