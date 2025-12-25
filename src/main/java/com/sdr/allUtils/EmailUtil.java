package com.sdr.allUtils;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    // 🔴 Use your real Gmail ID
    private static final String FROM_EMAIL = "sanketchounde0406@gmail.com";

    // 🔴 Gmail APP PASSWORD (remove spaces)
    private static final String APP_PASSWORD = "fcbfcnivghxzmadr";

    public static void sendOtpEmail(String toEmail, String otp) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject("Password Reset OTP");
            message.setText(
                "Your OTP is: " + otp +
                "\n\nThis Email is From Asmitra(SDR) to update Your password.\n\n" +
                "\n\nThis OTP is valid for 5 minutes.\n\n" +
                "If you did not request this, please ignore."
            );

            Transport.send(message);

            System.out.println("OTP Email sent successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
