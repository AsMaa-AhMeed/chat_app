import 'package:chat_app_2/components/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String data;
  final VoidCallback onTap;
  const CustomTextButton({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
            color: ColorManager.lightBlue,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            data,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
