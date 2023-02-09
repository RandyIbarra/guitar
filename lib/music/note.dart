List<String> allNotes = [
  'C',
  'C#',
  'D',
  'D#',
  'E',
  'F',
  'F#',
  'G',
  'G#',
  'A',
  'A#',
  'B'
];

class Note {
  String name;
  int position;

  Note.internal(this.name, this.position);

  factory Note(String name) {
    if (allNotes.contains(name)) {
      return Note.internal(name, allNotes.indexOf(name));
    } else {
      throw 'Error: Note does not exist';
    }
  }

  Note operator +(int semitones) {
    int newValue = (position + semitones) % allNotes.length;
    return Note.internal(allNotes[newValue], newValue);
  }
}
