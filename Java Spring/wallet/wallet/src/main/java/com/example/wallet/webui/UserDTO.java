package com.example.wallet.webui;

import java.io.Serializable;

public class UserDTO implements Serializable {

    private final String salt;
    private final String login;
    private final String passwordHash;
    private final boolean isPasswordKeptAsHash;

    public UserDTO(final String salt, final String login, final String passwordHash, final boolean isPasswordKeptAsHash) {
        this.salt = salt;
        this.login = login;
        this.passwordHash = passwordHash;
        this.isPasswordKeptAsHash = isPasswordKeptAsHash;
    }

    public String getSalt() {
        return salt;
    }

    public String getLogin() {
        return login;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public boolean isPasswordKeptAsHash() {
        return isPasswordKeptAsHash;
    }
}
