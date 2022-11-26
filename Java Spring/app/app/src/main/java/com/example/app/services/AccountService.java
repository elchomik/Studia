package com.example.app.services;

import com.auth0.jwt.algorithms.Algorithm;
import com.example.app.entities.Account;
import com.example.app.readonly.AccountProjection;
import com.example.app.readonly.AccountRoles;
import com.example.app.readonly.AuthenticatedAccount;
import com.example.app.readonly.UnAuthenticatedAccount;
import com.example.app.repositories.AccountRepository;
import com.example.app.webui.AccountDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.auth0.jwt.JWT;

import java.util.*;


@Service
public class AccountService implements UserDetailsService {

    private final AccountRepository accountRepository;
    private final long expirationTime;
    private final String secret;

    public AccountService(final AccountRepository accountRepository,
                          final @Value("${jwt.expirationTime}") long expirationTime,
                          final @Value("${jwt.secret}") String secret) {
        this.accountRepository = accountRepository;
        this.expirationTime = expirationTime;
        this.secret = secret;
    }

    public Optional<Account> getSingleAccount(final Integer accountId){
        return accountRepository.findById(accountId);
    }

    public Set<Account> getAllAccounts(){
        return new HashSet<>(accountRepository.findAll());
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final Account account = accountRepository.findAccountByUsername(username);
        if(Objects.isNull(account)){
            return new UnAuthenticatedAccount();
        }
        return new AuthenticatedAccount(account);
    }

    public AccountProjection findAccountByLogin(final String login) {
        final UserDetails userDetails = loadUserByUsername(login);
        if(Objects.equals(userDetails.getAuthorities(), AccountRoles.UNAUTHENTICATED_ACCOUNT.name())){
            return new AccountProjection(userDetails,"");
        }
        final AuthenticatedAccount authenticatedAccount = (AuthenticatedAccount) userDetails;
        final String accountToken = getAccountToken(authenticatedAccount);
        return new AccountProjection(userDetails, accountToken);
    }

    private String getAccountToken(final AuthenticatedAccount authenticatedAccount) {
        final String login = authenticatedAccount.getAccountData().getUsername();
        return JWT.create().withSubject(login)
                .withExpiresAt(new Date(System.currentTimeMillis() + expirationTime))
                .sign(Algorithm.HMAC512(secret));
    }

    public Account createAccount(final AccountDTO accountDTO) {
        return accountRepository.save(new Account(accountDTO.getUsername(),
                accountDTO.getPassword(), accountDTO.getEmail()));
    }
}
