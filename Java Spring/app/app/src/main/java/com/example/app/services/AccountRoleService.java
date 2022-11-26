package com.example.app.services;

import com.example.app.entities.AccountRole;
import com.example.app.repositories.AccountRoleRepository;
import com.example.app.webui.AccountRoleDTO;
import org.springframework.stereotype.Service;


import java.util.Set;

@Service
public class AccountRoleService {

    private final AccountRoleRepository accountRoleRepository;

    public AccountRoleService(final AccountRoleRepository accountRoleRepository) {
        this.accountRoleRepository = accountRoleRepository;
    }

    public AccountRole createAccountRole(final AccountRoleDTO accountRoleDTO) {
        return accountRoleRepository.save(new AccountRole(accountRoleDTO.getName(),
                accountRoleDTO.getAccountId()));
    }

    public Set<AccountRole> getAllAccountRolesForCurrentUser(final Integer userId) {
        return accountRoleRepository.findAllAccountsRoleByAccountId(userId);
    }
}
