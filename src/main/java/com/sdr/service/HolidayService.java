package com.sdr.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sdr.DTO.HolidayEventDTO;
import org.springframework.stereotype.Service;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
@Service
public class HolidayService {

    private final ObjectMapper mapper = new ObjectMapper();

    public List<HolidayEventDTO> getHolidays(
            String rawCalendarId, int year, int month) {

        List<HolidayEventDTO> list = new ArrayList<>();

        // ✅ CORRECT WAY (Tomcat -D argument)
        String apiKey = System.getProperty("GOOGLE_CALENDAR_API_KEY");

        if (apiKey == null || apiKey.isBlank()) {
            System.err.println("❌ GOOGLE_CALENDAR_API_KEY is missing");
            return list;
        }

        System.out.println("✅ GOOGLE_CALENDAR_API_KEY loaded");

        try {
            String calendarId =
                    URLEncoder.encode(rawCalendarId, StandardCharsets.UTF_8);

            LocalDate start = LocalDate.of(year, month, 1);
            LocalDate end = start.withDayOfMonth(start.lengthOfMonth());

            String timeMin = start + "T00:00:00Z";
            String timeMax = end + "T23:59:59Z";

            String urlStr =
                "https://www.googleapis.com/calendar/v3/calendars/"
                + calendarId
                + "/events"
                + "?key=" + apiKey            // ✅ FIXED
                + "&timeMin=" + timeMin
                + "&timeMax=" + timeMax
                + "&singleEvents=true";

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            if (conn.getResponseCode() != 200) {
                return list;
            }

            JsonNode items = mapper
                    .readTree(conn.getInputStream())
                    .path("items");

            for (JsonNode item : items) {

                if (item.path("start").path("date").isMissingNode())
                    continue;

                String title = item.path("summary").asText();
                String dateStr = item.path("start").path("date").asText();

                String[] parts = dateStr.split("-");
                int eventMonth = Integer.parseInt(parts[1]);
                int eventDay = Integer.parseInt(parts[2]);

                HolidayEventDTO dto = new HolidayEventDTO();
                dto.setTitle(title);
                dto.setEventMonth(eventMonth);
                dto.setEventDay(eventDay);

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
