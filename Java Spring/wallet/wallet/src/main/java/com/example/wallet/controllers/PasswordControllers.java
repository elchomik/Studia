package com.example.wallet.controllers;

import com.example.wallet.privilleges.roles.IsAuthenticatedUser;
import com.example.wallet.readonly.Password;
import com.example.wallet.services.PasswordService;
import com.example.wallet.webui.PasswordDTO;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import java.util.Objects;


@RestController
@RequestMapping("/passwords")
public class PasswordControllers {

    private final PasswordService passwordService;

    public PasswordControllers(PasswordService passwordService) {
        this.passwordService = passwordService;
    }

    @PostMapping
    @IsAuthenticatedUser
    public ResponseEntity<Password> createPassword(final @RequestBody PasswordDTO passwordDTO,
                                                   final Authentication authentication){
        Password passwordInWallet = passwordService.createPasswordInWallet(passwordDTO);
        if(Objects.isNull(passwordInWallet.getId())){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
       return ResponseEntity.status(HttpStatus.CREATED).body(passwordInWallet);
    }
}
