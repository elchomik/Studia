package mateusz.todo_app

import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.PutMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping('note')
class NoteController {

    final NoteService noteService

    NoteController(NoteService noteService) {
        this.noteService = noteService
    }

    @GetMapping
    List<Note> getAllNotes() {
        noteService.findAll()
    }

    @PostMapping
    Note saveNote(@RequestBody Note note) {
        noteService.saveNote note
    }

    @PutMapping
    Note updateNote(@RequestBody Note note) {
        noteService.updateNote note
    }

    @DeleteMapping('/{noteId}')
    deleteTodo(@PathVariable Integer noteId) {
        noteService.deleteNote noteId
    }

    @GetMapping("/{noteId}")
    Note getNoteById(@PathVariable Integer noteId) {
        noteService.findById noteId
    }
}
