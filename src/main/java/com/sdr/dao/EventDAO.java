package com.sdr.dao;

import com.sdr.entity.Event;
import java.time.LocalDate;
import java.util.List;

public interface EventDAO {
    void saveEvent(Event event);
    List<Event> getEventsByUser(int userId);
    List<Event> getUpcomingEvents(int userId, LocalDate today, LocalDate futureDate);
    void deleteEvent(int eventId);
    Event getEventById(int id);
}
