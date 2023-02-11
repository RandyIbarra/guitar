import 'package:guitar/music/note.dart';

class Chord {
  Note key;
  List<Note> notes;

  Chord.internal(this.key, this.notes);

  factory Chord(Note key, String mode) {
    List<Note> notes = [key];
    switch (mode) {
      case 'major':
        notes.add(key + 4);
        notes.add(key + 7);
        break;
      case 'minor':
        notes.add(key + 3);
        notes.add(key + 7);
        break;
    }
    return Chord.internal(key, notes);
  }

  int hasNote(Note queryNote) {
    for (int index = 0; index < 3; index++) {
      Note note = notes[index];
      if (note.isEqualTo(queryNote)) {
        return index * 2 + 1;
      }
    }
    return 0;
  }
}
