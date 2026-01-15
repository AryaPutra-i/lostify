import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Register'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<RegisterController>(
            builder: (context, controller, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email (@student.uisi.ac.id)',
                      hintText:
                          'Masukkan email dengan format @student.uisi.ac.id',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  controller.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool success = await controller.register(
                                usernameController.text,
                                emailController.text,
                              );

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Register berhasil'),
                                  ),
                                );
                                Navigator.pop(context); // kembali ke login
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Register gagal'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Register'),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
