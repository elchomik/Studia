package mateusz.todo_app

import org.springframework.stereotype.Service

@Service
class NoteServiceImpl implements NoteService{

    private final NoteRepo noteRepo

    NoteServiceImpl(NoteRepo noteRepo) {
        this.noteRepo = noteRepo
    }

    @Override
    List<Note> findAll() {
        noteRepo.findAll()
    }

    @Override
    Note findById(Integer noteId) {
        noteRepo.findById noteId get()
    }

    @Override
    Note saveNote(Note note) {
        noteRepo.save note
    }

    @Override
    Note updateNote(Note note) {
        noteRepo.save note
    }

    @Override
    void deleteNote(Integer noteId) {
        noteRepo.deleteById noteId
    }
}

