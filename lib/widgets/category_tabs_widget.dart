import 'package:flutter/material.dart';

class CategoryTabsWidget extends StatelessWidget {
  final int selectedCategoryIndex;
  final List<String> categories;
  final Function(int) onCategorySelected;

  const CategoryTabsWidget({
    super.key,
    required this.selectedCategoryIndex,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color(0xFF1A1A1A), // Même couleur que l'AppBar
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isActive = index == selectedCategoryIndex;
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.white : Colors.grey[400],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
