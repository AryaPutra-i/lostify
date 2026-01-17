import 'package:flutter/material.dart';
import 'package:lostify_app/customTextField.dart';
import 'package:lostify_app/views/cutomButton.dart';

class pickupView extends StatefulWidget {
  const pickupView({super.key});

  @override
  State<pickupView> createState() => _pickupViewState();
}

class _pickupViewState extends State<pickupView> {
  final TextEditingController _namaPengambil = TextEditingController();
  final TextEditingController _nomorPengambil = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A), // Biru Utama
        foregroundColor: Colors.white,
        title: const Text(
          'Pickup Barang',
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
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E3A8A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Upload Foto Bukti pengambilan',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(text: 'Upload', onPressed: (){}, color: const Color(0xFF1E3A8A), height: 30, icon: Icons.upload_sharp),
            const SizedBox(height: 15),
            Customtextfield(
              controller: _namaPengambil, 
              label: 'Nama Pengambil',
              hint: 'Alfredo elpendeho',
              prefixIcon: Icons.person,
            
            ),
            const SizedBox(height: 15),

            Customtextfield(
              controller: _nomorPengambil,
              label: 'Nomor Pengambil',
              hint: '08912345678',
              prefixIcon: Icons.phone,
            ),

            const SizedBox(height: 15),
            CustomButton(text: 'Submit', onPressed: (){}, color: const Color(0xFF1E3A8A), height: 30),

            
          ],
        ),
      ),
    );
  }
}
