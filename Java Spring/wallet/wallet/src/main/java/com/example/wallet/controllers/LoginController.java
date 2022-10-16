package com.example.wallet.controllers;

import com.example.wallet.privilleges.roles.UserRoles;
import com.example.wallet.readonly.User;
import com.example.wallet.services.UserService;
import com.example.wallet.webui.UserDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@RestController
@RequestMapping
public class LoginController {

    private final UserService userService;

    public LoginController(final UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/login")
    public ResponseEntity<String> registerUser(final @RequestBody UserDTO userDTO){
        if(Objects.isNull(userDTO)){
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).build();
        }
        String generatedToken = userService.createUser(userDTO);
        return generatedToken != null ?
                ResponseEntity.status(HttpStatus.CREATED).body(generatedToken)
                : ResponseEntity.status(HttpStatus.METHOD_NOT_ALLOWED).build();
    }

    @GetMapping("/loginToApp")
    public ResponseEntity<User> loginUser(final UserDTO userDTO, final Authentication authentication){
        User principal = (User) authentication.getPrincipal();
        if(principal!=null) {
            User userByLogin = userService.findUserByLogin(principal.getLogin());
            if(Objects.isNull(userByLogin)) {
                    return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
            }
            return ResponseEntity.ok(userByLogin);
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }


}
