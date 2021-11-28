import 'package:uuid/uuid.dart';

class Note {
  String? id;
  final String title;
  final String description;
  final List<String> labels;
  DateTime? createdDate;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.labels,
    this.createdDate,
  }) {
    id = id ?? const Uuid().v1();
    createdDate = createdDate ?? DateTime.now();
  }

  Note copyWith({
    String? title,
    String? description,
    DateTime? createdDate,
    List<String>? labels,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      labels: labels ?? this.labels,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdDate': createdDate.toString(),
      'labels': labels.join('-'),
    };
  }
}
