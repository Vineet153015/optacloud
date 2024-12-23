import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Mock Bluetooth connection toggle
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Bluetooth toggled")),
            );
          },
          child: const Text("Toggle Bluetooth"),
        ),
      ),
    );
  }
}
