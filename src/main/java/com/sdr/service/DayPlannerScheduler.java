package com.sdr.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.entity.DayPlanner;

@Service
public class DayPlannerScheduler {

    @Autowired
    private DayPlannerService service;
    
    @Transactional 
    @Scheduled(cron = "0 * * * * *") // every minute
    public void runPlanner() {

        LocalDateTime now = LocalDateTime.now();

        for (DayPlanner p : service.getPlansForNotification()) {

            LocalDateTime start =
                LocalDateTime.of(p.getPlanDate(), p.getStartTime());

            LocalDateTime end =
                LocalDateTime.of(p.getPlanDate(), p.getEndTime());

            // 🔔 START
            if (!p.isNotifiedStart() && now.isAfter(start)) {

                
                p.setNotifiedStart(true);
                p.setStatus("RUNNING");
                service.update(p);
            }

            // 🔔 END
            if (!p.isNotifiedEnd() && now.isAfter(end)) {

               

                p.setNotifiedEnd(true);
                p.setStatus("COMPLETED");
                service.update(p);
            }
        }
    }

}
