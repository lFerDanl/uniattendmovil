import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniattendmovil/providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileItem('Name', user.name),
                  _buildProfileItem('Email', user.email),
                  _buildProfileItem('City', user.city),
                  _buildProfileItem('Role', user.role),
                  _buildProfileItem('Telefono', user.telefono),
                  _buildProfileItem('Direccion', user.direccion),
                  _buildProfileItem('CI', user.ci),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
