import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniattendmovil/providers/auth_provider.dart';
import 'package:uniattendmovil/screens/auth/login_screen.dart';
import 'package:uniattendmovil/screens/gestion_usuario/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkAuthenticationStatus(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  if (authProvider.isAuthenticated) {
                    return ProfileScreen();
                  } else {
                    return LoginScreen();
                  }
                },
              ),
          '/login': (context) => LoginScreen(),
          // '/register': (context) => RegisterScreen(),
          '/profile': (context) => ProfileScreen(),
          // '/update': (context) => UpdateUserScreen(),
          // '/users': (context) => UsersListScreen(),
        },
      ),
    );
  }
}