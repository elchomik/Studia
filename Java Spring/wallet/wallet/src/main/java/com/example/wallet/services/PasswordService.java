package com.example.wallet.services;

import com.example.wallet.readonly.Password;
import com.example.wallet.readonly.User;
import com.example.wallet.repositories.PasswordRepository;
import com.example.wallet.repositories.UserRepository;
import com.example.wallet.webui.PasswordDTO;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class PasswordService {
    private final PasswordRepository passwordRepository;
    private final UserRepository userRepository;
    private final UserAndPasswordMappingService userAndPasswordMappingService;

    public PasswordService(final PasswordRepository passwordRepository, UserRepository userRepository, UserAndPasswordMappingService userAndPasswordMappingService) {
        this.passwordRepository = passwordRepository;
        this.userRepository = userRepository;
        this.userAndPasswordMappingService = userAndPasswordMappingService;
    }

    public Password createPasswordInWallet(final PasswordDTO passwordDTO){
        final Optional<User> currentUser = userRepository.findById(passwordDTO.getUserId());
        if(currentUser.isEmpty()) return new Password();
        final Password newPassword = userAndPasswordMappingService.mapToPassword(passwordDTO);
        return passwordRepository.save(newPassword);
    }
}
