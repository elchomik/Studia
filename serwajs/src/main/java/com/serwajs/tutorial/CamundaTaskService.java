package com.serwajs.tutorial;

import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.task.Task;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
class CamundaTaskService {
    private final CamundaFacade camundaFacade;

    CamundaTaskService(final CamundaFacade camundaFacade) {
        this.camundaFacade = camundaFacade;
    }

    void completeCurrentRunningTaskForProcessInstanceId(final String processInstanceId) {
        Task currentRunningTask = getCurrentRunningTask(processInstanceId);
        camundaFacade.getTaskService().claim(currentRunningTask.getId(), "adam");
        camundaFacade.getTaskService().complete(currentRunningTask.getId());
    }

    void completeAllRunningTaskByProcessId(final String key) {
        List<ProcessInstance> activeActivityIds = camundaFacade.getRuntimeService().createProcessInstanceQuery().active()
                .processDefinitionKey(key).list();

        activeActivityIds.forEach(processInstanceId -> {
            List<Task> activeTasks = camundaFacade.getTaskService().createTaskQuery().active().processInstanceId(processInstanceId.getProcessInstanceId())
                    .list();
            activeTasks.forEach(activeTask -> {
                camundaFacade.getTaskService().claim(activeTask.getId(), "adam");
                camundaFacade.getTaskService().complete(activeTask.getId());
            });
        });
    }
    private Task getCurrentRunningTask(final String processInstanceId) {
        return camundaFacade.getTaskService().createTaskQuery().processInstanceId(processInstanceId)
                .active().singleResult();
    }
}
