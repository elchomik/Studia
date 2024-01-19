package com.serwajs.tutorial;

import org.camunda.bpm.engine.RuntimeService;
import org.camunda.bpm.engine.TaskService;

import java.util.Optional;

public interface CamundaFacade {

    String startProcessById(final String key);

    boolean isProcessInstanceIsRunning(final String processInstanceId);

    String startProcessBeforeOverthrowMonarchy(final String key);

    String startProcessBeforeTaxi(final String key);

    String startProcessBeforeDeparture(final String key);

    Optional<String> createUser(final String userId);

    void deleteUser(final String userId);

    TaskService getTaskService();

    RuntimeService getRuntimeService();
}
