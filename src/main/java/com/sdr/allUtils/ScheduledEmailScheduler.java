package com.sdr.allUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.sdr.service.ScheduledEmailService;

@Service
public class ScheduledEmailScheduler {

    @Autowired
    private ScheduledEmailService scheduledEmailService;

    //every 1 minute checks
    @Scheduled(cron = "0 * * * * *")
    public void runEmailScheduler() {
        scheduledEmailService.processScheduledEmails();
    }
}
