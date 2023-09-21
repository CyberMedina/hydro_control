import 'package:flutter/material.dart';
// Importa las localizaciones

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Lista de idiomas admitidos
    return ['en', 'es', 'pt', 'de', 'zh', 'ja'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale); // Crea una instancia de AppLocalizations
    await localizations.load(); // Carga la localización según el idioma seleccionado
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Map<String, String> _localizedStrings = {}; // Aquí almacena las traducciones

  Future<void> load() async {
    // Carga las traducciones según el idioma seleccionado (this.locale)
    // Puedes implementar esta lógica de acuerdo a tu estructura de traducciones
    // Por ejemplo, cargar desde archivos JSON o bases de datos.
    // Aquí asigna las traducciones a _localizedStrings.
  }

  // Define métodos para acceder a las traducciones, por ejemplo:
  String get titulo {
    return _localizedStrings['titulo'] ?? 'Título';
  }
}
