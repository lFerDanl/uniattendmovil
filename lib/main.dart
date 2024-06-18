import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniattendmovil/providers/auth_provider.dart';
import 'package:uniattendmovil/screens/auth/login_screen.dart';
import 'package:uniattendmovil/screens/ejemplo.dart';
import 'package:uniattendmovil/screens/gestionLicencia/actualizarlicencia.dart';
import 'package:uniattendmovil/screens/gestionLicencia/crearlicencia.dart';
import 'package:uniattendmovil/screens/gestionLicencia/listalicencia_screen.dart';
import 'package:uniattendmovil/screens/gestionProgramacion/claseshoy_screen.dart';
import 'package:uniattendmovil/screens/gestionProgramacion/programacion_screen.dart';
import 'package:uniattendmovil/screens/gestion_usuario/profile_screen.dart';
import 'package:uniattendmovil/screens/home/home_screen.dart';
import 'package:uniattendmovil/screens/home/inicio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return FutureBuilder<bool>(
              future: authProvider.isAuthenticated(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  if (snapshot.data == true) {
                    return HomeScreens();
                  } else {
                    return Inicio();
                  }
                }
              },
            );
          },
        ),
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => HomeScreens(),
          '/profile': (context) => ProfileScreen(),
          '/programacion': (context) => ProgramacionScreen(),
          '/claseshoy': (context) => ClaseshoyScreen(),
          '/licencias': (context) => ListaLicenciaScreen(),
          '/crearlicencia': (context) => CrearLicenciaScreen(),
          '/actualizarlicencia': (context) => ActualizarLicenciaScreen(),
          // '/ejemplo': (context) => ProgramacionesScreen(),
          '/ejemplo': (context) => AsistenciasScreen(),
          '/inicio': (context) => Inicio(),
        },
      ),
    );
  }
}