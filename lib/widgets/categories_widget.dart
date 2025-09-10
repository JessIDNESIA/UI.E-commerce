// lib/widgets/categories_widget.dart
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});
  
  static const List<Map<String, String>> categories = [
    {'image': 'assets/carts/1.jpg', 'name': 'Kategori 1'},
    {'image': 'assets/carts/2.jpg', 'name': 'Kategori 2'},
    {'image': 'assets/carts/3.jpg', 'name': 'Kategori 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Row(
          children: categories.map((cat) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      cat['image']!,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 50);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(cat['name']!),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}