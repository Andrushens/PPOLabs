import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/get_circle_color.dart';
import 'package:notes/views/note/note_cubit.dart';
import 'package:notes/views/widgets/choose_label_dialog.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({
    this.heroTag,
    this.note,
    Key? key,
  }) : super(key: key);

  final String? heroTag;
  final Note? note;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = note?.title ?? '';
    descriptionController.text = note?.description ?? '';
    return BlocProvider(
      create: (context) => NoteCubit(note),
      child: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          context.read<NoteCubit>().init(note);
          return Hero(
            tag: heroTag ?? '',
            child: SafeArea(
              child: GestureDetector(
                onTap: FocusScope.of(context).unfocus,
                child: Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                var title = context
                                    .read<NoteCubit>()
                                    .updateTitle(state.title);
                                if (note != null) {
                                  var newNote = note!.copyWith(
                                    title: title,
                                    description: state.description,
                                    labels: state.currentLabels,
                                  );
                                  Navigator.of(context).pop(newNote);
                                } else {
                                  Navigator.of(context).pop(
                                    Note(
                                      title: title,
                                      description: state.description,
                                      labels: state.currentLabels,
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return ChooseLabeLdialog(
                                        possibleLabels: state.possibleLabels,
                                        currentLabels: state.currentLabels,
                                        onChanged: context
                                            .read<NoteCubit>()
                                            .updateLabel,
                                      );
                                    });
                              },
                              icon: const Icon(Icons.label_outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: List.generate(
                              state.currentLabels.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: CircleAvatar(
                                    backgroundColor: getCircleColor(
                                      state.currentLabels[index],
                                    ),
                                    radius: 6,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              TextField(
                                onChanged:
                                    context.read<NoteCubit>().updateTitle,
                                maxLines: null,
                                controller: titleController,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Title',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(fontSize: 24),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                onChanged:
                                    context.read<NoteCubit>().updateDescription,
                                maxLines: null,
                                controller: descriptionController,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Description',
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
