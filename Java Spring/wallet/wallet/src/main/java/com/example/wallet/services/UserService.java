package com.example.wallet.services;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.example.wallet.readonly.AuthenticatedUser;
import com.example.wallet.readonly.UnAuthenticatedUser;
import com.example.wallet.readonly.User;
import com.example.wallet.repositories.UserRepository;
import com.example.wallet.webui.UpdateMasterPasswordDTO;
import com.example.wallet.webui.UserDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {

    private final UserRepository userRepository;
    private final UserAndPasswordMappingService userUserAndPasswordMappingService;
    private final String secret;
    private final long expirationTime;
    public UserService(final UserRepository userRepository, final
    UserAndPasswordMappingService userUserAndPasswordMappingService,
                       final @Value("${jwt.secret}") String secret,
                       final @Value("${jwt.expirationTime}") long expirationTime) {
        this.userRepository = userRepository;
        this.userUserAndPasswordMappingService = userUserAndPasswordMappingService;
        this.secret = secret;
        this.expirationTime = expirationTime;
    }

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    public User getUser(final Integer userId){
        return userRepository.findById(userId).orElseThrow();
    }

    public String createUser(final UserDTO userDTO){
        final User createdUser = userUserAndPasswordMappingService.mapToUser(userDTO);
        userRepository.save(createdUser);
        UserDetails userDetails = loadUserByUsername(createdUser.getLogin());
        return getUserToken(userDetails,createdUser);
    }

    public User updatedPassword(final Integer userId, final UpdateMasterPasswordDTO updateMasterPasswordDTO) {
        Optional<User> currentUser= userRepository.findById(userId);
        if(currentUser.isEmpty()){
            return new User();
        }
       User updatedUser = new User(userId,currentUser.get().getLogin(), updateMasterPasswordDTO.getPassword(), updateMasterPasswordDTO.getSalt(), currentUser.get().isPasswordKeptAsHash());
        return userRepository.save(updatedUser);
    }

    public UserDetails loginUser(final UserDTO userDTO) {
        return loadUserByUsername(userDTO.getLogin());
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
       User user = userRepository.findUserByLogin(username);
       if(Objects.isNull(user)){
          return new UnAuthenticatedUser();
       }
       return new AuthenticatedUser(user);
    }

    public User findUserByLogin(final String login){
        return userRepository.findUserByLogin(login);
    }

    private String getUserToken(final UserDetails userDetails,final User createdUser){
        return JWT.create()
                .withSubject(userDetails.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis()+ expirationTime))
                .sign(Algorithm.HMAC512(secret));
    }

}
