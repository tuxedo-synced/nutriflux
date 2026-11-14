package org.springframework.foodwastemanagement.exception;

public class ImportCSVError extends RuntimeException{
    public ImportCSVError(String message) {
        super(message);
    }
}
