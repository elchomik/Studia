package com.example.wallet.controllers;

import com.example.wallet.readonly.User;
import com.example.wallet.services.UserService;
import com.example.wallet.webui.UpdateMasterPasswordDTO;
import com.example.wallet.webui.UserDTO;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    public UserController(final UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/allUsers")
    public List<User> getAllUsers(){
        return userService.getAllUsers();
    }
    @GetMapping("/{userId}")
    public User getUser(final @PathVariable Integer userId){
        return userService.getUser(userId);
    }

    @PostMapping("/createUser")
    public User createUser(final @RequestBody UserDTO userDTO){
        return userService.createUser(userDTO);
    }

    @PutMapping("/changePassword/{userId}")
    public User changePassword(final @PathVariable Integer userId,final @RequestBody UpdateMasterPasswordDTO updateMasterPasswordDTO){
        return userService.updatedPassword(userId,updateMasterPasswordDTO);
    }
}
