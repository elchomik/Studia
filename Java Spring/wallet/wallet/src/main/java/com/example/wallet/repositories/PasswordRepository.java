package com.example.wallet.repositories;

import com.example.wallet.readonly.Password;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PasswordRepository extends JpaRepository<Password, Integer> {
}
