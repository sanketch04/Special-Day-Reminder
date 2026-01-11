package com.sdr.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.dao.EventDAO;
import com.sdr.entity.Event;

@Service
@Transactional
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDAO eventDAO;

    @Override
    @Transactional
    public void saveEvent(Event event) {
        eventDAO.saveEvent(event);
    }

    @Override
    public List<Event> getEventsByUser(int userId) {
        return eventDAO.getEventsByUser(userId);
    }

    @Override
    public List<Event> getUpcomingEvents(int userId, LocalDate start, LocalDate end) {
        return eventDAO.getUpcomingEvents(userId, start, end);
    }

    @Override
    public Event getEventById(int id) {
        return eventDAO.getEventById(id);
    }

    @Override
    public void deleteEvent(int id) {
        eventDAO.deleteEvent(id);
    }
}
