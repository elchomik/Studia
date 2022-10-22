package com.example.wallet.services;

import com.example.wallet.cryptography.EncryptionAndDecryptionPasswords;
import com.example.wallet.readonly.AuthenticatedUser;
import com.example.wallet.readonly.Password;
import com.example.wallet.repositories.PasswordRepository;
import com.example.wallet.webui.PasswordDTO;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;

import static com.example.wallet.services.UserService.userPassword;

@Service
public class PasswordService {

    private static final String AES_CBC_PADDING = "AES/CBC/PKCS5Padding";
    private static final String AES_ECB_PKCS_5_PADDING = "AES/ECB/PKCS5Padding";

    private final PasswordRepository passwordRepository;

    public PasswordService(final PasswordRepository passwordRepository) {
        this.passwordRepository = passwordRepository;
    }

    public Password createPasswordInWallet(final PasswordDTO passwordDTO, final UserDetails user) throws Exception {
        final AuthenticatedUser authenticatedUser = (AuthenticatedUser) user;
        final String login = authenticatedUser.getUsername();
        final Integer userId = authenticatedUser.getAuthenitactedUserData().getUserId();
        final Key key = EncryptionAndDecryptionPasswords.generateKey(userPassword);
        if(passwordDTO.getHashAlgorithm().equals(AES_CBC_PADDING)){
            final String encryptedPassword = EncryptionAndDecryptionPasswords.enrypt(passwordDTO.getPassword(), key, AES_CBC_PADDING);
            return passwordRepository.save(new Password(encryptedPassword, passwordDTO.getWebAddress(),passwordDTO.getDescription(),login, userId));
        }
        if(passwordDTO.getHashAlgorithm().equals(AES_ECB_PKCS_5_PADDING)){
            final String encryptedPassword = EncryptionAndDecryptionPasswords.enrypt(passwordDTO.getPassword(), key, AES_ECB_PKCS_5_PADDING);
            return passwordRepository.save(new Password(encryptedPassword, passwordDTO.getWebAddress(),passwordDTO.getDescription(),login, userId));
        }
        return passwordRepository.save(new Password(passwordDTO.getPassword(),
                passwordDTO.getWebAddress(),
                passwordDTO.getDescription(), login, userId));
    }
}
