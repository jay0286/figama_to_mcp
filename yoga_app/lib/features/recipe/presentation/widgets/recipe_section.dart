import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/models/recipe.dart';
import 'recipe_card.dart';

class RecipeSection extends StatelessWidget {
  const RecipeSection({
    super.key,
    required this.recipes,
    this.onRecipeTap,
    this.onViewAllTap,
  });

  final List<Recipe> recipes;
  final ValueChanged<Recipe>? onRecipeTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최근 식단 레시피',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: colors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onViewAllTap,
                  child: Text(
                    '더보기',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...recipes.map((recipe) => RecipeCard(
                recipe: recipe,
                onTap: () => onRecipeTap?.call(recipe),
              )),
        ],
      ),
    );
  }
}
