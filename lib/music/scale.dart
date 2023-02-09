import 'package:guitar/music/note.dart';

class Scale {
  List<String> notes;

  Scale.internal(this.notes);

  factory Scale(Note key, List<int> code) {
    List<String> notes = [key.name];
    Note note = key;
    for (int semitones in code) {
      note = note + semitones;
      notes.add(note.name);
    }
    if (notes.first == notes.last) {
      notes.removeLast();
    }
    return Scale.internal(notes);
  }

  factory Scale.getMajor(Note key) {
    return Scale(key, <int>[2, 2, 1, 2, 2, 2, 1]);
  }

  factory Scale.getMinor(Note key) {
    return Scale(key, <int>[2, 1, 2, 2, 1, 2, 2]);
  }
}
