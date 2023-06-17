package com.example.jiracloudconnection.model;

public enum JiraIssueTypes {

    BUG(10004L),
    EPIK(10002L),
    STORY(10005L),
    TASK(10001L);

    private final Long issueId;

    JiraIssueTypes(Long issueId) {
        this.issueId = issueId;
    }

    public Long getIssueId() {
        return issueId;
    }
}
