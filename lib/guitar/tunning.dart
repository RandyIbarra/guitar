import 'package:guitar/music/note.dart';

List<String> tunningNames = [
  'standard',
  'dropD',
  'dropC',
];

class Tunning {
  /// Number of strings on a guitar
  static int nStrings = 6;

  /// Note for each string on a guitar
  List<Note> notes;

  Tunning(this.notes);

  /// Standard tunning for guitar
  factory Tunning.standard() {
    List<Note> notes = [
      Note('E'),
      Note('A'),
      Note('D'),
      Note('G'),
      Note('B'),
      Note('E'),
    ].reversed.toList();
    return Tunning(notes);
  }

  factory Tunning.dropD() {
    final tunning = Tunning.standard();
    tunning.notes[nStrings - 1] = tunning.notes[nStrings - 1] - 2;
    return tunning;
  }

  factory Tunning.dropC() {
    final tunning = Tunning.dropD();
    for (int string = 0; string < nStrings; string++) {
      tunning.notes[string] = tunning.notes[string] - 2;
    }
    return tunning;
  }

  factory Tunning.getTunningFromName(String tunningName) {
    final constructor = scaleRegistry[tunningName];
    final tunning = constructor!();
    return tunning;
  }
}

/// You can get the constructor by var _constructor = scaleRegistry['major'].
/// And then, make your major scale by var _scale = _constructor(Note('C')).
Map<String, Tunning Function()> scaleRegistry = {
  "standard": () => Tunning.standard(),
  "dropD": () => Tunning.dropD(),
  "dropC": () => Tunning.dropC(),
};
