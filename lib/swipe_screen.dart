import 'package:flutter/material.dart';
import 'dart:math';
import 'api_service.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  String email = '';
  Offset? startSwipe;
  late DateTime startTime;

  void _showDialog(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Respuesta del servidor"),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _handleSwipe(DragStartDetails details) {
    startSwipe = details.localPosition;
    startTime = DateTime.now();
  }

  void _handleSwipeEnd(DragEndDetails details) async {
    if (startSwipe == null) return;

    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMilliseconds / 1000.0;
    final velocity = details.velocity.pixelsPerSecond;

    final rapidez = velocity.distance;
    final dx = velocity.dx;
    final dy = velocity.dy;

    // Calcular ángulo en grados
    final angulo = atan2(dy, dx) * 180 / pi;

    String response = await ApiService.loginSwipe(
      email: email,
      angulo: angulo,
      tiempo: duration,
      rapidez: rapidez,
    );

    _showDialog(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Correo electrónico'),
              onChanged: (value) => setState(() => email = value),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onPanStart: _handleSwipe,
              onPanEnd: _handleSwipeEnd,
              child: Container(
                height: 250,
                width: double.infinity,
                color: Colors.blue.shade100,
                alignment: Alignment.center,
                child: const Text(
                  'Haz swipe aquí para iniciar sesión',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
