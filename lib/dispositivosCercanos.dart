import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class DispositivosCercanosScreen extends StatefulWidget {
  @override
  _DispositivosCercanosScreenState createState() =>
      _DispositivosCercanosScreenState();
}

class _DispositivosCercanosScreenState
    extends State<DispositivosCercanosScreen> {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDiscoveryResult> results = [];
  bool isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions().then((_) {
      _startDiscovery();
    });
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.location,
    ].request();

    print("Permisos Bluetooth: ${statuses[Permission.bluetooth]}");
    print("Permisos Ubicación: ${statuses[Permission.location]}");
  }

  _startDiscovery() {
    setState(() {
      isDiscovering = true;
    });

    bluetooth.startDiscovery().listen((discoveryResult) {
      setState(() {
        if (!results.any((result) =>
            result.device.address == discoveryResult.device.address)) {
          results.add(discoveryResult);
        }
      });
    }).onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos Cercanos'),
        actions: [
          if (isDiscovering)
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          else
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _startDiscovery,
            )
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return ListTile(
            title: Text(result.device.name ?? "Desconocido"),
            subtitle: Text('Dirección: ${result.device.address}'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DeviceDetailScreen(device: result.device),
              ));
            },
          );
        },
      ),
    );
  }
}

class DeviceDetailScreen extends StatefulWidget {
  final BluetoothDevice device;

  DeviceDetailScreen({required this.device});

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  BluetoothConnection? _connection;
  bool _isConnected = false;

  _connectToDevice() async {
    try {
      var connection =
          await BluetoothConnection.toAddress(widget.device.address);
      setState(() {
        _connection = connection;
        _isConnected = true;
      });

      _connection?.input?.listen((data) {
        // TODO: Handle incoming data
      })?.onDone(() {
        setState(() {
          _isConnected = false;
        });
      });
    } catch (e) {
      print("Error connecting to device: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name ?? "Unknown Device"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Device Name: ${widget.device.name ?? 'Unknown'}"),
            SizedBox(height: 10),
            Text("Device Address: ${widget.device.address}"),
            SizedBox(height: 10),
            Text(
                "Connection Status: ${_isConnected ? 'Connected' : 'Disconnected'}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: !_isConnected ? _connectToDevice : null,
              child: Text("Conectarse"),
            ),
            // TODO: Add more details and controls as needed
          ],
        ),
      ),
    );
  }
}
