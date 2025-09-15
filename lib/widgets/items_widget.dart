import 'package:flutter/material.dart';
import '../pages/product_detail_page.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the color palette from AccountPage
    const Color primaryColor = Color(0xFF4C53A5);
    const Color secondaryColor = Color(0xFF6B7CDA);

    // Data produk dummy dengan deskripsi yang diperbaiki
    final List<Map<String, dynamic>> products = [
      {
        "name": "Apotek Farmasiana",
        "description": "Obat-obatan herbal dan modern lengkap",
        "price": 150.00,
        "image": "assets/carts/1.jpg",
        "discount": 10,
      },
      {
        "name": "Wallpaper Keren",
        "description": "Wallpaper premium dengan desain terkini",
        "price": 120.00,
        "image": "assets/carts/2.jpg",
        "discount": 15,
      },
      {
        "name": "Ngaji di IDN",
        "description": "Belajar mengaji praktis bersama IDN",
        "price": 90.00,
        "image": "assets/carts/3.jpg",
        "discount": 1,
      },
      {
        "name": "Mongkrang Asik",
        "description": "Kegiatan diluar Asrama yang bikin .....",
        "price": 85.00,
        "image": "assets/carts/4.jpg",
        "discount": 5,
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(products.length, (index) {
        final product = products[index];
        return LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: primaryColor.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header - Diskon dan Ikon Favorit
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                        right: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (product["discount"] > 0)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "-${product["discount"]}%",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          else
                            const SizedBox(width: 8),
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 20,
                          ),
                        ],
                      ),
                    ),

                    // Gambar Produk
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              product["image"],
                              height: constraints.maxWidth * 0.6,
                              width: constraints.maxWidth * 0.6,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: constraints.maxWidth * 0.6,
                                  width: constraints.maxWidth * 0.6,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.image,
                                    size: 40,
                                    color: primaryColor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Informasi Produk
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product["description"],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Harga dan Ikon Keranjang
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${product["price"].toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: primaryColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.shopping_cart_checkout,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
