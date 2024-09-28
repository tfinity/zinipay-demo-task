import 'package:flutter/material.dart';
import 'package:zini_pay_demo/core/colors.dart';

class ActiveCheckWidget extends StatelessWidget {
  const ActiveCheckWidget({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.lightGreen : AppColors.lightRed,
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? AppColors.green : AppColors.red,
        ),
        child: Icon(
          isActive ? Icons.check : Icons.close,
          color: AppColors.white,
          size: 42,
        ),
      ),
    );
  }
}
