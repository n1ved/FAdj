import 'package:flutter/material.dart';

class StatusText extends StatefulWidget {
  const StatusText({super.key, required this.headline, required this.value});
  final String headline;
  final String value;

  @override
  State<StatusText> createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headline,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          widget.value,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ],
    );
  }
}
