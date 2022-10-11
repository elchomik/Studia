package com.example.wallet.services;

import com.example.wallet.readonly.User;
import com.example.wallet.webui.UserDTO;
import org.springframework.stereotype.Component;

@Component
public class UserMappingService {

    User mapToUser(final UserDTO userDTO){
       return new User(userDTO.getLogin(), userDTO.getPasswordHash(), userDTO.getSalt(), userDTO.isPasswordKeptAsHash());
    }
}
