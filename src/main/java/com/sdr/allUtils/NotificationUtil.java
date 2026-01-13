package com.sdr.allUtils;

public class NotificationUtil {

    // Simple notification (scheduler use)
    public static void show(String message) {
        // For now console log (industry practice for backend schedulers)
        System.out.println("🔔 NOTIFICATION: " + message);
    }

    // User-specific notification (future use: WebSocket / DB / Firebase)
    public static void notifyUser(int userId, String message) {
        System.out.println(
            "🔔 Notification for user " + userId + ": " + message
        );
    }
}
