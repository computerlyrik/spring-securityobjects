package de.computerlyrik.spring.securityobjects.exception;

import org.springframework.dao.DataAccessException;

public class EncodingException extends DataAccessException {

	public EncodingException(String msg) {
		super(msg);
	}

}
