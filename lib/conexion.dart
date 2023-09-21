import 'package:flutter/material.dart'; // Importa las localizaciones
import 'dispositivosCercanos.dart';

class ConexionScreen extends StatefulWidget {
  const ConexionScreen({Key? key}) : super(key: key);

  @override
  _ConexionScreen createState() => _ConexionScreen();
}

class _ConexionScreen extends State<ConexionScreen> {
  bool notificacionesActivadas = true;
  String idiomaSeleccionado = 'Español';
  bool wifiActivado = false; // Variable de estado para la conexión Bluetooth
  bool bluetoothActivado =
      false; // Variable de estado para la conexión Bluetooth

  final List<String> idiomasDisponibles = [
    'Español',
    'Inglés',
    'Portugués',
    'Alemán',
    'Chino',
    'Japonés'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conexión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Conexión vía WiFi',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              title: const Text('Estado del WiFi'),
              subtitle: const Text('Activar o desactivar WiFi'),
              trailing: Switch(
                value:
                    bluetoothActivado, // Utiliza la variable de estado del Bluetooth
                onChanged: (value) {
                  setState(() {
                    bluetoothActivado =
                        value; // Actualiza la variable de estado del Bluetooth
                  });
                  // Lógica para activar/desactivar Bluetooth
                  if (bluetoothActivado) {
                    // Activar Bluetooth
                    // Start scanning
                  } else {
                    // Desactivar Bluetooth
                    // Stop scanning
                    // flutterBlue.stopScan();
                  }
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Dispositivos emparejados'),
              subtitle: const Text('Administrar dispositivos emparejados'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DispositivosCercanosScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            const Text(
              'Conexión vía Bluetooth',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              title: const Text('Estado del Bluetooth'),
              subtitle: const Text('Activar o desactivar Bluetooth'),
              trailing: Switch(
                value:
                    wifiActivado, // Utiliza la variable de estado del Bluetooth
                onChanged: (value) {
                  setState(() {
                    wifiActivado =
                        value; // Actualiza la variable de estado del Bluetooth
                  });
                  // Lógica para activar/desactivar Bluetooth
                  if (wifiActivado) {
                    // Activar Bluetooth
                    // Start scanning
                  } else {
                    // Desactivar Bluetooth
                    // Stop scanning
                    // flutterBlue.stopScan();
                  }
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Dispositivos emparejados'),
              subtitle: const Text('Administrar dispositivos emparejados'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DispositivosCercanosScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoIdioma() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar Idioma'),
          content: SingleChildScrollView(
            child: ListBody(
              children: idiomasDisponibles.map((idioma) {
                return ListTile(
                  title: Text(idioma),
                  onTap: () {
                    setState(() {
                      idiomaSeleccionado = idioma;
                    });
                    Navigator.of(context).pop();

                    // Lógica para cambiar el idioma
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
