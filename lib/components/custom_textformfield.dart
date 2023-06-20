import 'package:chat_app_2/components/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const CustomTextFormField(
      {super.key, required this.hintText, this.keyboardType, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is Required!';
        }
      },
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.blue),
        ),
      ),
    );
  }
}
