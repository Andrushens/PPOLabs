import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Workout {
  String? id;
  final String name;
  final int prepareTime;
  final int workTime;
  final int restTime;
  final int cycles;
  final int sets;
  final Color color;

  Workout({
    this.id,
    required this.name,
    this.prepareTime = 15,
    this.workTime = 20,
    this.restTime = 10,
    this.cycles = 8,
    this.sets = 1,
    this.color = Colors.blue,
  }) {
    id = id ?? const Uuid().v1();
  }

  Workout copyWith({
    String? id,
    String? name,
    int? prepareTime,
    int? workTime,
    int? restTime,
    int? cycles,
    int? sets,
    Color? color,
  }) {
    return Workout(
      id: this.id,
      name: name ?? this.name,
      prepareTime: prepareTime ?? this.prepareTime,
      workTime: workTime ?? this.workTime,
      restTime: restTime ?? this.restTime,
      cycles: cycles ?? this.cycles,
      sets: sets ?? this.sets,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'prepareTime': prepareTime,
      'workTime': workTime,
      'restTime': restTime,
      'cycles': cycles,
      'sets': sets,
      'color': color.value,
    };
  }
}
