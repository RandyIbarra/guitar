import 'package:flutter/material.dart';

import 'package:guitar/music/chord.dart';
import 'package:guitar/music/note.dart';
import 'package:guitar/music/scale.dart';

class ScaleScreen extends StatefulWidget {
  const ScaleScreen({super.key, required this.title});

  final String title;

  @override
  State<ScaleScreen> createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> {
  List<Note> tunning = [
    Note('E'),
    Note('A'),
    Note('D'),
    Note('G'),
    Note('B'),
    Note('E'),
  ];
  late List<List<Note>> fretboard = [
    for (int guitarStr = 0; guitarStr < 6; guitarStr++)
      [
        for (int freat = 0; freat < 13; freat++) tunning[guitarStr] + freat,
      ],
  ];
  @override
  Widget build(BuildContext context) {
    Scale scale = Scale.getMajor(Note('C'));
    //Chord chord = Chord(Note('A'), 'minor');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("fretboard.png"),
                fit: BoxFit.contain,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 210),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int freat = 1; freat <= 13; freat++) ...[
                    Column(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        for (int guitarStr = 0; guitarStr < 6; guitarStr++) ...[
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: scale.notes.contains(
                                fretboard[guitarStr][freat - 1].name,
                              )
                                  ? Colors.red
                                  : const Color.fromRGBO(0, 0, 0, 0),
                              /*
                              color: scale.notes.contains(
                                fretboard[guitarStr][freat - 1].name,
                              )
                                  ? (chord.notes.contains(
                                      fretboard[guitarStr][freat - 1].name,
                                    )
                                      ? Colors.red[(5 -
                                              2 *
                                                  chord.notes.indexOf(
                                                    fretboard[guitarStr]
                                                            [freat - 1]
                                                        .name,
                                                  )) *
                                          100]
                                      : Colors.blue[200])
                                  : const Color.fromRGBO(0, 0, 0, 0),
                              */
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                fretboard[guitarStr][freat - 1].name,
                              ),
                            ),
                          ),
                          const SizedBox(height: 11),
                        ]
                      ],
                    ),
                    SizedBox(
                      width: freat == 1 ? 30 : 80 - 2.8 * freat.toDouble(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
