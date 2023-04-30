package mateusz.todo_app

import io.restassured.RestAssured
import io.restassured.response.Response
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.Test
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType

import static org.junit.jupiter.api.Assertions.assertEquals
import static org.junit.jupiter.api.Assertions.assertTrue

class NoteControllerTest {

    static API_ROOT = "http://localhost:8080/note"
    static Integer readingNoteId
    static Integer writingNoteId

    @BeforeAll
    static void populateDummyData() {
        def readingNote = new Note(task: 'Reading', isCompleted: false)
        def writingNote = new Note(task: 'Writing', isCompleted: false)

        final Response readingResponse = RestAssured
                .given()
                .contentType(MediaType.APPLICATION_JSON_VALUE)
                .body(readingNote).post(API_ROOT)

        def noteResponse = readingResponse.as Note.class
        readingNoteId = noteResponse.getId()

        final Response writingResponse = RestAssured
                .given()
                .contentType(MediaType.APPLICATION_JSON_VALUE)
                .body(writingNote)
                .post(API_ROOT)

        def writingNoteResponse = writingResponse.as Note.class
        writingNoteId = writingNoteResponse.getId()
    }

    @Test
    void whenGetAllTodoList_thenOk() {
        final Response response = RestAssured.get(API_ROOT)
        assertEquals HttpStatus.OK.value(), response.getStatusCode()
        assertTrue response.as(List.class).size() > 0
    }


    @Test
    void whenGetNoteById_thenOk() {
        final Response response = RestAssured.get("$API_ROOT/$readingNoteId")

        assertEquals HttpStatus.OK.value(), response.getStatusCode()
        Note noteResponse = response.as Note.class
        assertEquals readingNoteId, noteResponse.getId()
    }

    @Test
    void whenUpdateNoteById_thenOk() {
        def note = new Note(id: readingNoteId, isCompleted: true)
        final Response response = RestAssured
                .given()
                .contentType(MediaType.APPLICATION_JSON_VALUE)
                .body(note).put(API_ROOT)

        assertEquals HttpStatus.OK.value(), response.getStatusCode()
        def noteResponse = response.as Note.class
        assertTrue noteResponse.getIsCompleted()
    }

    @Test
    void whenDeleteNoteById_thenOk() {
        final Response response = RestAssured
                .given()
                .delete("$API_ROOT/$writingNoteId")
        assertEquals HttpStatus.OK.value(), response.getStatusCode()
    }

    @Test
    void whenSaveNote_thenOk() {
        def note = new Note(task: 'something', isCompleted: false)
        final Response response = RestAssured
                .given()
                .contentType(MediaType.APPLICATION_JSON_VALUE)
                .body(note)
                .post(API_ROOT)
        assertEquals HttpStatus.OK.value(), response.getStatusCode()
    }
}
