package com.sdr.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdr.dao.AdminDAO;
import com.sdr.entity.Admin;
import com.sdr.entity.AdminEvent;

@Service
@Transactional
public class AdminService {

    @Autowired
    private AdminDAO adminDAO;

    public Admin login(String email, String password) {
        return adminDAO.findByEmailAndPassword(email, password);
    }
    
    public List<AdminEvent> getAll() {
        return adminDAO.getAll();
    }

    public void save(AdminEvent event) {
    	adminDAO.save(event);
    }

    public void delete(int id) {
    	adminDAO.delete(id);
    }
    public long countUsers() {
    	return adminDAO.countUsers();
    }
    public long countEvents() {
    	return adminDAO.countEvents();
    }
    public long countScheduledEmail() {
    	return adminDAO.countSceduledEvent();
    }
    public long countAdminEvents() {
    	return adminDAO.countAdminEvents();
    }
    public long countDayPlanner() {
    	return adminDAO.countDayPlanned();
    }
}

