package com.example.app.readonly;

import org.springframework.security.core.userdetails.UserDetails;

public class AccountProjection {

    private final UserDetails account;
    private final String generatedToken;

    public AccountProjection(final UserDetails account, final String generatedToken) {
        this.account = account;
        this.generatedToken = generatedToken;
    }

    public UserDetails getAccount() {
        return account;
    }

    public String getGeneratedToken() {
        return generatedToken;
    }
}
