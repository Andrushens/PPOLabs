part of 'all_notes_cubit.dart';

class AllNotesState extends Equatable {
  final List<Note> notes;
  final List<Note> showNotes;
  final List<String> selectedNotesIds;
  final bool isSearchMode;
  final bool sortedByDate;
  final List<String> possibleLabels;
  final List<String> currentLabels;
  final bool isInited;

  const AllNotesState({
    required this.possibleLabels,
    this.notes = const [],
    this.showNotes = const [],
    this.selectedNotesIds = const [],
    this.currentLabels = const [],
    this.isSearchMode = false,
    this.sortedByDate = true,
    this.isInited = false,
  });

  AllNotesState copyWith({
    List<Note>? notes,
    List<Note>? showNotes,
    List<String>? selectedNotesIds,
    List<String>? currentLabels,
    List<String>? possibleLabels,
    bool? isSearchMode,
    bool? sortedByDate,
    bool? isInited,
  }) {
    return AllNotesState(
      notes: notes ?? this.notes,
      showNotes: showNotes ?? this.showNotes,
      selectedNotesIds: selectedNotesIds ?? this.selectedNotesIds,
      isSearchMode: isSearchMode ?? this.isSearchMode,
      currentLabels: currentLabels ?? this.currentLabels,
      possibleLabels: possibleLabels ?? this.possibleLabels,
      sortedByDate: sortedByDate ?? this.sortedByDate,
      isInited: isInited ?? this.isInited,
    );
  }

  @override
  List<Object> get props {
    return [
      notes,
      showNotes,
      selectedNotesIds,
      isSearchMode,
      sortedByDate,
      isInited,
      currentLabels,
      possibleLabels,
    ];
  }
}
