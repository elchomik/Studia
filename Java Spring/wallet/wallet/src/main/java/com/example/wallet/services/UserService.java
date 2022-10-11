package com.example.wallet.services;

import com.example.wallet.readonly.User;
import com.example.wallet.repositories.UserRepository;
import com.example.wallet.webui.UpdateMasterPasswordDTO;
import com.example.wallet.webui.UserDTO;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final UserMappingService userMappingService;

    public UserService(final UserRepository userRepository, UserMappingService userMappingService) {
        this.userRepository = userRepository;
        this.userMappingService = userMappingService;
    }

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    public User getUser(final Integer userId){
        return userRepository.findById(userId).orElseThrow();
    }

    public User createUser(final UserDTO userDTO){
        final User createdUser = userMappingService.mapToUser(userDTO);
        return userRepository.save(createdUser);
    }

    public User updatedPassword(final Integer userId, final UpdateMasterPasswordDTO updateMasterPasswordDTO) {
        Optional<User> currentUser= userRepository.findById(userId);
        if(currentUser.isEmpty()){
            throw new RuntimeException("User with "+ userId+ " not exists in database");
        }
       User updatedUser = new User(userId,currentUser.get().getLogin(), updateMasterPasswordDTO.getPassword(), updateMasterPasswordDTO.getSalt(), currentUser.get().isPasswordKeptAsHash());
        return userRepository.save(updatedUser);
    }
}
