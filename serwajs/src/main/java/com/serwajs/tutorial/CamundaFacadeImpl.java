package com.serwajs.tutorial;

import org.camunda.bpm.engine.*;
import org.camunda.bpm.engine.authorization.Groups;
import org.camunda.bpm.engine.identity.Group;
import org.camunda.bpm.engine.identity.User;
import org.camunda.bpm.engine.runtime.ActivityInstance;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.runtime.ProcessInstanceWithVariables;
import org.camunda.bpm.engine.task.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Optional;


@Service
public class CamundaFacadeImpl implements CamundaFacade {
    private static final Logger LOGGER = LoggerFactory.getLogger(CamundaFacadeImpl.class);
    private static final String ADMIN = "admin";

    private final ProcessEngine processEngine;

    public CamundaFacadeImpl(final ProcessEngine processEngine) {
        this.processEngine = processEngine;
    }


    @Override
    public String startProcessById(final String key) {
        RuntimeService runtimeService = getRuntimeService();
        try {
            ProcessInstance processInstance = runtimeService.startProcessInstanceByKey(key);
            return processInstance.getId();
        } catch (ProcessEngineException e) {
            LOGGER.error(String.format(e.getMessage()));
            throw new RuntimeException("Process couldn't be started");
        }
    }

    @Override
    public boolean isProcessInstanceIsRunning(String processInstanceId) {
        RuntimeService runtimeService = getRuntimeService();
        ActivityInstance activityInstance = runtimeService.getActivityInstance(processInstanceId);
        return activityInstance != null;
    }

    @Override
    public String startProcessBeforeOverthrowMonarchy(String key) {
        RuntimeService runtimeService = getRuntimeService();
        try {
            ProcessInstanceWithVariables monarchyId = runtimeService.createProcessInstanceByKey(key)
                    .startBeforeActivity("Monarchy_ID")
                    .executeWithVariablesInReturn();
            Task overthrowMonarchyTask = getTaskService().createTaskQuery().active().processInstanceId(monarchyId.getProcessInstanceId())
                    .singleResult();
            getTaskService().complete(overthrowMonarchyTask.getId());
            return monarchyId.getProcessInstanceId();
        } catch (ProcessEngineException e) {
            LOGGER.error(e.getMessage());
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public String startProcessBeforeTaxi(String key) {
        RuntimeService runtimeService = getRuntimeService();
        try {
            ProcessInstance taxiId = runtimeService.createProcessInstanceByKey(key)
                    .startBeforeActivity("Taxi_ID")
                    .execute();
            return taxiId.getId();
        } catch (ProcessEngineException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    public String startProcessBeforeDeparture(String key) {
        RuntimeService runtimeService = getRuntimeService();
        Map<String, Object> variables = Map.of("country", "France",
                "money", 1000);
        try{
            ProcessInstance execute = runtimeService.createProcessInstanceByKey(key)
                    .startBeforeActivity("say-hello")
                    .setVariablesLocal(variables)
                    .execute();
            return execute.getId();
        }catch (ProcessEngineException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @Override
    @Transactional
    public Optional<String> createUser(String userId) {
        final boolean isUserAlreadyExists = isUserAlreadyExists(userId);
        if (isUserAlreadyExists) {
            return Optional.empty();
        }

        final IdentityService identityService = getIdentityService();
        User user = identityService.newUser(userId);
        user.setFirstName(ADMIN + userId);
        user.setLastName(ADMIN + userId);
        user.setPassword("Admin123");
        user.setLastName("admin@camunda.org");
        identityService.saveUser(user);
        Group group = identityService.createGroupQuery().groupType(Groups.GROUP_TYPE_SYSTEM).singleResult();
        identityService.unlockUser(userId);
        identityService.setAuthenticatedUserId(userId);
        identityService.createMembership(userId, group.getId());
        return Optional.of(user.getId());
    }

    @Override
    public void deleteUser(String userId) {
        final boolean isUserAlreadyExists = isUserAlreadyExists(userId);
        if (isUserAlreadyExists) {
            getIdentityService().deleteUser(userId);
        }
    }

    private boolean isUserAlreadyExists(final String userId) {
        User user = getIdentityService().createUserQuery().userId(userId).singleResult();
        return user != null;
    }

    public RuntimeService getRuntimeService() {
        return processEngine.getRuntimeService();
    }

    private IdentityService getIdentityService() {
        return processEngine.getIdentityService();
    }

    public TaskService getTaskService() {
        return processEngine.getTaskService();
    }
}
