//package com.sdr.allUtils;
//
//import com.sdr.dao.WhatsAppReminderDao;
//import com.sdr.entity.WhatsAppReminder;
//import com.sdr.service.WhatsAppService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
//import jakarta.annotation.PostConstruct;
//
//import java.util.List;
//import java.util.concurrent.Executors;
//import java.util.concurrent.ScheduledExecutorService;
//import java.util.concurrent.TimeUnit;
//
//@Component
//public class WhatsAppScheduler {
//
//    @Autowired
//    private WhatsAppReminderDao reminderDao;
//
//    @Autowired
//    private WhatsAppService whatsappService;
//
//    @PostConstruct
//    public void startScheduler() {
//
//        ScheduledExecutorService executor =
//                Executors.newSingleThreadScheduledExecutor();
//
//        executor.scheduleAtFixedRate(() -> {
//
//            List<WhatsAppReminder> reminders =
//                    reminderDao.getDueReminders();
//
//            for (WhatsAppReminder r : reminders) {
//
//                boolean sent = whatsappService.sendMessage(
//                        r.getWhatsappNumber(),
//                        r.getMessage()
//                );
//
//                reminderDao.updateStatus(
//                        r.getId(),
//                        sent ? "SENT" : "FAILED"
//                );
//            }
//
//        }, 0, 1, TimeUnit.MINUTES);
//
//        System.out.println("✅ WhatsApp Scheduler Started");
//    }
//}
