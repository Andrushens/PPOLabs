part of 'note_cubit.dart';

class NoteState extends Equatable {
  final String title;
  final String description;

  const NoteState({
    required this.title,
    required this.description,
  });

  NoteState copyWith({
    String? title,
    String? description,
  }) {
    return NoteState(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props {
    return [title, description];
  }
}
