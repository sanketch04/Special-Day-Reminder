package com.sdr.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sdr.DTO.HolidayEventDTO;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Service
public class HolidayService {

    private static final String API_KEY = "AIzaSyB3EPXnc36VV7ZOH02FgvYxqKOGwtYKMrE";

    private final ObjectMapper mapper = new ObjectMapper();

    public List<HolidayEventDTO> getHolidays(
            String rawCalendarId, int year, int month) {

        List<HolidayEventDTO> list = new ArrayList<>();

        try {
            // ✅ CRITICAL FIX
            String calendarId = URLEncoder.encode(
                    rawCalendarId,
                    StandardCharsets.UTF_8
            );

            String timeMin = String.format(
                    "%d-%02d-01T00:00:00Z", year, month);

            String timeMax = String.format(
                    "%d-%02d-31T23:59:59Z", year, month);

            String url =
                "https://www.googleapis.com/calendar/v3/calendars/"
                + calendarId
                + "/events"
                + "?key=" + API_KEY
                + "&timeMin=" + timeMin
                + "&timeMax=" + timeMax
                + "&singleEvents=true";

            JsonNode root = mapper.readTree(new URL(url));
            JsonNode items = root.get("items");

            if (items != null) {
                for (JsonNode item : items) {

                    // Skip timed events, take only all-day holidays
                    if (item.get("start").get("date") == null) continue;

                    String summary = item.get("summary").asText();
                    String dateStr = item.get("start").get("date").asText();

                    String[] parts = dateStr.split("-");
                    int m = Integer.parseInt(parts[1]);
                    int d = Integer.parseInt(parts[2]);

                    com.sdr.DTO.HolidayEventDTO dto = new com.sdr.DTO.HolidayEventDTO();
                    dto.setTitle(summary);
                    dto.setEventMonth(m);
                    dto.setEventDay(d);

                    list.add(dto);
                }
            }

        } catch (Exception e) {
            e.printStackTrace(); // keep for now
        }

        return list;
    }
}
