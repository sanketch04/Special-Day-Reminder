package com.sdr.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdr.entity.Admin;
import com.sdr.entity.AdminEvent;

@Repository
public class AdminEventDAO {

    @Autowired
    private SessionFactory sessionFactory;

    public List<AdminEvent> getByMonth(int month) {
        Session session = sessionFactory.getCurrentSession();

        return session.createQuery(
            "from AdminEvent where eventMonth = :month and active = true",
            AdminEvent.class
        )
        .setParameter("month", month)
        .getResultList();
    }

    public void save(AdminEvent event) {
        sessionFactory.getCurrentSession().saveOrUpdate(event);
    }

    public void delete(int id) {
        AdminEvent e = sessionFactory.getCurrentSession().get(AdminEvent.class, id);
        if (e != null) {
            sessionFactory.getCurrentSession().delete(e);
        }
    }

	public List<AdminEvent> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	    public Admin findByEmail(String email) {
	        Session session = sessionFactory.getCurrentSession();

	        return session.createQuery(
	                "FROM Admin WHERE email = :email",
	                Admin.class
	        )
	        .setParameter("email", email)
	        .uniqueResult();
	    }
}
