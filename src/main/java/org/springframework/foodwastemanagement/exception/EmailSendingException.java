package org.springframework.foodwastemanagement.exception;

public class EmailSendingException extends RuntimeException{
    EmailSendingException(String message){
        super(message);
    }
}
