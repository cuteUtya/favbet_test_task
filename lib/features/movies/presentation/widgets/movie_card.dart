import 'package:favbet_test_task/features/theme/presentation/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieCard extends ConsumerWidget {
  final ImageProvider image;
  final String name;
  final String rating;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const MovieCard({
    super.key,
    required this.image,
    required this.isFavorite,
    required this.name,
    required this.onFavoriteToggle,
    required this.rating,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeProvider);

    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image(image: image),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  onPressed: onFavoriteToggle,
                  icon: Icon(
                    Icons.star,
                    color: isFavorite ? theme.theme.favorite : theme.theme.star,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              color: theme.theme.text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: theme.theme.mainFont,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            'Rating: $rating',
            style: TextStyle(
              color: theme.theme.text,
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: theme.theme.mainFont,
            ),
          ),
        ],
      ),
    );
  }
}
