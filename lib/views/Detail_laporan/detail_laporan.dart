import 'package:flutter/material.dart';
import 'package:lostify_app/customDataField.dart';

class datailLaporan extends StatefulWidget {
  const datailLaporan({super.key});

  @override
  State<datailLaporan> createState() => _datailLaporanState();
}

class _datailLaporanState extends State<datailLaporan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E3A8A), // Biru Utama
          foregroundColor: Colors.white,
          title: const Text(
            'Detail Laporan',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {}
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // untuk menampilkan data laporan bisa mengganti value dengan variable dari database
              Customdatafield(label: 'Nama Barang', value: 'Dompet Adidas', icon: Icons.work, fontsize: 16.0),  
              Customdatafield(label: 'Deskripsi', value: 'Dompet Adidas berwarna hitam dan isinya terdapat kartu atm ktp sim', icon: Icons.description, fontsize: 12.0),
                
              
            ],
          ),
        ),
    );
  }
}