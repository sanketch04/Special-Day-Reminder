package com.sdr.controller;

import com.sdr.dao.WhatsAppReminderDao;
import com.sdr.entity.WhatsAppReminder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.time.LocalTime;

@Controller
@RequestMapping("/whatsapp")
public class WhatsAppReminderController {

    @Autowired
    private WhatsAppReminderDao reminderDao;

    // Open form
    @GetMapping("/add")
    public ModelAndView openForm() {
        return new ModelAndView("add-whatsapp-reminder");
    }

    // Save reminder
    @PostMapping("/save")
    public ModelAndView saveReminder(
            @RequestParam String eventName,
            @RequestParam String category,
            @RequestParam String message,
            @RequestParam(required = false) String whatsappNumber,
            @RequestParam(required = false) String email,
            @RequestParam String eventDate,
            @RequestParam String eventTime,
            @RequestParam(required = false) String sendWhatsApp,
            @RequestParam(required = false) String sendEmail
    ) {

        WhatsAppReminder reminder = new WhatsAppReminder();
        reminder.setEventName(eventName);
        reminder.setCategory(category);
        reminder.setMessage(message);
        reminder.setWhatsappNumber(whatsappNumber);
        reminder.setEmail(email);
        reminder.setEventDate(LocalDate.parse(eventDate));
        reminder.setEventTime(LocalTime.parse(eventTime));

        // Checkbox logic
        reminder.setSendWhatsApp(sendWhatsApp != null);
        reminder.setSendEmail(sendEmail != null);

        reminderDao.save(reminder);

        ModelAndView mv = new ModelAndView("whatsapp-success");
        mv.addObject("msg", "Reminder Scheduled Successfully!");
        return mv;
    }
}
