import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForbiddenPage extends StatelessWidget {
  const ForbiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Acesso Negado'),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Voltar'),
            )
          ],
        ),
      ),
    );
  }
}
