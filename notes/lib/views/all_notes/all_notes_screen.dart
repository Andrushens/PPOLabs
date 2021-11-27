import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note.dart';
import 'package:notes/views/all_notes/all_notes_cubit.dart';
import 'package:notes/views/note/note_screen.dart';
import 'package:notes/views/widgets/note_container.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllNotesCubit>(
      create: (_) => AllNotesCubit(),
      child: BlocBuilder<AllNotesCubit, AllNotesState>(
        builder: (context, state) {
          context.read<AllNotesCubit>().init();
          return GestureDetector(
            onTap: () {
              context.read<AllNotesCubit>().unselectAll();
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  // controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText: 'Enter tag',
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.3),
                        ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 2
                          : 4,
                  childAspectRatio: 1.3,
                  children: state.notes
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
                                        builder: (context) => NoteScreen(
                                          note: note,
                                          heroTag: note.id.toString(),
                                        ),
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
