package com.example.wallet.controllers;

import com.example.wallet.privilleges.roles.IsAuthenticatedUser;
import com.example.wallet.readonly.User;
import com.example.wallet.services.UserService;
import com.example.wallet.webui.UpdateMasterPasswordDTO;
import com.example.wallet.webui.UserDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    public UserController(final UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/allUsers")
    @IsAuthenticatedUser
    public List<User> getAllUsers(final Authentication authentication){
        String principal = (String) authentication.getPrincipal();
        return userService.getAllUsers();
    }
    @GetMapping("/{userId}")
    @IsAuthenticatedUser
    public User getUser(final @PathVariable Integer userId, final Authentication authentication){
        String prinicipal = (String) authentication.getPrincipal();
        return userService.getUser(userId);
    }

    @PutMapping("/changePassword/{userId}")
    @IsAuthenticatedUser
    public ResponseEntity<User> changePassword(final @PathVariable Integer userId,
                                               final @RequestBody UpdateMasterPasswordDTO updateMasterPasswordDTO,
                                               final Authentication authentication){
        String prinicpal = (String) authentication.getPrincipal();
        User user = userService.updatedPassword(userId, updateMasterPasswordDTO);
        if(Objects.isNull(user.getUserId())){
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        return ResponseEntity.ok(user);
    }
}
