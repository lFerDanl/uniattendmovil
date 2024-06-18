import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 2, 148, 153), // Cambia este color al que desees
        child: Stack(
          children: <Widget>[
            // Fondo con burbujas moradas pequeñas
            Positioned(
              top: 20,
              left: 20,
              child: _buildBubble(80, 80, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              top: 70,
              right: 40,
              child: _buildBubble(40, 40, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              top: 120,
              left: 80,
              child: _buildBubble(50, 50, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              top: 170,
              right: 60,
              child: _buildBubble(60, 60, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              top: 220,
              left: 140,
              child: _buildBubble(70, 70, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: _buildBubble(30, 30, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 70,
              right: 20,
              child: _buildBubble(40, 40, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 120,
              left: 80,
              child: _buildBubble(50, 50, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 170,
              right: 60,
              child: _buildBubble(60, 60, Colors.deepPurple.withOpacity(0.3)),
            ),
            Positioned(
              bottom: 220,
              left: 140,
              child: _buildBubble(70, 70, Colors.deepPurple.withOpacity(0.3)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/utils/splash.jpg',
                    width: 200, // Manteniendo el tamaño de la imagen
                    height: 200, // Manteniendo el tamaño de la imagen
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido al sistema de asistencia',
                    style: TextStyle(
                      color: Colors.white, // Ajusta el color del texto
                      fontSize: 18, // Ajusta el tamaño del texto
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Iniciar Sesión'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255), // Color del texto del botón
                      backgroundColor: Colors.deepPurple, // Color del botón
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(double width, double height, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}