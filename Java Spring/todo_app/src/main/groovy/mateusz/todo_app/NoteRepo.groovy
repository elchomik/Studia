package mateusz.todo_app

import org.springframework.data.jpa.repository.JpaRepository

interface NoteRepo extends JpaRepository<Note, Integer> {

}