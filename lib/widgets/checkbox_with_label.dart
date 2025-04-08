import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/widgets/gradient_icon.dart';

class CheckboxWithLabel extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CheckboxWithLabel({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: GradientIcon(
            icon: value ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
            size: 24,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Text(label),
        ),
      ],
    );
  }
}
