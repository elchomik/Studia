package com.example.app.controllers;

import com.example.app.entities.AccountRole;
import com.example.app.readonly.AccountProjection;
import com.example.app.services.AccountRoleService;
import com.example.app.webui.AccountRoleDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;


import java.util.Set;

@RestController
@RequestMapping("/accountRoles")
public class AccountRoleController {

    private final AccountRoleService accountRoleService;

    public AccountRoleController(final AccountRoleService accountRoleService) {
        this.accountRoleService = accountRoleService;
    }

    @PostMapping
    public ResponseEntity<AccountRole> createAccountRole(final @RequestBody AccountRoleDTO accountRoleDTO,
                                                         final Authentication authentication){
        final AccountProjection accountProjection = (AccountProjection) authentication.getPrincipal();
        final UserDetails account = accountProjection.getAccount();
        if(account.isEnabled()) {
            final AccountRole accountRole = accountRoleService.createAccountRole(accountRoleDTO);
            return ResponseEntity.status(HttpStatus.CREATED).body(accountRole);
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }

    @GetMapping("/allAccountRoles/{userId}")
    public ResponseEntity<Set<AccountRole>> getAllAccountRolesForCurrentUser(final @PathVariable Integer userId,
                                                                             final Authentication authentication) {
        final AccountProjection accountProjection = (AccountProjection) authentication.getPrincipal();
        final UserDetails account = accountProjection.getAccount();
        if (account.isEnabled()) {
            final Set<AccountRole> allAccountRolesForCurrentUser = accountRoleService
                    .getAllAccountRolesForCurrentUser(userId);
            if (allAccountRolesForCurrentUser.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.status(HttpStatus.FOUND).body(allAccountRolesForCurrentUser);
        }
        return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
    }
}
