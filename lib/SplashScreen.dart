import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Agrega un temporizador para navegar a la pantalla principal después de 2 segundos.
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const HomeScreen()), // Reemplaza 'RandomWords' con el nombre correcto de tu pantalla principal.
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFF8BE3E1), // Color de fondo de la pantalla de presentación
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reemplaza el texto con una imagen
            Image.asset(
              'assets/images/SIFGA.png', // Ruta de la imagen en tus recursos
              width: 150, // Ancho de la imagen (ajusta según tus necesidades)
              height: 150, // Alto de la imagen (ajusta según tus necesidades)
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Hydro Control V1.0',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
