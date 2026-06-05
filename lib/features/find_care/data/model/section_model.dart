import 'package:equatable/equatable.dart';

class SectionRowData extends Equatable {
  final String title;
  final String value;

  const SectionRowData({required this.title, required this.value});

  @override
  List<Object?> get props => [title, value];
}

class Appointment extends Equatable {
  final String id;
  final String title;
  final List<SectionRowData> content;

  const Appointment({
    required this.id,
    required this.title,
    required this.content,
  });

  Appointment copyWith({
    String? id,
    String? title,
    List<SectionRowData>? content,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [id, title, content];
}