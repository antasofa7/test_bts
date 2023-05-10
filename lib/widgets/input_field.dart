import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final TextInputType? inputType;
  final bool? passwordField;
  final bool? suffixIcon;
  final Widget? suffixIconWidget;
  final TextEditingController controller;
  final String? helperText;
  final TextInputAction? inputAction;

  const InputField({
    super.key,
    required this.label,
    this.inputType = TextInputType.text,
    this.suffixIcon = false,
    this.suffixIconWidget,
    required this.controller,
    this.helperText = '',
    this.passwordField = false,
    this.inputAction = TextInputAction.done,
  });

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
      child: widget.passwordField!
          ? TextFormField(
              keyboardType: widget.inputType!,
              obscureText: _obsecureText,
              obscuringCharacter: '*',
              controller: widget.controller,
              textInputAction: widget.inputAction!,
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
                  helperText: widget.helperText ?? '',
                  helperStyle: Theme.of(context).textTheme.labelSmall,
                  suffixIcon: widget.suffixIconWidget ??
                      IconButton(
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
              keyboardType: widget.inputType!,
              controller: widget.controller,
              textInputAction: widget.inputAction!,
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
                  helperText: widget.helperText ?? '',
                  helperStyle: Theme.of(context).textTheme.labelSmall,
                  suffixIcon:
                      widget.suffixIcon! ? widget.suffixIconWidget! : null)),
    );
  }
}
