package com.example.wallet.repositories;

import com.example.wallet.readonly.Password;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PasswordRepository extends JpaRepository<Password, Integer> {

    @Query(value = "SELECT p FROM  Password p WHERE p.id = :userId")
    List<Password> findAllPasswordsByUserId(final @Param("userId") Integer userId);
}
