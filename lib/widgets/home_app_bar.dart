// lib/widgets/home_app_bar.dart
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import '../pages/list_chat.dart'; // pastikan path sesuai struktur project

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Define the color palette from AccountPage
    const Color primaryColor = Color(0xFF4C53A5);
    const Color secondaryColor = Color(0xFF6B7CDA);
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 30, color: Colors.white),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Toko Online',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
            ),
            badgeContent: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListChatPage()),
                );
              },
              child: const Icon(
                Icons.notifications,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
