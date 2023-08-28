package com.example.jiracloudconnection.controller;

import com.example.jiracloudconnection.model.JiraIssue;
import com.example.jiracloudconnection.service.JiraService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/issue")
public class JiraIssueController {

    private final JiraService service;

    public JiraIssueController(JiraService service) {
        this.service = service;
    }

    @PostMapping("/create/bug")
    public String createBugOnBoard(final @RequestBody JiraIssue issue) {
        return service.createBug(issue);
    }

    @PostMapping("/create/task")
    public String createTaskOnBoard(final @RequestBody JiraIssue issue) {
        return service.createTask(issue);
    }

    @PostMapping("/create/story")
    public String createStoryOnBoard(final @RequestBody JiraIssue issue) {
        return service.createStory(issue);
    }

    @PostMapping("/create/epic")
    public String createEpicOnBoard(final @RequestBody JiraIssue issue) {
        return service.createEpic(issue);
    }

    @PostMapping("/create/subtask")
    public String createSubtaskForIssue() {
        return service.createSubtaskForIssue();
    }
}
