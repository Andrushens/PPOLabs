import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/views/all_notes/all_notes_cubit.dart';
import 'package:notes/views/note/note_screen.dart';
import 'package:notes/views/widgets/choose_label_dialog.dart';
import 'package:notes/views/widgets/note_container.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllNotesCubit>(
      create: (_) => AllNotesCubit(),
      child: BlocBuilder<AllNotesCubit, AllNotesState>(
        builder: (context, state) {
          if (!state.isInited) {
            context.read<AllNotesCubit>().init();
          }
          return GestureDetector(
            onTap: () {
              context.read<AllNotesCubit>().unselectAll();
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return ChooseLabeLdialog(
                            possibleLabels: state.possibleLabels,
                            currentLabels: state.currentLabels,
                            onChanged:
                                context.read<AllNotesCubit>().updateLabel,
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.label_outline,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IconButton(
                      onPressed: state.sortedByDate
                          ? context.read<AllNotesCubit>().sortByTitle
                          : context.read<AllNotesCubit>().sortByDate,
                      icon: Icon(
                        state.sortedByDate
                            ? Icons.sort_by_alpha
                            : Icons.date_range,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 4,
                  childAspectRatio: 1.2,
                  children: state.showNotes
                      .map(
                        (note) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: NoteContainer(
                            note: note,
                            isSelected: state.selectedNotesIds.contains(
                              note.id,
                            ),
                            onTap: state.selectedNotesIds.isNotEmpty
                                ? state.selectedNotesIds.contains(note.id)
                                    ? () {
                                        context
                                            .read<AllNotesCubit>()
                                            .unselectNote(note);
                                      }
                                    : () {
                                        context
                                            .read<AllNotesCubit>()
                                            .selectNote(note);
                                      }
                                : () async {
                                    var newNote =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NoteScreen(
                                            note: note,
                                            heroTag: note.id.toString(),
                                          );
                                        },
                                      ),
                                    );
                                    context
                                        .read<AllNotesCubit>()
                                        .updateNote(newNote);
                                  },
                            onLongPress: () {
                              context.read<AllNotesCubit>().selectNote(note);
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              floatingActionButton: state.selectedNotesIds.isNotEmpty
                  ? FloatingActionButton(
                      onPressed: context.read<AllNotesCubit>().deleteNotes,
                      backgroundColor: const Color(0xFFFFDAC7),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.brown,
                        size: 30,
                      ),
                    )
                  : FloatingActionButton(
                      onPressed: () async {
                        var note = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NoteScreen(),
                          ),
                        );
                        context.read<AllNotesCubit>().addNote(note);
                      },
                      backgroundColor: const Color(0xFFFFDAC7),
                      child: const Icon(
                        Icons.add,
                        color: Colors.brown,
                        size: 35,
                      ),
                    ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                color: const Color(0xFFFFDAC7),
                child: Container(height: 50),
              ),
            ),
          );
        },
      ),
    );
  }
}
