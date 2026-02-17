import 'package:flutter/material.dart';

class CircularCheckBox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final double size;
  final Color activeColor;
  final Color borderColor;

  const CircularCheckBox({
    super.key,
    required this.isChecked,
    required this.onChanged,
    this.size = 24.0,
    this.activeColor = Colors.orange,
    this.borderColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isChecked ? activeColor : borderColor,
            width: 2.0,
          ),
        ),
        child: isChecked
            ? Center(
          child: Container(
            width: size / 2,
            height: size / 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: activeColor,
            ),
          ),
        )
            : const SizedBox.shrink(),
      ),
    );
  }
}
