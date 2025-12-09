package com.sdr.dao;

import com.sdr.entity.Event;
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public class EventDAOImpl implements EventDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveEvent(Event event) {
        sessionFactory.getCurrentSession().saveOrUpdate(event);
    }

    @Override
    public List<Event> getEventsByUser(int userId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Event WHERE user.id = :userId ORDER BY eventDate ASC", Event.class)
                .setParameter("userId", userId)
                .list();
    }

    @Override
    public List<Event> getUpcomingEvents(int userId, LocalDate today, LocalDate futureDate) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Event WHERE user.id = :userId AND eventDate BETWEEN :today AND :future", Event.class)
                .setParameter("userId", userId)
                .setParameter("today", today)
                .setParameter("future", futureDate)
                .list();
    }

    @Override
    public void deleteEvent(int eventId) {
        Session session = sessionFactory.getCurrentSession();
        Event event = session.byId(Event.class).load(eventId);
        if (event != null) {
            session.delete(event);
        }
    }

    @Override
    public Event getEventById(int id) {
        return sessionFactory.getCurrentSession().get(Event.class, id);
    }
}
