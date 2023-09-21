import 'package:flutter/material.dart';

class HistorialRiegoScreen extends StatelessWidget {
  const HistorialRiegoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Riego'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ejemplo con ListView:
          Expanded(
            child: ListView(
              children: const [
    
                // Ejemplo de un elemento de historial:
                ListTile(
                  title: Text('Fecha: 2023-09-15'),
                  subtitle: Text('Duración: 30 minutos'),
                ),
                ListTile(
                  title: Text('Fecha: 2023-09-15'),
                  subtitle: Text('Duración: 30 minutos'),
                ),
                ListTile(
                  title: Text('Fecha: 2023-09-15'),
                  subtitle: Text('Duración: 30 minutos'),
                ),
                ListTile(
                  title: Text('Fecha: 2023-09-15'),
                  subtitle: Text('Duración: 30 minutos'),
                ),
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
