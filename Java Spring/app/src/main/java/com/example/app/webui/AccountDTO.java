package com.example.app.webui;

import java.io.Serializable;

public class AccountDTO implements Serializable {

    private final String username;
    private final String password;
    private final String email;

    public AccountDTO(final String username, final String password, final String email) {
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }
}
