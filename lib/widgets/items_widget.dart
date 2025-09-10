// lib/widgets/items_widget.dart
import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});
  
  static const List<Map<String, dynamic>> products = [
    {'name': "Apotek khas . . . ", 'price': 199.99,'image': "assets/carts/1.jpg"},
    {'name': "Wallpaper Keren", 'price': 179.99,'image': "assets/carts/2.jpg"},
    {'name': "Ngaji di IDN", 'price': 179.99,'image': "assets/carts/3.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.75,
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: products.map((prod) {
        return Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.3), spreadRadius: 2, blurRadius: 5)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    child: const Text('-50%', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const Icon(Icons.favorite_border, color: Colors.red),
                ],
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Image.asset(
                    prod['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error, size: 50);
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(prod['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rp${prod['price']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Icon(Icons.shopping_cart_checkout, color: Colors.blue),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}