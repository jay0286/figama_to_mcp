import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../constants/app_colors.dart';
import 'recipe_card.dart';

class RecipeSection extends StatelessWidget {
  final List<Recipe> recipes;
  final Function(Recipe)? onRecipeTap;
  final VoidCallback? onViewAllTap;

  const RecipeSection({
    super.key,
    required this.recipes,
    this.onRecipeTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최근 식단 레시피',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onViewAllTap,
                  child: const Text(
                    '더보기',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColors.primary,
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
