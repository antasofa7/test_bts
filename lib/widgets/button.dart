import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function() onPress;
  final bool? outlined;
  const ButtonWidget(
      {super.key,
      required this.label,
      required this.onPress,
      this.outlined = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: outlined!
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
            side: BorderSide(color: Theme.of(context).colorScheme.primary),
            minimumSize: const Size(double.infinity, 50.0)),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: outlined!
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background),
        ),
      ),
    );
  }
}
