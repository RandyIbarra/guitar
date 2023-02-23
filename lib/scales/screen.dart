import 'package:flutter/material.dart';
import 'package:guitar/guitar/fretboard.dart';

import 'package:guitar/music/chord.dart';
import 'package:guitar/music/note.dart';
import 'package:guitar/music/scale.dart';

/// This page build a guitar [Fretboard] with a specific tunning and shows
/// all notes for each fret space. Now, you only are able to change the tunning
/// from code, but we are working on create a interface to do it from the app.
class ScaleScreen extends StatefulWidget {
  const ScaleScreen({super.key, required this.title});

  /// Screen title
  final String title;

  @override
  State<ScaleScreen> createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> {
  /// Chromatic scale
  Scale chromatic = Scale.getChromatic(Note('C'));

  /// Notes of this chord will be showed on the fretboard
  Chord chord = Chord.getChordFromMode(Note('C'), 'major');

  /// Notes of this scale will bbe showed on the fretboard
  Scale scale = Scale.getScaleFromMode(Note('C'), 'major');

  /// Mode of scale to show
  String scaleMode = scaleModes[0];

  /// Mode of chord to show
  String chordMode = chordModes[0];

  /// Given a [Scale] mode [sMode], [Chord] mode [cMode], key [Note] of scale
  /// [kScale] and a [Note] chord name [cName], update [scaleMode] and
  /// [chordMode], builds [scale] and [chord] again and finally, update
  /// fretboard.
  void updateFretboard(String sMode, String cMode, Note kScale, Note cName) {
    final scaleFactory = scaleRegistry[sMode]!;
    setState(() {
      scaleMode = sMode;
      chordMode = cMode;

      scale = scaleFactory(kScale);

      chord = Chord.getChordFromMode(cName, chordMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Standard tunning
    List<Note> tunning = [
      Note('E'),
      Note('A'),
      Note('D'),
      Note('G'),
      Note('B'),
      Note('E'),
    ].reversed.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Scale Mode:'),
              const SizedBox(width: 20),
              DropdownButton<String>(
                value: scaleMode,
                items: <DropdownMenuItem<String>>[
                  for (String mode in scaleModes)
                    DropdownMenuItem<String>(
                      value: mode,
                      child: Text(mode),
                    ),
                ],
                onChanged: (String? mode) {
                  if (mode != null) {
                    updateFretboard(mode, chordMode, scale.key, chord.key);
                  }
                },
              ),
              const SizedBox(width: 20),
              const Text('Scale:'),
              const SizedBox(width: 20),
              DropdownButton<String>(
                value: scale.key.name,
                items: <DropdownMenuItem<String>>[
                  for (int i = 0; i < chromatic.notes.length; i++)
                    DropdownMenuItem<String>(
                      value: chromatic.notes[i].name,
                      child: Text(chromatic.notes[i].name),
                    ),
                ],
                onChanged: (String? noteName) {
                  if (noteName != null) {
                    Note note = Note(noteName);
                    updateFretboard(scaleMode, chordMode, note, chord.key);
                  }
                },
              ),
              const SizedBox(width: 50),
              const Text('Chord Mode:'),
              const SizedBox(width: 20),
              DropdownButton<String>(
                value: chordMode,
                items: <DropdownMenuItem<String>>[
                  for (String mode in chordModes)
                    DropdownMenuItem<String>(
                      value: mode,
                      child: Text(mode),
                    ),
                ],
                onChanged: (String? mode) {
                  if (mode != null) {
                    updateFretboard(scaleMode, mode, scale.key, chord.key);
                  }
                },
              ),
              const SizedBox(width: 20),
              const Text('Chord:'),
              const SizedBox(width: 20),
              DropdownButton<String>(
                value: chord.key.name,
                items: <DropdownMenuItem<String>>[
                  for (int i = 0; i < chromatic.notes.length; i++)
                    DropdownMenuItem<String>(
                      value: chromatic.notes[i].name,
                      child: Text(chromatic.notes[i].name),
                    ),
                ],
                onChanged: (String? noteName) {
                  if (noteName != null) {
                    Note note = Note(noteName);
                    updateFretboard(scaleMode, chordMode, scale.key, note);
                  }
                },
              ),
            ],
          ),
          Fretboard(
            tunning: tunning,
            scale: scale,
            chord: chord,
          ),
        ],
      ),
    );
  }
}
