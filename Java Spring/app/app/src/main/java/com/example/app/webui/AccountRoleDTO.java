package com.example.app.webui;

import java.io.Serializable;

public class AccountRoleDTO implements Serializable {

    private final String name;
    private final Integer accountId;

    public AccountRoleDTO(final String name, final Integer accountId) {
        this.name = name;
        this.accountId = accountId;
    }

    public String getName() {
        return name;
    }

    public Integer getAccountId() {
        return accountId;
    }
}
