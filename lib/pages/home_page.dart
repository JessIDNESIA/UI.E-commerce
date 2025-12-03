// lib/pages/home_page.dart
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/categories_widget.dart';
import '../widgets/items_widget.dart';
import 'cart_page.dart';
import 'account_page.dart';
import 'list_chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final PageController _pageController = PageController();

  // Define the color palette from AccountPage
  static const Color primaryColor = Color(0xFF4C53A5);
  static const Color secondaryColor = Color(0xFF6B7CDA);

  @override
  void dispose() {
    _pageController.dispose();
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
          ListChatPage(),
          AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        items: [
          Icon(Icons.home, color: _pageIndex == 0 ? Colors.white : primaryColor),
          Icon(Icons.shopping_cart, color: _pageIndex == 1 ? Colors.white : primaryColor),
          Icon(Icons.notifications, color: _pageIndex == 2 ? Colors.white : primaryColor), // <--- BARIS BARU: Tambah Ikon Notifikasi
          Icon(Icons.person, color: _pageIndex == 3 ? Colors.white : primaryColor),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: primaryColor,
        color: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  // Define the color palette from AccountPage
  static const Color primaryColor = Color(0xFF4C53A5);
  static const Color secondaryColor = Color(0xFF6B7CDA);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: primaryColor),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari Produk',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.camera_alt, color: primaryColor),
                      ],
                    ),
                  ),

                  // 📂 Kategori
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Text(
                      'Kategori',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const CategoriesWidget(),

                  // 🔥 Terlaris
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          'Terlaris',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(Icons.filter_list, color: primaryColor),
                      ],
                    ),
                  ),
                  const ItemsWidget(),

                  // Spacer bottom
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}