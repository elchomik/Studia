package com.example.wallet.services;

import com.example.wallet.readonly.Password;
import com.example.wallet.readonly.User;
import com.example.wallet.webui.PasswordDTO;
import com.example.wallet.webui.UserDTO;
import org.springframework.stereotype.Component;

@Component
public class UserAndPasswordMappingService {

    User mapToUser(final UserDTO userDTO){
       return new User(userDTO.getLogin(), userDTO.getPasswordHash(), userDTO.getSalt(), userDTO.isPasswordKeptAsHash());
    }

    Password mapToPassword(final PasswordDTO passwordDTO){
        return new Password(passwordDTO.getPassword(), passwordDTO.getWebAddress(), passwordDTO.getDescription(),
                passwordDTO.getDescription(), passwordDTO.getUserId());
    }
}
