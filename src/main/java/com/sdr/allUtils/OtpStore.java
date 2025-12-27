package com.sdr.allUtils;

import java.time.LocalDateTime;
import java.util.concurrent.ConcurrentHashMap;

public class OtpStore {

    private static class OtpData {
        String otp;
        LocalDateTime expiry;

        OtpData(String otp, LocalDateTime expiry) {
            this.otp = otp;
            this.expiry = expiry;
        }
    }

    private static final ConcurrentHashMap<String, OtpData> STORE = new ConcurrentHashMap<>();

    public static void save(String email, String otp, LocalDateTime expiry) {
        STORE.put(email, new OtpData(otp, expiry));
    }

    public static String getOtp(String email) {
        OtpData data = STORE.get(email);
        return data == null ? null : data.otp;
    }

    public static LocalDateTime getExpiry(String email) {
        OtpData data = STORE.get(email);
        return data == null ? null : data.expiry;
    }

    public static void remove(String email) {
        STORE.remove(email);
    }
}
