import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.text,
    required this.choices,
    required this.onChoiceChanged,
    this.selectedChoice,
  });

  final String text;
  final List<String> choices;
  final void Function(String?)? onChoiceChanged;

  final String? selectedChoice;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.text),
        const SizedBox(width: 20),
        DropdownButton<String>(
          value: widget.selectedChoice,
          items: <DropdownMenuItem<String>>[
            for (String choice in widget.choices)
              DropdownMenuItem<String>(
                value: choice,
                child: Text(choice),
              ),
          ],
          onChanged: widget.onChoiceChanged,
        ),
      ],
    );
  }
}
