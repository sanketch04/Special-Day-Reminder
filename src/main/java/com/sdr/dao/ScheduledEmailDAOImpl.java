package com.sdr.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdr.entity.ScheduledEmail;

@Repository
public class ScheduledEmailDAOImpl implements ScheduledEmailDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(ScheduledEmail email) {
        sessionFactory.getCurrentSession().save(email);
    }

    @Override
    public void update(ScheduledEmail email) {
        sessionFactory.getCurrentSession().update(email);
    }

    @Override
    public List<ScheduledEmail> findPendingEmails() {

        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM ScheduledEmail " +
                "WHERE sent = false " +
                "AND sendDate = :today " +
                "AND sendTime <= :now",
                ScheduledEmail.class
            )
            .setParameter("today", java.time.LocalDate.now())
            .setParameter("now", java.time.LocalTime.now())
            .list();
    }
    
    @Override
    public List<ScheduledEmail> findAll() {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM ScheduledEmail ORDER BY sendDate, sendTime", ScheduledEmail.class)
            .list();
    }
    
    @Override
    public ScheduledEmail findById(int id) {
        return sessionFactory.getCurrentSession()
            .get(ScheduledEmail.class, id);
    }
    @Override
    public void deleteById(int id) {
        ScheduledEmail email = findById(id);
        if (email != null) {
            sessionFactory.getCurrentSession().delete(email);
        }
	}

    @Override
    public List<ScheduledEmail> findAllByUser(int userId) {
        return sessionFactory.getCurrentSession()
            .createQuery(
                "FROM ScheduledEmail WHERE user.id = :uid ORDER BY sendDate, sendTime",
                ScheduledEmail.class
            )
            .setParameter("uid", userId)
            .list();
    }

}
