package de.computerlyrik.spring.securityobjects.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.persistence.TypedQuery;

import org.apache.log4j.Logger;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UserDetails;

import de.computerlyrik.spring.securityobjects.UserDetailsSO;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.RecoverableDataAccessException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.roo.addon.serializable.RooSerializable;

@RooSerializable
public class UserDetailsServiceImpl implements UserDetailsService {
	
    private static final Logger log = Logger.getLogger(UserDetailsServiceImpl.class);
    
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException 
	{
		UserDetailsSO user;
		try {
			TypedQuery<UserDetailsSO> q = UserDetailsSO.findUserDetailsSOsByUsernameEquals(username);
			if (q.getMaxResults() == 0) {
				throw new UsernameNotFoundException("Username "+ username + "not found");
			}
			user = q.getSingleResult();
		}
		catch (IllegalArgumentException e) {
			throw new RecoverableDataAccessException("Error loading User "+username,e);
		}
		log.debug("Loaded "+user.getUsername());
		log.trace(user);
		return (UserDetails) user;
	}
}
