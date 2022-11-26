package com.example.app.controllers;

import com.example.app.entities.Account;
import com.example.app.readonly.AccountProjection;
import com.example.app.services.AccountService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import java.util.Optional;
import java.util.Set;

@RestController
@RequestMapping("/accounts")
public class AccountController {

    private final AccountService accountService;

    public AccountController(final AccountService accountService) {
        this.accountService = accountService;
    }

    @GetMapping("/{accountId}")
    public ResponseEntity<Account> getSingleAccount(@PathVariable final Integer accountId,
                                                    final Authentication authentication){
        final AccountProjection accountProjection = (AccountProjection) authentication.getPrincipal();
        final UserDetails account = accountProjection.getAccount();
        if(account.isEnabled()){
            final Optional<Account> singleAccount = accountService.getSingleAccount(accountId);
            if (singleAccount.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(singleAccount.get());
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }

    @GetMapping
    public ResponseEntity<Set<Account>> getAllAccounts(final Authentication authentication){
        final AccountProjection accountProjection = (AccountProjection) authentication.getPrincipal();
        final UserDetails account = accountProjection.getAccount();
        if(account.isEnabled()) {
            final Set<Account> allAccounts = accountService.getAllAccounts();
            if (allAccounts.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(allAccounts);
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }
}
