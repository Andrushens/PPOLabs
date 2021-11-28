part of 'note_cubit.dart';

class NoteState extends Equatable {
  final String title;
  final String description;
  final List<String> possibleLabels;
  final List<String> currentLabels;
  final bool isInited;

  const NoteState({
    required this.title,
    required this.description,
    required this.possibleLabels,
    required this.currentLabels,
    this.isInited = false,
  });

  NoteState copyWith({
    String? title,
    String? description,
    List<String>? possibleLabels,
    List<String>? currentLabels,
    bool? isInited,
  }) {
    return NoteState(
      title: title ?? this.title,
      description: description ?? this.description,
      possibleLabels: possibleLabels ?? this.possibleLabels,
      currentLabels: currentLabels ?? this.currentLabels,
      isInited: isInited ?? this.isInited,
    );
  }

  @override
  List<Object> get props {
    return [
      title,
      description,
      possibleLabels,
      currentLabels,
      isInited,
    ];
  }
}
