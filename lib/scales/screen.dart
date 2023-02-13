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
  Scale chromatic = Scale.getChromatic(Note('C'));

  Chord chord = Chord(Note('C'), 'major');
  Scale scale = Scale.getMajor(Note('C'));

  String scaleMode = modes[0];
  String chordMode = modes[0];

  void updateFretboard(
    String scaleMode,
    String chordMode,
    Note keyScale,
    Note chordName,
  ) {
    setState(() {
      this.scaleMode = scaleMode;
      this.chordMode = chordMode;

      chord = Chord(chordName, chordMode);
      switch (scaleMode) {
        case 'major':
          scale = Scale.getMajor(keyScale);
          break;
        case 'minor':
          scale = Scale.getMinor(keyScale);
          break;
        default:
          scale = Scale.getMajor(keyScale);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  for (String mode in modes)
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
                  for (String mode in modes)
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
