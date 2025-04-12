class NoteModel {
  final int? id;
  final String txt;
  final String? description;

  NoteModel({this.id, required this.txt, required this.description});

  /// To Map
  Map<String, dynamic> toMap() {
    return {'id': id, 'txt': txt, 'description': description ?? ''};
  }

  /// Copy Witd
  NoteModel copyWith({int? id, String? title, String? content}) => NoteModel(
    id: id ?? this.id,
    txt: title ?? txt,
    description: content ?? description,
  );

  /// From Map
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      txt: map['txt'],
      description: map['dsescription'],
    );
  }
}
