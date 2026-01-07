package com.sdr.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.allUtils.EmailUtil;
import com.sdr.dao.ScheduledEmailDAO;
import com.sdr.entity.ScheduledEmail;
@Service
@Transactional
public class ScheduledEmailService {

    @Autowired
    private ScheduledEmailDAO scheduledEmailDAO;
    
    public void save(ScheduledEmail email) {
    	scheduledEmailDAO.save(email);
    }
    
    public void update(ScheduledEmail email) {
        scheduledEmailDAO.update(email);
    }


    public List<ScheduledEmail> getAllByUser(int userId) {
        return scheduledEmailDAO.findAllByUser(userId);
    }
    
    public List<ScheduledEmail> getAll() {
        return scheduledEmailDAO.findAll();
    }

    public ScheduledEmail getById(int id) {
        return scheduledEmailDAO.findById(id);
    }

    public void delete(int id) {
    	scheduledEmailDAO.deleteById(id);
    }

    public List<ScheduledEmail> getPendingEmails() {
        return scheduledEmailDAO.findPendingEmails();
    }

    public void sendEmailNow(String to, String message) {
        EmailUtil.sendOtpEmail(to, message);
    }

    // 🔥 CORE LOGIC
    @Transactional
    public void processScheduledEmails() {

        List<ScheduledEmail> emails = scheduledEmailDAO.findPendingEmails();

        LocalDateTime now = LocalDateTime.now();

        for (ScheduledEmail email : emails) {

            LocalDateTime scheduledTime =
                LocalDateTime.of(email.getSendDate(), email.getSendTime());

            // 🔴 VERY IMPORTANT CONDITION
            if (!email.isSent() && !scheduledTime.isAfter(now)) {

                EmailUtil.sendEventEmail(
                    email.getReceiverEmail(),
                    email.getEventInfo(),
                    email.getMessage()
                );

                // ✅ mark as sent
                email.setSent(true);

                // ✅ SAVE UPDATE TO DB (THIS WAS MISSING)
                scheduledEmailDAO.update(email);

                System.out.println("✅ Email sent & marked as SENT: " + email.getId());
            }
        }
    }

}
