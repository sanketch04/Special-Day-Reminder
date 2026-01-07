package com.sdr.dao;

import java.util.List;

import com.sdr.entity.ScheduledEmail;

public interface ScheduledEmailDAO {
    void save(ScheduledEmail email);
    List<ScheduledEmail> findPendingEmails();
    void update(ScheduledEmail email);

    ScheduledEmail findById(int id);
    List<ScheduledEmail> findAll();
    
    void deleteById(int id);
    List<ScheduledEmail> findAllByUser(int userId);

}
