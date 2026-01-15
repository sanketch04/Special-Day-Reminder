//package com.sdr.service;
//
//import com.sdr.dao.WhatsAppUsageDao;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.net.HttpURLConnection;
//import java.net.URL;
//
//@Service
//public class WhatsAppService {
//
//    private static final String ACCESS_TOKEN = "PASTE_META_ACCESS_TOKEN";
//    private static final String PHONE_NUMBER_ID = "PASTE_PHONE_NUMBER_ID";
//
//    @Autowired
//    private WhatsAppUsageDao usageDao;
//
//    public boolean sendMessage(String number, String text) {
//
//        if (!usageDao.canSendMessage()) {
//            System.out.println("❌ WhatsApp FREE limit reached");
//            return false;
//        }
//
//        try {
//            URL url = new URL(
//                "https://graph.facebook.com/v18.0/" +
//                PHONE_NUMBER_ID + "/messages");
//
//            HttpURLConnection con = (HttpURLConnection) url.openConnection();
//            con.setRequestMethod("POST");
//            con.setRequestProperty("Authorization", "Bearer " + ACCESS_TOKEN);
//            con.setRequestProperty("Content-Type", "application/json");
//            con.setDoOutput(true);
//
//            String payload = "{"
//                + "\"messaging_product\":\"whatsapp\","
//                + "\"to\":\"" + number + "\","
//                + "\"type\":\"text\","
//                + "\"text\":{\"body\":\"" + text + "\"}"
//                + "}";
//
//            con.getOutputStream().write(payload.getBytes());
//
//            return con.getResponseCode() == 200;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            return false;
//        }
//    }
//}
