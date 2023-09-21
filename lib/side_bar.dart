import 'package:flutter/material.dart';

class MyDrawerContent extends StatelessWidget {
  const MyDrawerContent({super.key});

  // Función para cerrar el drawer.
  void _closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: const Color(0xFF8BE3E1),
          child: DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Menu"),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _closeDrawer(
                        context); // Llama a la función para cerrar el drawer.
                  },
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('Conexión'),
          onTap: () {
            try {
              _closeDrawer(context);
              Navigator.pushNamed(context,
                  '/conexion'); // Navega a la pantalla de programar riego
            } catch (e) {
              print('Error al cargar la conexion: $e');
            }
          },
        ),
        ListTile(
          title: const Text('Programar riego'),
          onTap: () {
            try {
              _closeDrawer(context);
              Navigator.pushNamed(context,
                  '/programarRiego'); // Navega a la pantalla de programar riego
            } catch (e) {
              print('Error al programar el riego: $e');
            }
          },
        ),
        ListTile(
          title: const Text('Historial de riego'),
          onTap: () {
            try {
              _closeDrawer(context);
              Navigator.pushNamed(context,
                  '/historialRiego'); // Navega a la pantalla de programar riego
            } catch (e) {
              print('Error al cargar el historial de riego: $e');
            }
          },
        ),
        ListTile(
          title: const Text('Configuración'),
          onTap: () {
            try {
              _closeDrawer(context);
              Navigator.pushNamed(context,
                  '/configuracion'); // Navega a la pantalla de programar riego
            } catch (e) {
              print('Error al cargar el panel de configuración: $e');
            }
          },
        ),
        ListTile(
          title: const Text('Ayuda'),
          onTap: () {
            try {
              _closeDrawer(context);
              Navigator.pushNamed(context,
                  '/ayudaScreen'); // Navega a la pantalla de programar riego
            } catch (e) {
              print('Error al cargar el panel de ayuda: $e');
            }
          },
        ),
        // Agrega más opciones según sea necesario.
      ],
    );
  }
}
