package org.springframework.foodwastemanagement.security.service.Implementation;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.exception.LoginFailedException;
import org.springframework.foodwastemanagement.security.repository.UsersRepository;
import org.springframework.foodwastemanagement.security.service.blueprint.CustomerUserDetailService;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomerUserDetailServiceImple implements CustomerUserDetailService {

    private final UsersRepository usersRepository ;
    private final ModelMapper modelMapper ;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Users user = usersRepository
                .findByUserName(username)
                .orElseThrow(() ->
                    new LoginFailedException("login failed")
                    );
        return user;
    }
}
