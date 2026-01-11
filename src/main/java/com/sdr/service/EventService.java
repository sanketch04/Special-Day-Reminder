package com.sdr.service;

import java.time.LocalDate;
import java.util.List;

import com.sdr.entity.Event;

public interface EventService {
    void saveEvent(Event event);
    List<Event> getEventsByUser(int userId);
    List<Event> getUpcomingEvents(int userId, LocalDate start, LocalDate end);
    Event getEventById(int id);
    void deleteEvent(int id);
}
