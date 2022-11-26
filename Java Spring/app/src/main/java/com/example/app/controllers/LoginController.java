package com.example.app.controllers;

import com.example.app.entities.Account;
import com.example.app.services.AccountService;
import com.example.app.webui.AccountDTO;
import com.example.app.readonly.AccountProjection;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@RestController
@RequestMapping
public class LoginController {

    private final AccountService accountService;

    public LoginController(final AccountService accountService) {
        this.accountService = accountService;
    }

    @PostMapping("/register")
    public ResponseEntity<Account> registerAccount(final @RequestBody AccountDTO accountDTO){
        if(Objects.isNull(accountDTO)) return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).build();
        final Account account = accountService.createAccount(accountDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(account);
    }

    @GetMapping("/loginToApp")
    public ResponseEntity<AccountProjection> loginToAccount(final AccountDTO accountDTO){
        final AccountProjection accountByLogin = accountService.findAccountByLogin(accountDTO.getUsername());
        if(Objects.isNull(accountByLogin)){
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
        return ResponseEntity.ok(accountByLogin);
    }
}
