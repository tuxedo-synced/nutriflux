package org.springframework.foodwastemanagement.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.foodwastemanagement.dto.UsersDto;
import org.springframework.foodwastemanagement.security.service.blueprint.AuthenticationService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Objects;

@Controller
@RequiredArgsConstructor
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @GetMapping({"/","/home"})
    public String home(){
        return "home";
    }

    @GetMapping("/login")
    public String loginGet(){
        return "login";
    }

    @GetMapping("/register")
    public String registerGet(){
        return "register";
    }

    @PostMapping("/register")
    public String registerPost(@ModelAttribute UsersDto usersDto , Model model){
        List<String> erorMessages = authenticationService.checkRegisterUserDetailsValid(usersDto);
        if(erorMessages.stream().anyMatch(Objects::isNull)){
            authenticationService.addUser(usersDto);
            return "redirect:/interface";
        }else {
            model.addAttribute("errorMessages",erorMessages);
            return "register";
        }
    }

    @GetMapping("/interface")
    public String userInterface() {
        return "interface";
    }

}
