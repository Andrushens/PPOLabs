import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit(Note? note)
      : super(NoteState(
          title: note?.title ?? '',
          description: note?.description ?? '',
        ));

  void init(Note? note) {
    if (state.title.isEmpty && state.description.isEmpty) {
      emit(state.copyWith(
        title: note?.title ?? '',
        description: note?.description ?? '',
      ));
    }
  }

  String updateTitle(String title) {
    var formatter = DateFormat('MMM dd, hh:mm');
    title = title.isEmpty ? formatter.format(DateTime.now()) : title;
    emit(state.copyWith(title: title));
    return title;
  }

  void updateDescription(String description) {
    emit(state.copyWith(description: description));
  }
}
