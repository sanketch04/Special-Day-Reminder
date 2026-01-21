package com.sdr.allUtils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    // 🔴 Your Gmail
    private static final String FROM_EMAIL = "sanketchounde0406@gmail.com";

    // 🔴 App password
    private static final String APP_PASSWORD = "fcbfcnivghxzmadr";

    /* =========================
       ✅ EXISTING OTP EMAIL (UNCHANGED)
       ========================== */
    public static void sendOtpEmail(String toEmail, String otp) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(
            props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            }
        );

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );
            message.setSubject("Password Reset OTP");
            message.setText(
                "Your OTP is: " + otp + "\n\nThis OTP is valid for 5 minutes."
            );

            Transport.send(message);
            System.out.println("✅ OTP Email sent");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* =========================
       🆕 NEW METHOD FOR EVENTS
       ========================== */
    public static void sendEventEmail(String toEmail, String subject, String body) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(
            props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            }
        );

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("✅ Event Email sent to " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
