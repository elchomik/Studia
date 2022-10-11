package com.example.wallet.webui;

import java.io.Serializable;

public class UpdateMasterPasswordDTO implements Serializable {

    private final String password;
    private final String salt;

    public UpdateMasterPasswordDTO(final String password, final String salt) {
        this.password = password;
        this.salt = salt;
    }

    public String getPassword() {
        return password;
    }

    public String getSalt() {
        return salt;
    }
}
