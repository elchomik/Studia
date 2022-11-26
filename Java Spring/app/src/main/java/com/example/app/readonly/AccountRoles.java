package com.example.app.readonly;

public enum AccountRoles {
    AUTHENTICATED_ACCOUNT("AUTHENTICATED_ACCOUNT"),
    UNAUTHENTICATED_ACCOUNT("UNAUTHENTICATED_ACCOUNT");

    final String name;

    AccountRoles(final String name) {
        this.name = name;
    }
}
