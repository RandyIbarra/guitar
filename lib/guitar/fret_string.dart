import 'package:flutter/material.dart';

import 'package:guitar/music/note.dart';

enum FretStringPosition { top, bottom, center }

class FretString extends StatelessWidget {
  const FretString({
    super.key,
    required this.note,
    required this.position,
    required this.showCircle,
    this.circleColor = Colors.black,
  });
  final Note note;
  final bool showCircle;
  final Color circleColor;
  final FretStringPosition position;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final circleDiameter = constraints.maxHeight / 2.5;
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: constraints.maxWidth / 20,
                right: constraints.maxWidth / 20,
                top: position == FretStringPosition.top
                    ? constraints.maxHeight / 5
                    : 0,
                bottom: position == FretStringPosition.bottom
                    ? constraints.maxHeight / 5
                    : 0,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight / 40,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Container(
              height: circleDiameter,
              width: circleDiameter,
              decoration: BoxDecoration(
                color: showCircle ? circleColor : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  note.name,
                  style: TextStyle(
                    color: showCircle ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
