package org.springframework.foodwastemanagement.security.service.blueprint;

import org.springframework.foodwastemanagement.dto.UsersDto;

import java.util.List;

public interface AuthenticationService {
    public List<String> checkRegisterUserDetailsValid(UsersDto usersDto);
    public void addUser(UsersDto usersDto);
    public String verify(UsersDto usersDto);
}
