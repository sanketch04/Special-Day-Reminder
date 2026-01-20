package com.sdr.service;

import com.sdr.dao.WhatsAppUsageDao;
import com.sdr.entity.WhatsAppReminder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class WhatsAppService {

	@Value("${WHATSAPP_ACCESS_TOKEN}")
	private String accessToken;

	@Value("${WHATSAPP_PHONE_NUMBER_ID}")
	private String phoneNumberId;

	@Value("${WHATSAPP_API_VERSION}")
	private String apiVersion;


    @Autowired
    private WhatsAppUsageDao usageDao;

    public boolean sendMessage(WhatsAppReminder r) {

        if (!usageDao.canSendMessage()) return false;

        try {
        	URL url = new URL(
        		    "https://graph.facebook.com/" +
        		    apiVersion + "/" +
        		    phoneNumberId + "/messages");

        		HttpURLConnection con = (HttpURLConnection) url.openConnection();
        		con.setRequestMethod("POST");
        		con.setRequestProperty("Authorization", "Bearer " + accessToken);
        		con.setRequestProperty("Content-Type", "application/json");
        		con.setDoOutput(true);


            String payload = "{"
              + "\"messaging_product\":\"whatsapp\","
              + "\"to\":\"" + r.getWhatsappNumber() + "\","
              + "\"type\":\"template\","
              + "\"template\":{"
              + "\"name\":\"reminder_plain_v1\","
              + "\"language\":{\"code\":\"en_US\"},"
              + "\"components\":[{"
              + "\"type\":\"body\","
              + "\"parameters\":["
              + "{\"type\":\"text\",\"text\":\"" + r.getEventName() + "\"},"
              + "{\"type\":\"text\",\"text\":\"" + r.getMessage() + "\"},"
              + "{\"type\":\"text\",\"text\":\"" + r.getEventTime() + "\"}"
              + "]"
              + "}]"
              + "}"
              + "}";

            con.getOutputStream().write(payload.getBytes());

            return con.getResponseCode() == 200;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


}
