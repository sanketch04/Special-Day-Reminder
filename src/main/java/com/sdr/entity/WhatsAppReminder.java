//package com.sdr.entity;
//
//import javax.persistence.*;
//import java.time.LocalDate;
//import java.time.LocalTime;
//
//@Entity
//@Table(name = "whatsapp_reminder")
//public class WhatsAppReminder {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int id;
//
//    private String eventName;
//    private String category;
//
//    @Column(length = 1000)
//    private String message;
//
//    private String whatsappNumber;
//
//    private LocalDate eventDate;
//    private LocalTime eventTime;
//
//    private String status = "PENDING";
//
//    // ===== Getters & Setters =====
//
//    public int getId() { return id; }
//    public void setId(int id) { this.id = id; }
//
//    public String getEventName() { return eventName; }
//    public void setEventName(String eventName) { this.eventName = eventName; }
//
//    public String getCategory() { return category; }
//    public void setCategory(String category) { this.category = category; }
//
//    public String getMessage() { return message; }
//    public void setMessage(String message) { this.message = message; }
//
//    public String getWhatsappNumber() { return whatsappNumber; }
//    public void setWhatsappNumber(String whatsappNumber) { this.whatsappNumber = whatsappNumber; }
//
//    public LocalDate getEventDate() { return eventDate; }
//    public void setEventDate(LocalDate eventDate) { this.eventDate = eventDate; }
//
//    public LocalTime getEventTime() { return eventTime; }
//    public void setEventTime(LocalTime eventTime) { this.eventTime = eventTime; }
//
//    public String getStatus() { return status; }
//    public void setStatus(String status) { this.status = status; }
//}
