package com.sdr.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "events")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    private String title;

    private LocalDate eventDate;

    private String category;

    @Column(columnDefinition="TEXT")
    private String description;

    private int reminderDaysBefore = 1; 
    
    // default 1 day before

    private LocalDateTime createdAt = LocalDateTime.now();

    
    public Event() {}
    
	public Event(int id, User user, String title, LocalDate eventDate, String category, String description,
			int reminderDaysBefore, LocalDateTime createdAt) {
		super();
		this.id = id;
		this.user = user;
		this.title = title;
		this.eventDate = eventDate;
		this.category = category;
		this.description = description;
		this.reminderDaysBefore = reminderDaysBefore;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public LocalDate getEventDate() {
		return eventDate;
	}

	public void setEventDate(LocalDate eventDate) {
		this.eventDate = eventDate;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getReminderDaysBefore() {
		return reminderDaysBefore;
	}

	public void setReminderDaysBefore(int reminderDaysBefore) {
		this.reminderDaysBefore = reminderDaysBefore;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
    
    
}
