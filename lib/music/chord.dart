import 'package:guitar/music/note.dart';

class Chord {
  List<String> notes;

  Chord.internal(this.notes);

  factory Chord(Note key, String mode) {
    List<String> notes = [key.name];
    switch (mode) {
      case 'major':
        notes.add((key + 4).name);
        notes.add((key + 7).name);
        break;
      case 'minor':
        notes.add((key + 3).name);
        notes.add((key + 7).name);
        break;
    }
    return Chord.internal(notes);
  }
}
