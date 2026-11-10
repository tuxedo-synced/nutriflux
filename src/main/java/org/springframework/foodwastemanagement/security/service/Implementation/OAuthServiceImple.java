package org.springframework.foodwastemanagement.security.service.Implementation;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.foodwastemanagement.dto.UsersDto;
import org.springframework.foodwastemanagement.entity.Users;
import org.springframework.foodwastemanagement.exception.LoginFailedException;
import org.springframework.foodwastemanagement.helper.Provider;
import org.springframework.foodwastemanagement.helper.Role;
import org.springframework.foodwastemanagement.security.repository.UsersRepository;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;


@Service
@RequiredArgsConstructor
public class OAuthServiceImple extends DefaultOAuth2UserService {
    private final UsersRepository usersRepository;
    private final ModelMapper modelMapper ;

        @Override
        public OAuth2User loadUser (OAuth2UserRequest request)
            throws OAuth2AuthenticationException {

            OAuth2User oauthUser = super.loadUser(request);

            String provider = request.getClientRegistration()
                    .getRegistrationId();

            String email = oauthUser.getAttribute("email");

            String name = oauthUser.getAttribute("name");

            String providerId;
            UsersDto usersDto = new UsersDto();

            if (provider.equals("google")) {
                providerId = oauthUser.getAttribute("sub");
                usersDto.setProvider(Provider.GOOGLE);
            }else {
                throw new LoginFailedException("Unsupported provider");
            }

            usersDto.setUserName(name);
            usersDto.setFullName(name);
            usersDto.setEmail(email);
            usersDto.setPassword(provider.toUpperCase() + ": NULL");
            usersDto.setRole(Role.STORE);
            usersDto.setCreatedAt(LocalDateTime.now());
            usersRepository.save(modelMapper.map(usersDto, Users.class));

            return oauthUser;
        }
    }
