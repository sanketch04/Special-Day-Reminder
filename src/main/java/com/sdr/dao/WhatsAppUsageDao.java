package com.sdr.dao;

import com.sdr.entity.WhatsAppUsage;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.time.YearMonth;

@Repository
public class WhatsAppUsageDao {

    private static final int FREE_LIMIT = 1000;

    @Autowired
    private SessionFactory sessionFactory;

    public boolean canSendMessage() {

        String monthKey = YearMonth.now().toString();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();

        WhatsAppUsage usage = session.get(WhatsAppUsage.class, monthKey);

        if (usage == null) {
            usage = new WhatsAppUsage();
            usage.setMonthYear(monthKey);
            usage.setSentCount(1);
            session.save(usage);
            tx.commit();
            session.close();
            return true;
        }

        if (usage.getSentCount() >= FREE_LIMIT) {
            session.close();
            return false;
        }

        usage.setSentCount(usage.getSentCount() + 1);
        tx.commit();
        session.close();
        return true;
    }
}
