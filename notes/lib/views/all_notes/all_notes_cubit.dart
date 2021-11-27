import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/db_provider.dart';

part 'all_notes_state.dart';

class AllNotesCubit extends Cubit<AllNotesState> {
  AllNotesCubit() : super(const AllNotesState());

  void init() async {
    var notes = await DatabaseProvider.fetchNotes()
      ..sort((a, b) => a.title.compareTo(b.title));
    //TODO sort by date
    if (notes != state.notes) {
      emit(state.copyWith(
        notes: notes,
      ));
    }
  }

  void addNote(Note? note) {
    if (note is Note) {
      var notes = List<Note>.from(state.notes)..add(note);
      DatabaseProvider.insertNote(note);
      emit(state.copyWith(notes: notes));
    }
  }

  void updateNote(Note? note) {
    if (note is Note) {
      var notes = List<Note>.from(state.notes);
      var index = notes.indexOf(
        notes.where((element) => element.id == note.id).first,
      );
      DatabaseProvider.updateNote(note);
      notes[index] = note;
      emit(state.copyWith(notes: notes));
    }
  }

  void deleteNotes() {
    var notes = List<Note>.from(state.notes);
    var toDelete = List<Note>.from(
      notes.where(
        (element) => state.selectedNotesIds.contains(element.id),
      ),
    );
    for (var element in toDelete) {
      notes.remove(element);
      DatabaseProvider.deleteNote(element);
    }
    emit(state.copyWith(
      notes: notes,
      selectedNotesIds: [],
    ));
  }

  void selectNote(Note note) {
    var selectedNotesIds = List<String>.from(state.selectedNotesIds)
      ..add(note.id!);
    emit(state.copyWith(selectedNotesIds: selectedNotesIds));
  }

  void unselectNote(Note note) {
    var selectedNotesIds = List<String>.from(state.selectedNotesIds)
      ..remove(note.id!);
    emit(state.copyWith(selectedNotesIds: selectedNotesIds));
  }

  void unselectAll() {
    emit(state.copyWith(selectedNotesIds: []));
  }
}
