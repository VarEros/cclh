// screens/login_screen.dart

import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartas contra la Humanidad"),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Introduce un nombre para comenzar",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  gameViewModel.addPlayer(_nameController.text);
                  Navigator.pushReplacementNamed(context, '/game');
                }
              },
              child: const Text("Unirse a la Sala"),
            ),
          ],
        ),
      ),
    );
  }
}
