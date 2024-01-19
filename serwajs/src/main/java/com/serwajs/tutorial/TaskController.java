package com.serwajs.tutorial;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/tasks")
class TaskController {
    private final CamundaTaskService camundaTaskService;

    TaskController(final CamundaTaskService camundaTaskService) {
        this.camundaTaskService = camundaTaskService;
    }

    @PostMapping("/complete/single")
    void completeSingleTask(@RequestParam final String processInstanceId) {
        camundaTaskService.completeCurrentRunningTaskForProcessInstanceId(processInstanceId);
    }

    @PostMapping("/completeAll")
    void completeAllTasks(@RequestParam final String key) {
        camundaTaskService.completeAllRunningTaskByProcessId(key);
    }
}
