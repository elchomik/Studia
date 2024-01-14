package com.serwajs.tutorial;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/management")
class ManagementController {
    private static final String USER_ALREADY_EXISTS = "User already exists in camunda";

    private final CamundaFacade camundaFacade;

    ManagementController(final CamundaFacade camundaFacade) {
        this.camundaFacade = camundaFacade;
    }

    @PostMapping("/createUser")
    String createUser(final @RequestParam String userId) {
        return camundaFacade.createUser(userId).orElse(USER_ALREADY_EXISTS);
    }

    @DeleteMapping("/deleteUser/{userId}")
    void deleteUser(final @PathVariable String userId) {
        camundaFacade.deleteUser(userId);
    }
}
