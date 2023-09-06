import 'package:flutter/material.dart';
import 'package:ryzenadj_fluttter/default_controll_values.dart';

class SettingsInputBox extends StatefulWidget {
  const SettingsInputBox(
      {super.key,
      required this.inputController,
      required this.id,
      required this.inputIcon,
      required this.labelText});

  final TextEditingController inputController;
  final String id;
  final IconData inputIcon;
  final String labelText;

  @override
  State<SettingsInputBox> createState() => _SettingsInputBoxState();
}

class _SettingsInputBoxState extends State<SettingsInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextField(
        controller: widget.inputController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            switch (widget.id) {
              case 'tctl':
                CntrlValues.tctl = int.parse(value);
                break;
              case 'stapm':
                CntrlValues.stapm = int.parse(value);
                break;
              case 'fast':
                CntrlValues.fast = int.parse(value);
                break;
              case 'slow':
                CntrlValues.slow = int.parse(value);
                break;
            }
          });
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(widget.inputIcon),
        ),
      ),
    );
  }
}
