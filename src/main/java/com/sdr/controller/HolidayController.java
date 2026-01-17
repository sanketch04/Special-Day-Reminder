package com.sdr.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sdr.DTO.HolidayEventDTO;
import com.sdr.allUtils.GoogleCalendarConfig;
import com.sdr.service.HolidayService;

@RestController
@RequestMapping("/admin/api")
public class HolidayController {

    private final HolidayService holidayService;

    public HolidayController(HolidayService holidayService) {
        this.holidayService = holidayService;
    }

    /**
     * API used by calendar.js
     * month comes from UI as 0–11 (JS standard)
     */
    @GetMapping("/holidays")
    public List<HolidayEventDTO> holidays(
            @RequestParam int year,
            @RequestParam int month) {

        List<HolidayEventDTO> result = new ArrayList<>();

        // 🇮🇳 India public holidays (Google Calendar)
        result.addAll(
            holidayService.getHolidays(
                GoogleCalendarConfig.INDIA_HOLIDAY_CALENDAR,
                year,
                month   // ❗ DO NOT +1 HERE
            )
        );

        return result;
    }
}
