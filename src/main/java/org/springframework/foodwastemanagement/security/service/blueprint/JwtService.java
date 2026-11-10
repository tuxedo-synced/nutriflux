package org.springframework.foodwastemanagement.security.service.blueprint;

import org.springframework.foodwastemanagement.entity.Users;

public interface JwtService {
    String generateToken(String userName);
    String extractUsername(String token);
    boolean validatetoken(String token, Users users);
}
