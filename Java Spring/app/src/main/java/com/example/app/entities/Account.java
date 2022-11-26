package com.example.app.entities;

import com.sun.istack.NotNull;

import javax.persistence.*;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "accounts")
public class Account{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @NotNull
    private String username;
    @NotNull
    private String password;
    @NotNull
    private String email;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "accountId",insertable = false,updatable = false)
    private List<AccountRole> accountRoles;

    public Account() {
    }

    public Account(final String username, final String password, final String email) {
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public Integer getId() {
        return id;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Account account = (Account) o;
        return Objects.equals(id, account.id) && Objects.equals(username, account.username)
                && Objects.equals(password, account.password) && Objects.equals(email, account.email)
                && Objects.equals(accountRoles, account.accountRoles);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username, password, email, accountRoles);
    }
}
