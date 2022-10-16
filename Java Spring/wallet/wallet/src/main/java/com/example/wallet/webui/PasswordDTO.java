package com.example.wallet.webui;

import java.io.Serializable;

public class PasswordDTO implements Serializable {

    private final String password;
    private final Integer userId;
    private final String webAddress;
    private final String description;
    private final String login;

    public PasswordDTO(String password, Integer userId, String webAddress, String description, String login) {
        this.password = password;
        this.userId = userId;
        this.webAddress = webAddress;
        this.description = description;
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public Integer getUserId() {
        return userId;
    }

    public String getWebAddress() {
        return webAddress;
    }

    public String getDescription() {
        return description;
    }

    public String getLogin() {
        return login;
    }
}
