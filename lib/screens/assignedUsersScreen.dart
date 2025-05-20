import 'package:flutter/material.dart';

class ReflectionScreen extends StatelessWidget {
  final TextEditingController reflectionCtrl = TextEditingController();

  void _saveReflection() {
    // Guardar reflexión del usuario
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar reflexión")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: reflectionCtrl,
              maxLines: 6,
              decoration: InputDecoration(labelText: "Reflexión"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveReflection,
              child: Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}