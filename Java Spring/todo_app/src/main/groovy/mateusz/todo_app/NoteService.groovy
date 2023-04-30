package mateusz.todo_app

interface NoteService {

    List<Note> findAll()

    Note findById(Integer noteId)

    Note saveNote(Note note)

    Note updateNote(Note note)

    void deleteNote(Integer noteId)
}
