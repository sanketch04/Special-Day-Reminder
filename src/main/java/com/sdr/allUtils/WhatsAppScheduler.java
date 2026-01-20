package com.sdr.allUtils;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sdr.dao.WhatsAppReminderDao;
import com.sdr.entity.WhatsAppReminder;
import com.sdr.service.WhatsAppService;

import javax.annotation.PostConstruct;

@Component
public class WhatsAppScheduler {
	
	 @Autowired
	    private WhatsAppReminderDao reminderDao;

	    @Autowired
	    private WhatsAppService whatsappService;

    static {
        System.out.println("🔥 WhatsAppScheduler CLASS LOADED");
    }

    @PostConstruct
    public void startScheduler() {

        System.out.println("✅ WhatsApp + Email Scheduler Started");

        ScheduledExecutorService executor =
            Executors.newSingleThreadScheduledExecutor();

        executor.scheduleAtFixedRate(() -> {

            System.out.println("⏰ Scheduler tick at " + java.time.LocalTime.now());

            List<WhatsAppReminder> reminders =
                reminderDao.getDueReminders();

            System.out.println("📦 Reminders found: " + reminders.size());

            for (WhatsAppReminder r : reminders) {

                System.out.println("➡ Processing reminder ID: " + r.getId());

                boolean sent = false;

                if (r.isSendWhatsApp()) {
                    System.out.println("📲 Sending WhatsApp...");
                    sent |= whatsappService.sendMessage(r);
                }

                if (r.isSendEmail()) {
                    System.out.println("📧 Sending Email...");
                    EmailUtil.sendEventEmail(
                        r.getEmail(),
                        r.getEventName(),
                        r.getMessage()
                    );
                    sent = true;
                }

                reminderDao.updateStatus(
                    r.getId(),
                    sent ? "SENT" : "FAILED"
                );
            }

        }, 0, 1, TimeUnit.MINUTES);
    }
}
