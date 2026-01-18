package com.sdr.dao;

import java.time.LocalDate;
import java.util.List;

import com.sdr.entity.DayPlanner;

public interface DayPlannerDAO {

    void save(DayPlanner plan);

    List<DayPlanner> findByUserAndDate(int userId, LocalDate date);

    List<DayPlanner> findPendingPlans();

    void update(DayPlanner plan);
    
    List<DayPlanner> findPlansForNotification(int userId);
    List<DayPlanner> findPlansForNotification();
    

	List<DayPlanner> getDayPlanned();
}
