part of 'all_notes_cubit.dart';

class AllNotesState extends Equatable {
  final List<Note> notes;
  final List<String> selectedNotesIds;
  final bool isSearchMode;

  const AllNotesState({
    this.notes = const [],
    this.selectedNotesIds = const [],
    this.isSearchMode = false,
  });

  AllNotesState copyWith({
    List<Note>? notes,
    List<String>? selectedNotesIds,
    bool? isSearchMode,
  }) {
    return AllNotesState(
      notes: notes ?? this.notes,
      selectedNotesIds: selectedNotesIds ?? this.selectedNotesIds,
      isSearchMode: isSearchMode ?? this.isSearchMode,
    );
  }

  @override
  List<Object> get props {
    return [
      notes,
      selectedNotesIds,
      isSearchMode,
    ];
  }
}
