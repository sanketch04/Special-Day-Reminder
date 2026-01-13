package com.sdr.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.dao.DayPlannerDAO;
import com.sdr.entity.DayPlanner;

@Service
@Transactional
public class DayPlannerService {

    @Autowired
    private DayPlannerDAO dao;

    public void addPlan(DayPlanner plan) {
        dao.save(plan);
    }

    public List<DayPlanner> getPlans(int userId, LocalDate date) {
        return dao.findByUserAndDate(userId, date);
    }

    public List<DayPlanner> getPendingPlans() {
        return dao.findPendingPlans();
    }

    public void update(DayPlanner plan) {
        dao.update(plan);
    }
    public List<DayPlanner> getPlansForNotification() {
        return dao.findPlansForNotification();
    }
    public List<DayPlanner> getRecentlyUpdatedPlans(int userId) {
        return dao.findPlansForNotification(userId);
    }


}
