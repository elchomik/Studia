package com.example.wallet.services;

import com.example.wallet.cryptography.EncryptionAndDecryptionPasswords;
import com.example.wallet.readonly.AuthenticatedUser;
import com.example.wallet.readonly.Password;
import com.example.wallet.repositories.PasswordRepository;
import com.example.wallet.webui.PasswordDTO;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.ArrayList;
import java.util.List;

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
            return passwordRepository.save(new Password(encryptedPassword, passwordDTO.getWebAddress(),AES_CBC_PADDING,login, userId));
        }
        if(passwordDTO.getHashAlgorithm().equals(AES_ECB_PKCS_5_PADDING)){
            final String encryptedPassword = EncryptionAndDecryptionPasswords.enrypt(passwordDTO.getPassword(), key, AES_ECB_PKCS_5_PADDING);
            return passwordRepository.save(new Password(encryptedPassword, passwordDTO.getWebAddress(),AES_ECB_PKCS_5_PADDING,login, userId));
        }
        return passwordRepository.save(new Password(passwordDTO.getPassword(),
                passwordDTO.getWebAddress(),
                passwordDTO.getDescription(), login, userId));
    }

    public List<String> getAllPasswords(final Integer userId, final boolean shouldDecryptPassword) throws Exception {
        final List<Password> allPasswordsByUserId = passwordRepository.findAllPasswordsByUserId(userId);
        if(shouldDecryptPassword){
            final Key key = EncryptionAndDecryptionPasswords.generateKey(userPassword);
            final List<String> decryptedPasswords= new ArrayList<>();
            allPasswordsByUserId.forEach(password -> {
                try {
                    final String decryptedPassword = EncryptionAndDecryptionPasswords.decrypt(password.getPasswd(), key, password.getDescription());
                    decryptedPasswords.add(decryptedPassword);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });
            return decryptedPasswords;
        }
        return allPasswordsByUserId.stream().map(Password::getPasswd).toList();
    }
}
