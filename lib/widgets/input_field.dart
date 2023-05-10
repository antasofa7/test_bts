import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final bool obsecureText = false;
  final bool suffixIcon;
  final TextEditingController controller;
  final String helperText;

  const InputField(
      {super.key,
      required this.label,
      required this.inputType,
      required this.suffixIcon,
      required this.controller,
      required this.helperText});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obsecureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        // color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: widget.suffixIcon
          ? TextFormField(
              keyboardType: widget.inputType,
              obscureText: _obsecureText,
              obscuringCharacter: '*',
              controller: widget.controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return '${widget.label} tidak boleh kosong!';
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodyMedium,
              cursorHeight: 24.0,
              decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  helperText: widget.helperText,
                  helperStyle: Theme.of(context).textTheme.labelSmall,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecureText = !_obsecureText;
                        });
                      },
                      icon: _obsecureText
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))),
            )
          : TextFormField(
              keyboardType: widget.inputType,
              controller: widget.controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return '${widget.label} tidak boleh kosong!';
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodyMedium,
              cursorHeight: 24.0,
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: Theme.of(context).textTheme.labelLarge,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                helperText: widget.helperText,
                helperStyle: Theme.of(context).textTheme.labelSmall,
              )),
    );
  }
}
