package com.example.wallet.readonly;

import javax.persistence.*;

@Entity
@Table(name = "passwordUser")
public class Password {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer passwordId;
    private String passwd;
    private String webAddress;
    private String description;
    private String login;

    @Column(name = "userId")
    private Integer id;

    public Password(){

    }

    public Password(String passwd, String webAddress, String description, String login, Integer id) {
        this.passwd = passwd;
        this.webAddress = webAddress;
        this.description = description;
        this.login = login;
        this.id = id;
    }

    public Integer getPasswordId() {
        return passwordId;
    }

    public String getPasswd() {
        return passwd;
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

    public Integer getId() {
        return id;
    }
}
