import 'package:uuid/uuid.dart';

class Note {
  String? id;
  final String title;
  final String description;
  final List<String> tags;
  DateTime? createdDate;
  //TODO date work incorrect

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.tags,
    this.createdDate,
  }) {
    id = id ?? const Uuid().v1();
    createdDate = createdDate ?? DateTime.now();
  }

  Note copyWith({
    String? title,
    String? description,
    List<String>? tags,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdDate': createdDate.toString(),
    };
  }
}
