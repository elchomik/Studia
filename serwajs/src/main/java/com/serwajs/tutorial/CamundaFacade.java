package com.serwajs.tutorial;

import java.util.Optional;

public interface CamundaFacade {

    String startProcessById(final String key);

    boolean isProcessInstanceIsRunning(final String processInstanceId);

    Optional<String> createUser(final String userId);

    void deleteUser(final String userId);
}
