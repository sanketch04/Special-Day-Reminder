package com.sdr.dao;

import com.sdr.entity.User;

import java.util.List;

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
	public void updateUser(User user) {
	    sessionFactory.getCurrentSession().update(user);
	}

	@Override
	public User login(String email, String password) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getAll() {
	    return sessionFactory.getCurrentSession()
	            .createQuery("from User", User.class)
	            .list();
	}
	
	@Override
	public List<User> getAllUsers() {
	    return sessionFactory.getCurrentSession()
	            .createQuery("from User", User.class)
	            .list();
	}


}
