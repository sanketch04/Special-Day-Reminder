package com.sdr.DTO;

public class HolidayEventDTO {

    private int eventDay;
    private int eventMonth;
    private String title;
    private String category = "HOLIDAY";
    private String source = "GOOGLE";

    // getters & setters
    public int getEventDay() { return eventDay; }
    public void setEventDay(int eventDay) { this.eventDay = eventDay; }

    public int getEventMonth() { return eventMonth; }
    public void setEventMonth(int eventMonth) { this.eventMonth = eventMonth; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategory() { return category; }
    public String getSource() { return source; }
}
