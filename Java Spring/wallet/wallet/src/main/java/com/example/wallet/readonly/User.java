package com.example.wallet.readonly;


import javax.persistence.*;

@Entity
@Table(name = "appUser")
public class User{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    private String login;
    private String passwordHash;
    private String salt;
    private boolean isPasswordKeptAsHash;

    public User(String login, String passwordHash, String salt, boolean isPasswordKeptAsHash) {
        this.login = login;
        this.passwordHash = passwordHash;
        this.salt = salt;
        this.isPasswordKeptAsHash = isPasswordKeptAsHash;
    }

    public User() {

    }

    public User(final Integer userId, final String login, final String passwordHash,final  String salt, final boolean isPasswordKeptAsHash) {
        this.userId = userId;
        this.login = login;
        this.passwordHash = passwordHash;
        this.salt = salt;
        this.isPasswordKeptAsHash = isPasswordKeptAsHash;
    }

    public Integer getUserId() {
        return userId;
    }

    public String getLogin() {
        return login;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public String getSalt() {
        return salt;
    }

    public boolean isPasswordKeptAsHash() {
        return isPasswordKeptAsHash;
    }

    public void setPasswordHash(final String passwordHash) {
        this.passwordHash = passwordHash;
    }
}
