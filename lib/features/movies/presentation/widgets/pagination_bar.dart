import 'package:favbet_test_task/features/movies/presentation/widgets/pagination_button.dart';
import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationBar extends ConsumerWidget {
  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onTap,
  });

  final int currentPage;
  final int totalPages;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeProvider).theme;
    Widget btn(int page) => PaginationButton(
      isSelected: currentPage == page,
      page: page,
      onClick: () => onTap(page),
    );

    Widget dots() =>
        Text('...', style: TextStyle(color: theme.buttonText2, fontSize: 16));

    return Row(
      spacing: 16,
      children: [
        btn(1),

        if (currentPage > 4) dots(),

        ...List.generate(3, (index) {
          int page = currentPage - 1 + index;
          if (page <= 1 || page >= totalPages) return null;
          return btn(page);
        }).whereType<Widget>(),

        if (currentPage < totalPages - 3) dots(),

        btn(totalPages),
      ],
    );
  }
}
