import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/db_provider.dart';

part 'all_notes_state.dart';

class AllNotesCubit extends Cubit<AllNotesState> {
  AllNotesCubit()
      : super(const AllNotesState(
          possibleLabels: [
            'Very Important',
            'Important',
            'Not Very Important',
            'Bruh'
          ],
        ));

  void init() async {
    var notes = await DatabaseProvider.fetchNotes();
    if (notes != state.notes) {
      emit(state.copyWith(
        notes: notes,
        isInited: true,
      ));
      updateShowNotes();
    }
  }

  void addNote(Note? note) {
    if (note is Note) {
      var notes = List<Note>.from(state.notes)..add(note);
      DatabaseProvider.insertNote(note);
      emit(state.copyWith(notes: notes));
    }
    sort();
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
    sort();
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
    sort();
  }

  void selectNote(Note note) {
    var selectedNotesIds = List<String>.from(state.selectedNotesIds)
      ..add(note.id!);
    emit(state.copyWith(selectedNotesIds: selectedNotesIds));
  }

  void unselectNote(Note note) {
    var selectedNotesIds = List<String>.from(state.selectedNotesIds)
      ..remove(note.id);
    emit(state.copyWith(selectedNotesIds: selectedNotesIds));
  }

  void unselectAll() {
    emit(state.copyWith(selectedNotesIds: []));
  }

  void sort() {
    state.sortedByDate ? sortByDate() : sortByTitle();
  }

  void sortByTitle() {
    var notes = state.notes
      ..sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );
    emit(state.copyWith(
      notes: notes,
      sortedByDate: false,
    ));
    updateShowNotes();
  }

  void sortByDate() {
    var notes = state.notes
      ..sort(
        (a, b) => a.createdDate!.isAfter(b.createdDate!) ? 0 : 1,
      );
    emit(state.copyWith(
      notes: notes,
      sortedByDate: true,
    ));
    updateShowNotes();
  }

  void updateLabel(int index, bool value) {
    var current = List<String>.from(state.currentLabels);
    if (value) {
      current.add(state.possibleLabels[index]);
    } else {
      current.remove(state.possibleLabels[index]);
    }
    emit(state.copyWith(currentLabels: current));
    updateShowNotes();
  }

  void updateShowNotes() {
    var showNotes = <Note>[];
    if (state.currentLabels.isEmpty) {
      showNotes = state.notes;
    } else {
      for (var label in state.currentLabels) {
        for (var note in state.notes) {
          if (note.labels.contains(label)) {
            showNotes.add(note);
          }
        }
      }
    }
    emit(state.copyWith(showNotes: showNotes));
  }
}
