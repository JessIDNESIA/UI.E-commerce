// lib/widgets/home_app_bar.dart
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(Icons.sort, size: 30, color: Colors.blue),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('Toko Online', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
          const Spacer(),
          badges.Badge(
            badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
            child: InkWell(
              onTap: () {},
              child: const Icon(Icons.notifications, size: 32, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}