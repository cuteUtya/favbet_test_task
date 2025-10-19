import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationButton extends ConsumerWidget {
  const PaginationButton({
    super.key,
    required this.isSelected,
    required this.page,
    required this.onClick,
  });

  final bool isSelected;
  final int page;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeProvider).theme;
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? theme.buttonBackground1 : Colors.transparent,
          border: isSelected
              ? null
              : Border.all(color: theme.buttonText2, width: 1),
        ),
        width: 48,
        height: 48,
        child: Center(
          child: Text(
            page.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.buttonText2,
              fontFamily: theme.mainFont,
            ),
          ),
        ),
      ),
    );
  }
}
