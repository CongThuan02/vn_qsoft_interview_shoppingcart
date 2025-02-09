import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  final bool isEnable;
  const ButtonWidget({super.key, required this.title, this.onTap, this.isEnable = true});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: widget.isEnable == true ? Colors.orangeAccent.withOpacity(0.8) : Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
