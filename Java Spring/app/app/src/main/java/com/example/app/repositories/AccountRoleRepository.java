package com.example.app.repositories;

import com.example.app.entities.AccountRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import java.util.Set;

public interface AccountRoleRepository extends JpaRepository<AccountRole, Integer> {

    @Query(value = "SELECT a FROM AccountRole a WHERE a.accountId = :accountId")
    Set<AccountRole> findAllAccountsRoleByAccountId(final @Param("accountId") Integer accountId);

}
