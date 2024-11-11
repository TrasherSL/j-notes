class Note {
  int? id;
  String title;     // Title of the note
  String content;   // Content of the note

  // Constructor to create a new Note
  Note({
    this.id,
    required this.title,
    required this.content,
  });

  // Convert a Note object into a Map object (useful for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  // Convert a Map object back into a Note object
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
