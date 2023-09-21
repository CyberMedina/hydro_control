import 'package:flutter/material.dart';

class RiegoStatusWidget extends StatelessWidget {
  final bool
      isRiegoOn; // Un booleano para indicar si el riego está encendido o apagado
  final String tiempoRestante; // Una cadena para mostrar el tiempo restante

  const RiegoStatusWidget(
      {super.key,
      required this.isRiegoOn,
      required this.tiempoRestante,
      required String tiempoHastaProximoRiego});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Centra vertical y horizontalmente
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagen personalizada del estado del riego
          Image.asset(
            isRiegoOn
                ? 'assets/images/riego_on.png'
                : 'assets/images/riego_off.png',
            width: 55.0,
            height: 55.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            isRiegoOn ? 'Riego Encendido' : 'Riego Apagado',
            style: TextStyle(
              fontSize: 18.0,
              color: isRiegoOn ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Tiempo Restante: $tiempoRestante',
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
