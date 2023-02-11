import 'package:guitar/music/note.dart';

class Scale {
  Note key;
  List<Note> notes;

  Scale.internal(this.key, this.notes);

  factory Scale(Note key, List<int> code) {
    List<Note> notes = [key];
    Note note = key;
    for (int semitones in code) {
      note = note + semitones;
      notes.add(note);
    }
    if (notes.first == notes.last) {
      notes.removeLast();
    }
    return Scale.internal(key, notes);
  }

  factory Scale.getMajor(Note key) {
    return Scale(key, <int>[2, 2, 1, 2, 2, 2, 1]);
  }

  factory Scale.getMinor(Note key) {
    return Scale(key, <int>[2, 1, 2, 2, 1, 2, 2]);
  }

  factory Scale.getChromatic(Note key) {
    return Scale(key, <int>[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
  }

  bool hasNote(Note queryNote) {
    for (Note note in notes) {
      if (note.isEqualTo(queryNote)) {
        return true;
      }
    }
    return false;
  }

  bool isKey(Note note) {
    return notes[0].isEqualTo(note);
  }
}

List<String> modes = [
  'major',
  'minor',
];
