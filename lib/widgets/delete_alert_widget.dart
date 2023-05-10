import 'package:flutter/material.dart';

class AlertDeleteWidget extends StatelessWidget {
  final String title;
  final Widget deleteAction;
  const AlertDeleteWidget(
      {super.key, required this.title, required this.deleteAction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onPressed: () => Navigator.pop(context)),
        deleteAction,
      ],
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
