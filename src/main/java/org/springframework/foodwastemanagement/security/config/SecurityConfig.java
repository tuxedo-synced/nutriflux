package org.springframework.foodwastemanagement.security.config;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.Cookie;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.foodwastemanagement.helper.JwtFilter;
import org.springframework.foodwastemanagement.security.service.Implementation.OAuthServiceImple;
import org.springframework.foodwastemanagement.security.service.blueprint.CustomerUserDetailService;
import org.springframework.foodwastemanagement.security.service.blueprint.JwtService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private static final String LOGIN_URL = "/login";

    private final CustomerUserDetailService customerUserDetailService ;
    private final JwtFilter jwtFilter;
    private final JwtService jwtService;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, OAuthServiceImple oAuthServiceImple){
        http
                .authorizeHttpRequests(authorizationManagerRequestMatcherRegistry ->
                authorizationManagerRequestMatcherRegistry
                        .requestMatchers("/home","/",LOGIN_URL,"/register","/process-login").permitAll()
                        .requestMatchers("/assets/css/**","/assets/js/**","/assets/images/**").permitAll()
                        .requestMatchers("/api/v1/**").permitAll()
                        .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage(LOGIN_URL)
                        .loginProcessingUrl("/process-login")
                        .usernameParameter("userName")
                        .passwordParameter("createPassword")
                        .failureUrl(LOGIN_URL)
                                .successHandler((request, response, authentication) -> {
                                    String username = authentication.getName();
                                    String token = jwtService.generateToken(username);
                                    Cookie cookie = new Cookie("token", token);
                                    cookie.setHttpOnly(true);
                                    cookie.setSecure(request.isSecure());
                                    cookie.setPath(request.getContextPath().isEmpty()
                                            ? "/"
                                            : request.getContextPath());
                                    cookie.setMaxAge(60 * 60);
                                    cookie.setAttribute("SameSite", "Lax");
                                    response.addCookie(cookie);
                                    response.sendRedirect(request.getContextPath() + "/dashboard");
                                })
                        .permitAll()
                        )
                .oauth2Login(oauth -> oauth
                        .loginPage(LOGIN_URL)
                        .userInfoEndpoint(userInfo -> userInfo
                                .userService(oAuthServiceImple)
                            )
                        .defaultSuccessUrl("/interface",true)
                        )
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider(customerUserDetailService);
        provider.setPasswordEncoder(new BCryptPasswordEncoder());
        return provider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration){
        return configuration.getAuthenticationManager();
    }
}
