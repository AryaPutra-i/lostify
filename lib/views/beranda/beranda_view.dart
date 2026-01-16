import 'package:flutter/material.dart';
import 'home_header.dart';
import 'category_list.dart';
import 'report_card.dart';

class BerandaView extends StatelessWidget {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header: Judul, Notif, dan Search
            const HomeHeader(),
            
            // Filter Kategori (horizontal scroll/list)
            const CategoryList(),
            
            // List Laporan & Peta
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const ReportCard(
                    title: 'Dompet Hitam',
                    location: 'Mall Kelapa Gading',
                    time: '2 jam lalu',
                    status: 'Hilang',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  const ReportCard(
                    title: 'Kucing Oren',
                    location: 'Taman Kota',
                    time: '30 menit lalu',
                    status: 'Ditemukan',
                    imageUrl: 'https://via.placeholder.com/150',
                  ),
                  
                  // Placeholder Peta (bisa dipisah juga jika mau)
                  Container(
                    height: 150,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://via.placeholder.com/600x300?text=Map+Placeholder'),
                        fit: BoxFit.cover,
                        opacity: 0.5,
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.map, color: Color(0xFF1E3A8A), size: 40),
                    ),
                  ),
                  
                  // Spacer agar tidak ketutup bottom nav
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
