package com.sdr.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.sdr.entity.Admin;
import com.sdr.entity.AdminEvent;

@Repository
@Transactional
public class AdminDAOImpl implements AdminDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Admin admin) {
        sessionFactory.getCurrentSession().save(admin);
    }

    @Override
    public Admin findByEmailAndPassword(String email, String password) {
        String hql = "from Admin where email=:email and password=:password and active=true";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, Admin.class)
                .setParameter("email", email)
                .setParameter("password", password)
                .uniqueResult();
    }
    
    @Override
    public List<AdminEvent> getAll() {
        return sessionFactory
                .getCurrentSession()
                .createQuery("FROM AdminEvent WHERE active = true", AdminEvent.class)
                .list();
    }
    
    @Override
    public long countUsers() {

        String hql = "select count(u.id) from User u";

        return (long) sessionFactory
                .getCurrentSession()
                .createQuery(hql)
                .uniqueResult();
    }
    
    @Override
    public long countEvents() {

        String hql = "select count(e.id) from Event e";

        return (long) sessionFactory
                .getCurrentSession()
                .createQuery(hql)
                .uniqueResult();
    }
    
    @Override
    public long countSceduledEvent() {

        String hql = "select count(e.id) from ScheduledEmail e";

        return (long) sessionFactory
                .getCurrentSession()
                .createQuery(hql)
                .uniqueResult();
    }
    
    @Override
    public long countAdminEvents() {

        String hql = "select count(e.id) from AdminEvent e";

        return (long) sessionFactory
                .getCurrentSession()
                .createQuery(hql)
                .uniqueResult();
    }
    
    @Override
    public long countDayPlanned() {

        String hql = "select count(e.id) from DayPlanner e";

        return (long) sessionFactory
                .getCurrentSession()
                .createQuery(hql)
                .uniqueResult();
    }

    @Override
    public void save(AdminEvent event) {
        sessionFactory.getCurrentSession().saveOrUpdate(event);
    }

    @Override
    public void delete(int id) {
        AdminEvent e = sessionFactory.getCurrentSession().get(AdminEvent.class, id);
        if (e != null) {
            sessionFactory.getCurrentSession().delete(e);
        }
        
        
    }
    
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Admin findById(int id) {
        return entityManager.find(Admin.class, id);
    }

    @Override
    public void update(Admin admin) {
        entityManager.merge(admin);
    }

	
	
}

