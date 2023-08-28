package com.example.jiracloudconnection.service;

import com.atlassian.jira.rest.client.api.IssueRestClient;
import com.atlassian.jira.rest.client.api.JiraRestClient;
import com.atlassian.jira.rest.client.api.ProjectRestClient;
import com.atlassian.jira.rest.client.api.domain.Issue;
import com.atlassian.jira.rest.client.api.domain.IssueType;
import com.atlassian.jira.rest.client.api.domain.input.IssueInput;
import com.atlassian.jira.rest.client.api.domain.input.IssueInputBuilder;
import com.atlassian.jira.rest.client.internal.async.AsynchronousJiraRestClientFactory;
import com.example.jiracloudconnection.model.JiraIssue;
import io.atlassian.util.concurrent.Promise;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;

import static com.example.jiracloudconnection.model.JiraIssueTypes.*;

@Component
public class JiraService {

    private final String username;
    private final String passowrd;
    private final String jiraUrl;
    private final JiraRestClient jiraRestClient;


    public JiraService(@Value("${jira.username}") String username,
                       @Value("${jira.token}") String passowrd,
                       @Value("${jira.baseUrl}") String jiraUrl) {
        this.username = username;
        this.passowrd = passowrd;
        this.jiraUrl = jiraUrl;
        this.jiraRestClient = getJiraRestClient();
    }

    public String createBug(JiraIssue issue) {
        final IssueRestClient issueRestClient = jiraRestClient.getIssueClient();
        IssueInput newIssue = new IssueInputBuilder(issue.projectKey(), BUG.getIssueId(), issue.summary()).build();
        return issueRestClient.createIssue(newIssue).claim().getKey();
    }

    public String createTask(JiraIssue issue) {
        final IssueRestClient issueRestClient = jiraRestClient.getIssueClient();
        IssueInput newIssue = new IssueInputBuilder(issue.projectKey(), TASK.getIssueId(), issue.summary()).build();
        return issueRestClient.createIssue(newIssue).claim().getKey();
    }

    public String createStory(JiraIssue issue) {
        final IssueRestClient issueRestClient = jiraRestClient.getIssueClient();
        IssueInput newIssue = new IssueInputBuilder(issue.projectKey(), STORY.getIssueId(), issue.summary()).build();
        return issueRestClient.createIssue(newIssue).claim().getKey();
    }

    public String createSubtaskForIssue() {
        final IssueRestClient issueRestClient = jiraRestClient.getIssueClient();
        Issue claim = issueRestClient.getIssue("PROJ-7").claim();
        IssueInput test = new IssueInputBuilder().setProjectKey("PROJ")
                .setDescription("Test")
                .setIssueTypeId(SUBTASK.getIssueId())
                .setSummary("Summmmmmmary")
                .setFieldValue("parent", claim).build();

       return issueRestClient.createIssue(test).claim().getKey();
    }

    public String createEpic(JiraIssue issue) {
        IssueRestClient issueRestClient = jiraRestClient.getIssueClient();
        IssueInput newIssue = new IssueInputBuilder(issue.projectKey(), EPIK.getIssueId(), issue.summary()).build();
        return issueRestClient.createIssue(newIssue).claim().getKey();
    }

    private JiraRestClient getJiraRestClient() {
        return new AsynchronousJiraRestClientFactory()
                .createWithBasicHttpAuthentication(getJiraUri(), this.username, this.passowrd);
    }


    private URI getJiraUri() {
        return URI.create(this.jiraUrl);
    }
}
