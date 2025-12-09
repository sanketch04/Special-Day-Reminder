package com.sdr.dao;

import com.sdr.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.save(user);
    }

    @Override
    public User getUserByEmail(String email) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM User WHERE email = :email", User.class)
                      .setParameter("email", email)
                      .uniqueResult();
    }

    @Override
    public User login(String email, String password) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM User WHERE email = :email AND password = :password", User.class)
                      .setParameter("email", email)
                      .setParameter("password", password)
                      .uniqueResult();
    }
}
