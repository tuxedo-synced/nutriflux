package org.springframework.foodwastemanagement.security.service.Implementation;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.foodwastemanagement.dto.UsersDto;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.exception.LoginFailedException;
import org.springframework.foodwastemanagement.helper.Provider;
import org.springframework.foodwastemanagement.helper.Role;
import org.springframework.foodwastemanagement.security.repository.UsersRepository;
import org.springframework.foodwastemanagement.security.service.blueprint.AuthenticationService;
import org.springframework.foodwastemanagement.security.service.blueprint.JwtService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AuthenticationServiceImplementation implements AuthenticationService {

    private final UsersRepository usersRepository ;
    private final ModelMapper modelMapper ;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    @Override
    public List<String> checkRegisterUserDetailsValid(UsersDto usersDto) {
        List<String> errorMessages = new ArrayList<>(
                Arrays.asList(null, null, null, null, null)
        );
        String username = usersDto.getUserName().strip();
        String email = usersDto.getEmail().strip();
        if (usersRepository.existsByUserName(username)) {

            errorMessages.set(1, "Username already exists.");
        }
        if (usersRepository.existsByEmail(email)) {

            errorMessages.set(3, "Email is already registered.");
        }
        return errorMessages;
    }


    @Override
    public void addUser(UsersDto usersDto) {
        usersDto.setProvider(Provider.LOCAL);
        usersDto.setRole(Role.STORE);
        usersDto.setCreatedAt(LocalDateTime.now());
        usersDto.setPassword(passwordEncoder.encode(usersDto.getPassword()));
        Users user =  modelMapper.map(usersDto, Users.class);
        usersRepository.save(user);
        return;
    }

    @Override
    public String verify(UsersDto usersDto) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(usersDto.getUserName(),usersDto.getPassword()));
        if(authentication.isAuthenticated()){
            return jwtService.generateToken(usersDto.getUserName());
        }else{
            throw new LoginFailedException("Login failed");
        }
    }
}
