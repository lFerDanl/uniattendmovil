import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniattendmovil/components/utils/sidebar.dart';
import 'package:uniattendmovil/providers/auth_provider.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UniAttend'),
      ),
      drawer: const SideBar(), // Asegúrate de definir correctamente el Widget del sidebar
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildProfileCard('Nombre', user.name),
                  _buildProfileCard('Email', user.email),
                  _buildProfileCard('Ciudad', user.city),
                  _buildProfileCard('Telefono', user.telefono),
                  _buildProfileCard('Direccion', user.direccion),
                  _buildProfileCard('C.I.', user.ci),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileCard(String label, String value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}