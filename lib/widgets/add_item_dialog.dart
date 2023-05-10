import 'package:flutter/material.dart';
import 'package:my_apps/widgets/button.dart';
import 'package:my_apps/widgets/input_field.dart';

class AddItemDialog extends StatelessWidget {
  final TextEditingController controller;
  final Widget saveButton;
  const AddItemDialog(
      {super.key, required this.controller, required this.saveButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(label: 'Name', controller: controller),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                      label: 'Cancel',
                      outlined: true,
                      onPress: () => Navigator.pop(context)),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(child: saveButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
