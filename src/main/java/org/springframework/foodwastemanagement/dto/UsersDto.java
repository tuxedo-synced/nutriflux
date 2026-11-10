package org.springframework.foodwastemanagement.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.foodwastemanagement.helper.Provider;
import org.springframework.foodwastemanagement.helper.Role;

import java.time.LocalDateTime;
import java.util.UUID;

@RequiredArgsConstructor
@Getter
@Setter
public class UsersDto {
    UUID id ;
    private String fullName ;
    private String userName ;
    private String email ;
    private Role role ;
    private Provider provider ;
    private String password ;
    private LocalDateTime createdAt ;
}