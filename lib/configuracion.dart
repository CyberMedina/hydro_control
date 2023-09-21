import 'package:flutter/material.dart'; // Importa las localizaciones
import 'dispositivosCercanos.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConfiguracionScreen extends StatefulWidget {
  const ConfiguracionScreen({Key? key}) : super(key: key);

  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  bool notificacionesActivadas = true;
  String idiomaSeleccionado = 'Español';
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
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajustes Generales',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              title: const Text('Notificaciones'),
              subtitle: const Text('Activar o desactivar notificaciones'),
              trailing: Switch(
                value: notificacionesActivadas,
                onChanged: (value) {
                  setState(() {
                    notificacionesActivadas = value;
                  });
                  // Lógica para activar/desactivar notificaciones
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Idioma'),
              subtitle: Text('Seleccionado: $idiomaSeleccionado'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                _mostrarDialogoIdioma();
              },
            ),
            const Divider(),
            const Text(
              'Conexión Bluetooth',
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
