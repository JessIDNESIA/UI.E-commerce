// lib/pages/home_page.dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/categories_widget.dart';
import '../widgets/items_widget.dart';
import 'cart_page.dart';
import 'account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key}); // ✅ const + key

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose(); // ✅ hindari memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _pageIndex = index),
        children: const [
          HomePageContent(),
          CartPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        items: [
          Icon(Icons.home, color: _pageIndex == 0 ? Colors.white : Colors.black),
          Icon(Icons.shopping_cart, color: _pageIndex == 1 ? Colors.white : Colors.black),
          Icon(Icons.person, color: _pageIndex == 2 ? Colors.white : Colors.black),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xFF4C53A5), // ✅ konsisten warna brand
        color: Colors.grey[200]!,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key}); // ✅ const biar lebih optimal

  @override
  Widget build(BuildContext context) {
    return SafeArea( // ✅ biar UI tidak ketabrak notch/status bar
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HomeAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  // 🔍 Search bar
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari Produk',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.camera_alt),
                      ],
                    ),
                  ),

                  // 📂 Kategori
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: const Text(
                      'Kategori',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  const CategoriesWidget(),

                  // 🔥 Terlaris
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: const Row(
                      children: [
                        Text(
                          'Terlaris',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.filter_list),
                      ],
                    ),
                  ),
                  const ItemsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
