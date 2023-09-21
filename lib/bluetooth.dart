import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_settings/open_settings.dart';

class BluetoothWidget extends StatefulWidget {
  final Function(bool) onBluetoothToggle;

  const BluetoothWidget({Key? key, required this.onBluetoothToggle})
      : super(key: key);

  @override
  _BluetoothWidgetState createState() => _BluetoothWidgetState();
}

class _BluetoothWidgetState extends State<BluetoothWidget> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? selectedDevice;
  bool isScanning = false;
  bool isBluetoothOn = false;

  @override
  void initState() {
    super.initState();
    // Verifica si el Bluetooth está activado al inicio
    flutterBlue.isOn.then((value) {
      setState(() {
        isBluetoothOn = value;
      });
    });
  }

// Función para activar o desactivar el Bluetooth
void toggleBluetooth(bool isEnabled) async {
  if (isEnabled) {
    // Verifica los permisos y solicita si es necesario
    final status = await Permission.bluetooth.request();
    
    if (status.isDenied) {
      // Los permisos no se otorgaron, puedes mostrar un mensaje de error o abrir la configuración de Bluetooth
      print('Permisos de Bluetooth denegados');
      // OpenSettings.bluetooth(); // Esto funciona en Android, pero no en iOS
    }
  } else {
    // Esto no es posible desde la aplicación en iOS
    print('Desactivar Bluetooth no es compatible en iOS');
  }
  
  setState(() {
    isBluetoothOn = isEnabled;
  });
  
  // Llama al callback con el estado actual del Bluetooth
  widget.onBluetoothToggle(isBluetoothOn);
}

  // Función para buscar dispositivos Bluetooth disponibles
  void startScan() {
    setState(() {
      isScanning = true;
    });

    flutterBlue.scanResults.listen((results) {
      // Actualiza la lista de dispositivos encontrados
      setState(() {
        // Puedes procesar los resultados aquí y mostrarlos en una lista
      });
    });

    // Detén la búsqueda después de 10 segundos
    Future.delayed(const Duration(seconds: 10), () {
      flutterBlue.stopScan();
      setState(() {
        isScanning = false;
      });
    });
  }

  // Función para conectarse a un dispositivo Bluetooth
  void connectToDevice(BluetoothDevice device) async {
    if (selectedDevice != null) {
      await selectedDevice!.disconnect();
    }

    await device.connect();
    setState(() {
      selectedDevice = device;
    });

    // Aquí puedes iniciar la comunicación con el dispositivo conectado
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          'Bluetooth: ${isBluetoothOn ? 'Activado' : 'Desactivado'}',
          style: const TextStyle(fontSize: 18),
        ),
        ElevatedButton(
          onPressed: () => toggleBluetooth(!isBluetoothOn),
          child: Text(isBluetoothOn ? 'Desactivar Bluetooth' : 'Activar Bluetooth'),
        ),
        const SizedBox(height: 20),
        const Text(
          'Buscar Dispositivos',
          style: TextStyle(fontSize: 18),
        ),
        ElevatedButton(
          onPressed: isScanning ? null : startScan,
          child: const Text('Buscar'),
        ),
        if (isScanning)
          const CircularProgressIndicator()
        else
          const Column(
            children: [
              // Aquí puedes mostrar la lista de dispositivos encontrados
            ],
          ),
        if (selectedDevice != null)
          Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Dispositivo Conectado',
                style: TextStyle(fontSize: 18),
              ),
              Text('Nombre: ${selectedDevice!.name}'),
              Text('ID: ${selectedDevice!.id}'),
              ElevatedButton(
                onPressed: () {
                  // Realiza acciones con el dispositivo conectado
                },
                child: const Text('Realizar Acciones'),
              ),
            ],
          ),
      ],
    );
  }
}
