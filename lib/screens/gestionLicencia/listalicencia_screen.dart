import 'package:flutter/material.dart';
import 'package:uniattendmovil/models/licencia_model.dart';
import 'package:uniattendmovil/services/licencia_service.dart';

class ListaLicenciaScreen extends StatefulWidget {
  @override
  _ListaLicenciaScreenState createState() => _ListaLicenciaScreenState();
}

class _ListaLicenciaScreenState extends State<ListaLicenciaScreen> {
  final LicenciaService licenciaService = LicenciaService(); // Asegúrate de tener el servicio de licencias correctamente implementado
  List<Licencia> licencias = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadLicencias();
  }

  Future<void> loadLicencias() async {
    try {
      List<Licencia> loadedLicencias = await licenciaService.listarLicenciasUsuario();
      setState(() {
        licencias = loadedLicencias;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  void deleteLicencia(int id) async {
    try {
      await licenciaService.eliminarLicencia(id.toString());
      loadLicencias();
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  void navigateToUpdate(int id) {
    Navigator.pushNamed(
      context,
      '/actualizarlicencia',
      arguments: {'id': id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Licencias'),
      ),
      body: errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : licencias.isEmpty
              ? Center(child: Text('No hay licencias disponibles'))
              : ListView.builder(
                  itemCount: licencias.length,
                  itemBuilder: (context, index) {
                    final licencia = licencias[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${licencia.tipo}'),
                            Text('Fecha de Inicio: ${licencia.fechaInicio}'),
                            Text('Fecha de Fin: ${licencia.fechaFin}'),
                            Text('Estado: ${licencia.estado}'),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () => deleteLicencia(licencia.id),
                                  child: Text('Eliminar'),
                                ),
                                SizedBox(width: 8.0),
                                ElevatedButton(
                                  onPressed: () => navigateToUpdate(licencia.id),
                                  child: Text('Actualizar'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/crearlicencia');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}