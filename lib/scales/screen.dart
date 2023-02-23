import 'package:flutter/material.dart';

import 'package:guitar/guitar/fretboard.dart';
import 'package:guitar/guitar/tunning.dart';

import 'package:guitar/music/note.dart';
import 'package:guitar/music/scale.dart';
import 'package:guitar/music/chord.dart';

import 'package:guitar/scales/custom_dropdown.dart';

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

  /// Tunning for the guitar fretboard
  Tunning tunning = Tunning.standard();

  /// Notes of this chord will be showed on the fretboard
  Chord chord = Chord.getChordFromMode(Note('C'), 'major');

  /// Notes of this scale will bbe showed on the fretboard
  Scale scale = Scale.getScaleFromMode(Note('C'), 'major');

  /// Name of guitar tunning
  String tunningName = tunningNames[0];

  /// Mode of scale to show
  String scaleMode = scaleModes[0];

  /// Mode of chord to show
  String chordMode = chordModes[0];

  /// Given a [Scale] mode [sMode], [Chord] mode [cMode], key [Note] of scale
  /// [kScale] and a [Note] chord name [cName], update [scaleMode] and
  /// [chordMode], builds [scale] and [chord] again and finally, update
  /// fretboard.
  void updateFretboard(
    String tName,
    String sMode,
    String cMode,
    Note kScale,
    Note cName,
  ) {
    setState(() {
      scaleMode = sMode;
      chordMode = cMode;
      tunningName = tName;

      scale = Scale.getScaleFromMode(kScale, scaleMode);
      chord = Chord.getChordFromMode(cName, chordMode);
      tunning = Tunning.getTunningFromName(tName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomDropdown(
              text: 'Tunning',
              choices: tunningNames,
              selectedChoice: tunningName,
              onChoiceChanged: updateFromTunning,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDropdown(
                text: 'Scale Mode',
                choices: scaleModes,
                selectedChoice: scaleMode,
                onChoiceChanged: updateFromScaleMode,
              ),
              const SizedBox(width: 20),
              CustomDropdown(
                text: 'Scale',
                choices: allNotes,
                selectedChoice: scale.key.name,
                onChoiceChanged: updateFromScale,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDropdown(
                text: 'Chord Mode',
                choices: chordModes,
                selectedChoice: chordMode,
                onChoiceChanged: updateFromChordMode,
              ),
              const SizedBox(width: 20),
              CustomDropdown(
                text: 'Chord',
                choices: allNotes,
                selectedChoice: chord.key.name,
                onChoiceChanged: updateFromChord,
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

  /// Update fretoard after select a new [Scale] mode for the current [Scale]
  void updateFromScaleMode(String? newScaleMode) {
    if (newScaleMode != null) {
      updateFretboard(
          tunningName, newScaleMode, chordMode, scale.key, chord.key);
    }
  }

  /// Update fretoard after select a new [Note] for the current [Scale]
  void updateFromScale(String? newScaleName) {
    if (newScaleName != null) {
      Note scaleKey = Note(newScaleName);
      updateFretboard(tunningName, scaleMode, chordMode, scaleKey, chord.key);
    }
  }

  /// Update fretoard after select a new [Chord] mode for the current [Chord]
  void updateFromChordMode(String? newChordMode) {
    if (newChordMode != null) {
      updateFretboard(
          tunningName, scaleMode, newChordMode, scale.key, chord.key);
    }
  }

  /// Update fretoard after select a new [Note] for the current [Chord]
  void updateFromChord(String? newChordName) {
    if (newChordName != null) {
      Note chordKey = Note(newChordName);
      updateFretboard(tunningName, scaleMode, chordMode, scale.key, chordKey);
    }
  }

  /// Update fretoard after select a new [Tunning] for the guitar
  void updateFromTunning(String? newTunningName) {
    if (newTunningName != null) {
      updateFretboard(
        newTunningName,
        scaleMode,
        chordMode,
        scale.key,
        chord.key,
      );
    }
  }
}
