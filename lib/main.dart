import 'package:flutter/material.dart';
import 'package:hydro_control/conexion.dart';
import 'dart:async';
import 'SplashScreen.dart';
import 'side_bar.dart';
import 'riego_status.dart';
import 'programarRiego.dart';
import 'historialRiego.dart';
import 'configuracion.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'ayudaScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hydro Control V1.0",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      // home: const SplashScreen(),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) =>
            const SplashScreen(), // Pantalla de inicio (SplashScreen)
        //'/home': (context) => const HomeScreen(), // Pantalla principal (HomeScreen)
        '/conexion': (context) => const ConexionScreen(),
        '/programarRiego': (context) =>
            const ProgramarRiegoScreen(), // Agregar otras pantallas aquí
        '/historialRiego': (context) => const HistorialRiegoScreen(),
        '/configuracion': (context) => const ConfiguracionScreen(),
        '/ayudaScreen': (context) => AyudaScreen(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _HomeScreenState? state =
        context.findAncestorStateOfType<_HomeScreenState>();
    state?.setLocale(newLocale);
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Locale _locale = const Locale('es'); // Establece el idioma inicial

  // Método para cambiar el idioma
  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  bool isRiegoOn = false;
  late Timer timer;
  Duration? tiempoRestante;
  Duration? tiempoHastaProximoRiego;
  bool isBluetoothOn = false;

  @override
  void initState() {
    super.initState();

    // Simulación: Comenzar el riego después de 5 segundos (5000 milisegundos)
    timer = Timer(const Duration(seconds: 10), () {
      setState(() {
        isRiegoOn = true;
        tiempoRestante = const Duration(hours: 2, minutes: 30);
      });

      // Actualizar la duración restante cada minuto
      timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        setState(() {
          if (tiempoRestante != null) {
            tiempoRestante = tiempoRestante! - const Duration(minutes: 1);
          }
        });

        // Cuando el tiempo restante llega a cero, detener el riego
        if (tiempoRestante != null && tiempoRestante!.isNegative) {
          timer.cancel();
          setState(() {
            isRiegoOn = false;
            tiempoRestante = null;
          });
        }
      });
    });

    // Simulación: Programar el próximo riego después de 2 horas (7200 segundos)
    Timer(const Duration(seconds: 7200), () {
      setState(() {
        tiempoHastaProximoRiego = null;
      });
    });

    // Actualizar el cronómetro de los 5 segundos antes de que comience el riego
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (tiempoRestante == null) {
          tiempoRestante = const Duration(seconds: 10);
        } else if (tiempoRestante!.inSeconds > 0) {
          tiempoRestante = tiempoRestante! - const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void toggleBluetooth() async {
    if (isBluetoothOn) {
      // Aquí puedes agregar código para desactivar el Bluetooth
    } else {
      // Aquí puedes agregar código para activar el Bluetooth
    }
    setState(() {
      isBluetoothOn = !isBluetoothOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = tiempoRestante != null
        ? '${tiempoRestante!.inHours} horas ${tiempoRestante!.inMinutes.remainder(60)} minutos'
        : 'N/A';

    final formattedProximoRiego = tiempoHastaProximoRiego != null
        ? '${tiempoHastaProximoRiego!.inHours} horas ${tiempoHastaProximoRiego!.inMinutes.remainder(60)} minutos'
        : 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hydro Control"),
      ),
      drawer: const Drawer(
        child: MyDrawerContent(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: RiegoStatusWidget(
                isRiegoOn: isRiegoOn,
                tiempoRestante: formattedTime,
                tiempoHastaProximoRiego: formattedProximoRiego,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
