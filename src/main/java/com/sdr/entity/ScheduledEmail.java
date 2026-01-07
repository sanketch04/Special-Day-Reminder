package com.sdr.entity;

import java.time.LocalDate;
import java.time.LocalTime;
import javax.persistence.*;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "scheduled_emails")
public class ScheduledEmail {


	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String eventInfo;        
    private String receiverEmail;    

    @Column(columnDefinition = "TEXT")
    private String message;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate sendDate;
    
    @DateTimeFormat(pattern = "HH:mm")
    private LocalTime sendTime;

    private boolean sent = false;
    
    public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;



    // getters & setters

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEventInfo() {
		return eventInfo;
	}

	public void setEventInfo(String eventInfo) {
		this.eventInfo = eventInfo;
	}

	public String getReceiverEmail() {
		return receiverEmail;
	}

	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public LocalDate getSendDate() {
		return sendDate;
	}

	public void setSendDate(LocalDate sendDate) {
		this.sendDate = sendDate;
	}

	public LocalTime getSendTime() {
		return sendTime;
	}

	public void setSendTime(LocalTime sendTime) {
		this.sendTime = sendTime;
	}

	public boolean isSent() {
		return sent;
	}

	public void setSent(boolean sent) {
		this.sent = sent;
	}
}
