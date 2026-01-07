package com.sdr.allUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.sdr.service.ScheduledEmailService;

@Service
public class ScheduledEmailScheduler {

    @Autowired
    private ScheduledEmailService scheduledEmailService;

    // runs every 1 minute
    @Scheduled(cron = "0 * * * * *")
    public void runEmailScheduler() {
        System.out.println("⏰ Scheduler running...");
        scheduledEmailService.processScheduledEmails();
    }
}
