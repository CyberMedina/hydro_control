import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class AyudaScreen extends StatelessWidget {
  AyudaScreen({super.key});

  bool isBluetoothOn = false;
  bool isScanning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preguntas Frecuentes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            _buildFAQItem(
              pregunta: '¿Cómo se activa el riego?',
              respuesta:
                  'Para activar el riego, ve a la pantalla principal y pulsa el botón de "Iniciar Riego".',
            ),
            const Divider(),
            _buildFAQItem(
              pregunta: '¿Cómo programar el riego?',
              respuesta:
                  'En la pantalla de programación de riego, selecciona la hora y duración del riego y presiona "Guardar".',
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                print("Hola");
              },
              child: Text(
                  isBluetoothOn ? 'Desactivar Bluetooth' : 'Activar Bluetooth'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String pregunta, required String respuesta}) {
    return ExpansionTile(
      title: Text(
        pregunta,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(respuesta),
        ),
      ],
    );
  }
}
