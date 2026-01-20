package com.sdr.dao;

import com.sdr.entity.WhatsAppReminder;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Repository
public class WhatsAppReminderDao {

    @Autowired
    private SessionFactory sessionFactory;

    public List<WhatsAppReminder> getDueReminders() {

        Session session = sessionFactory.openSession();

        String hql = "FROM WhatsAppReminder WHERE status='PENDING' " +
                     "AND (eventDate < :today OR " +
                     "(eventDate = :today AND eventTime <= :now))";

        Query<WhatsAppReminder> q = session.createQuery(hql, WhatsAppReminder.class);
        q.setParameter("today", LocalDate.now());
        q.setParameter("now", LocalTime.now());

        List<WhatsAppReminder> list = q.list();
        session.close();
        return list;
    }

    public void updateStatus(int id, String status) {

        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();

        WhatsAppReminder r = session.get(WhatsAppReminder.class, id);
        r.setStatus(status);

        tx.commit();
        session.close();
    }
    public void save(WhatsAppReminder reminder) {

        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();

        session.save(reminder);

        tx.commit();
        session.close();
    }

}
