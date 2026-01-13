package com.sdr.entity;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "day_planner")
public class DayPlanner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate planDate;
    
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime startTime;
    
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime endTime;

    private String title;
    private String description;

    private String status; // UPCOMING, RUNNING, COMPLETED

    private boolean notifiedStart;
    private boolean notifiedEnd;
    
    private boolean notifiedUi; // 👈 NEW

    private boolean uiNotified;


    public boolean isUiNotified() {
		return uiNotified;
	}

	public void setUiNotified(boolean uiNotified) {
		this.uiNotified = uiNotified;
	}

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    
	public boolean isNotifiedUi() {
		return notifiedUi;
	}

	public void setNotifiedUi(boolean notifiedUi) {
		this.notifiedUi = notifiedUi;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getPlanDate() {
		return planDate;
	}

	public void setPlanDate(LocalDate planDate) {
		this.planDate = planDate;
	}

	public LocalTime getStartTime() {
		return startTime;
	}

	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}

	public LocalTime getEndTime() {
		return endTime;
	}

	public void setEndTime(LocalTime endTime) {
		this.endTime = endTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean isNotifiedStart() {
		return notifiedStart;
	}

	public void setNotifiedStart(boolean notifiedStart) {
		this.notifiedStart = notifiedStart;
	}

	public boolean isNotifiedEnd() {
		return notifiedEnd;
	}

	public void setNotifiedEnd(boolean notifiedEnd) {
		this.notifiedEnd = notifiedEnd;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
    
    
}
