package com.hin.modgen.sample.event.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.BAD_REQUEST)
public class FileStorageException extends RuntimeException {

	private static final long serialVersionUID = -5001483170008057450L;

	public FileStorageException(String message) {
		super(message);
	}
	
	public FileStorageException(String message, Throwable cause) {
        super(message, cause);
    }
}

