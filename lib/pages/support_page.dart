import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  // Definisikan palet warna yang konsisten
  static const Color primaryColor = Color(0xFF4C53A5);
  static const Color secondaryColor = Color(0xFF6B7CDA);

  // Data FAQ
  final List<Map<String, String>> faqData = const [
    {
      'question': 'Bagaimana cara mengganti kata sandi?',
      'answer': 'Anda dapat mengganti kata sandi melalui menu Akun > Ganti Kata Sandi. Masukkan kata sandi lama Anda, kemudian masukkan kata sandi baru.',
    },
    {
      'question': 'Bagaimana cara melacak pesanan saya?',
      'answer': 'Status pesanan dapat dilacak di halaman Detail Pesanan. Informasi pelacakan akan tersedia setelah barang diserahkan kepada kurir.',
    },
    {
      'question': 'Apakah saya bisa membatalkan pesanan?',
      'answer': 'Pembatalan pesanan hanya dapat dilakukan dalam waktu 1 jam setelah pembayaran dikonfirmasi, selama status pesanan belum "Diproses".',
    },
    {
      'question': 'Metode pembayaran apa saja yang tersedia?',
      'answer': 'Kami menerima pembayaran melalui Transfer Bank (BCA, Mandiri), E-Wallet (Dana, Gopay), dan Kartu Kredit/Debit.',
    },
  ];

  // Widget untuk membuat tombol Kontak Darurat
  Widget _buildContactButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: primaryColor, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Menggunakan gradien yang sama dengan AccountPage
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Bagian FAQ ---
              Text(
                'Pertanyaan yang Sering Diajukan (FAQ)',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              
              // Menggunakan ExpansionTile untuk FAQ yang interaktif
              ...faqData.map((faq) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      faq['question']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                          top: 5.0,
                        ),
                        child: Text(
                          faq['answer']!,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              const SizedBox(height: 30),

              // --- Bagian Kontak ---
              Text(
                'Hubungi Kami',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),

              _buildContactButton(
                context,
                icon: Icons.chat_outlined,
                title: 'Live Chat',
                subtitle: 'Respons cepat dalam hitungan menit',
                onTap: () {
                  // Arahkan ke halaman Chat yang sudah ada (ListChatPage)
                  Navigator.pushNamed(context, '/list_chat');
                },
              ),
              _buildContactButton(
                context,
                icon: Icons.phone_android,
                title: 'Hubungi CS',
                subtitle: 'Senin - Jumat, 09:00 - 17:00 WIB',
                onTap: () {
                  // Tambahkan logika untuk membuka dialer telepon
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Membuka dialer telepon: 0812345678'),
                    ),
                  );
                },
              ),
              _buildContactButton(
                context,
                icon: Icons.email_outlined,
                title: 'Email Support',
                subtitle: 'Respons dalam 24 jam kerja',
                onTap: () {
                  // Tambahkan logika untuk membuka aplikasi email
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Membuka aplikasi email ke support@app.com'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}