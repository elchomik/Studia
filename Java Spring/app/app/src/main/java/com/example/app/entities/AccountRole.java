package com.example.app.entities;

import com.sun.istack.NotNull;

import javax.persistence.*;
import java.util.Objects;


@Entity
@Table(name = "account_roles")
public class AccountRole{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @NotNull
    private String name;
    @Column(name = "accountId")
    @NotNull
    private Integer accountId;

    public AccountRole() {
    }

    public AccountRole(final String name, final Integer accountId) {
        this.name = name;
        this.accountId = accountId;
    }

    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Integer getAccountId() {
        return accountId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AccountRole that = (AccountRole) o;
        return Objects.equals(id, that.id) && Objects.equals(name, that.name) && Objects.equals(accountId, that.accountId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, accountId);
    }
}
