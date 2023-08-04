import 'package:flutter/material.dart';
import 'package:flutter_doctor_appointment/utils/config.dart';

class Button extends StatelessWidget {
  
  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;
  
  const Button({
    super.key,
    required this.width,
    required this.title,
    required this.onPressed,
    required this.disable
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Config.primaryColor,
          foregroundColor: Colors.white
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
}