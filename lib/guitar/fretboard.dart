import 'package:flutter/material.dart';
import 'package:guitar/guitar/fret_string.dart';
import 'package:guitar/guitar/tunning.dart';
import 'package:guitar/music/chord.dart';
import 'package:guitar/music/note.dart';
import 'package:guitar/music/scale.dart';

class Fretboard extends StatelessWidget {
  const Fretboard({
    super.key,
    this.scale,
    this.chord,
    required this.tunning,
  });

  final Chord? chord;
  final Scale? scale;
  final Tunning tunning;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            for (int string = 1; string <= 6; string++)
              SizedBox(
                width: size.width / 40.0,
                height: size.height / 10,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      height: constraints.maxWidth,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: _showCircle(_getNote(string, 0))
                            ? _getCircleColor(_getNote(string, 0))
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          _getNote(string, 0).name,
                          style: TextStyle(
                            color: _showCircle(_getNote(string, 0))
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const Center(
              child: Text('T'),
            ),
          ],
        ),
        for (int fretIndex = 1; fretIndex <= 12; fretIndex++)
          Column(
            children: [
              for (int string = 1; string <= 6; string++)
                SizedBox(
                  width: size.width / 10.0 - 4 * fretIndex,
                  height: size.height / 10,
                  child: FretString(
                    position: _getPosition(string),
                    note: _getNote(string, fretIndex),
                    showCircle: _showCircle(_getNote(string, fretIndex)),
                    circleColor: _getCircleColor(_getNote(string, fretIndex)),
                  ),
                ),
              Center(
                child: Text(fretIndex.toString()),
              ),
            ],
          )
      ],
    );
  }

  bool _showCircle(Note? note) {
    if (scale != null) {
      return scale!.hasNote(note!);
    }
    return true;
  }

  Color _getCircleColor(Note? note) {
    if (chord != null) {
      switch (chord!.hasNote(note!)) {
        case 1:
          return Colors.red;
        case 3:
          return Colors.green;
        case 5:
          return Colors.blue;
        default:
          return Colors.black;
      }
    }
    return Colors.transparent;
  }

  FretStringPosition _getPosition(int string) {
    switch (string) {
      case 1:
        return FretStringPosition.top;
      case 6:
        return FretStringPosition.bottom;
      default:
        return FretStringPosition.center;
    }
  }

  Note _getNote(int string, int fretIndex) {
    return tunning.notes[string - 1] + fretIndex;
  }
}
