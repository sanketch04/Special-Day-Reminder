package com.sdr.dao;

import java.time.LocalDate;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdr.entity.DayPlanner;

@Repository
public class DayPlannerDAOImpl implements DayPlannerDAO {

    @Autowired
    private SessionFactory sf;

    public void save(DayPlanner plan) {
        sf.getCurrentSession().save(plan);
    }

    public List<DayPlanner> findByUserAndDate(int userId, LocalDate date) {
        return sf.getCurrentSession()
            .createQuery(
                "FROM DayPlanner WHERE user.id=:uid AND planDate=:d ORDER BY startTime",
                DayPlanner.class)
            .setParameter("uid", userId)
            .setParameter("d", date)
            .list();
    }

    public List<DayPlanner> findPendingPlans() {
        return sf.getCurrentSession()
            .createQuery(
                "FROM DayPlanner WHERE status!='COMPLETED'",
                DayPlanner.class)
            .list();
    }

    public void update(DayPlanner plan) {
        sf.getCurrentSession().update(plan);
    }
    
    @Override
    public List<DayPlanner> findPlansForNotification() {
        return sf.getCurrentSession()
            .createQuery(
                "FROM DayPlanner WHERE " +
                "(status='UPCOMING' AND notifiedStart=false) OR " +
                "(status='RUNNING' AND notifiedEnd=false)",
                DayPlanner.class
            )
            .list();
    }

    @Override
    public List<DayPlanner> findPlansForNotification(int userId) {
        return sf.getCurrentSession()
            .createQuery(
                "FROM DayPlanner " +
                "WHERE user.id = :uid " +
                "AND uiNotified = false " +
                "AND (status = 'RUNNING' OR status = 'COMPLETED')",
                DayPlanner.class
            )
            .setParameter("uid", userId)
            .list();
    }








}
