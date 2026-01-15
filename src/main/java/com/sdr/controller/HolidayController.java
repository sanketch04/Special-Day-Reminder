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

    private final HolidayService service;

    public HolidayController(HolidayService service) {
        this.service = service;
    }

    @GetMapping("/holidays")
    public List<HolidayEventDTO> holidays(
            @RequestParam int year,
            @RequestParam int month) {

        List<HolidayEventDTO> result = new ArrayList<>();

        // 🇮🇳 India holidays
        result.addAll(
            service.getHolidays(
                GoogleCalendarConfig.INDIA_HOLIDAY_CALENDAR,
                year,
                month
            )
        );

//        // 🌍 International holidays
//        result.addAll(
//            service.getHolidays(
//                GoogleCalendarConfig.WORLD_HOLIDAY_CALENDAR,
//                year,
//                month
//            )
//        );

        return result;
    }
}
