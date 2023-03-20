// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Note {
  int? id;
  String? title;
  String? content;
  String? date;
  static const kID = "id";
  static const kTitle = "title";
  static const kContent = "content";
  static const kDate = "date";
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, date: $date)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ content.hashCode ^ date.hashCode;
  }
}
