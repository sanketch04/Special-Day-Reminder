package com.sdr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.allUtils.PasswordUtil;
import com.sdr.dao.AdminEventDAO;
import com.sdr.entity.Admin;
import com.sdr.entity.AdminEvent;

@Service
@Transactional
public class AdminEventService {

    @Autowired
    private AdminEventDAO adminEventDAO;

    public void save(AdminEvent event) {
        adminEventDAO.save(event);
    }

    public void delete(int id) {
        adminEventDAO.delete(id);
    }

    public List<AdminEvent> getAll() {
        return adminEventDAO.getAll();
    }

    public List<AdminEvent> getByMonth(int month) {
        return adminEventDAO.getByMonth(month);
    }
    
    public Admin login(String email, String password) {
        Admin admin = adminEventDAO.findByEmail(email);

        if (admin == null) return null;

        if (!PasswordUtil.checkPassword(password, admin.getPassword())) {
            return null;
        }

        return admin;
    }
    public AdminEvent getById(int id) {
        return adminEventDAO.getById(id);
    }

    public void update(AdminEvent event) {
        adminEventDAO.save(event); 
    }

}
