import 'package:flutter/material.dart';
import 'package:uniattendmovil/models/programacion_model.dart';
import 'package:uniattendmovil/services/programacion_service.dart';

class ProgramacionScreen extends StatefulWidget {
  @override
  _ProgramacionScreenState createState() =>
      _ProgramacionScreenState();
}

class _ProgramacionScreenState
    extends State<ProgramacionScreen> {
  final ProgramacionService programacionService = ProgramacionService();
  List<Programacion> programaciones = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadProgramaciones();
  }

  Future<void> loadProgramaciones() async {
    try {
      List<Programacion> loadedProgramaciones =
          await programacionService.listarProgramacionesUsuario();
      print('las programaciones si se guardan');
      print(loadedProgramaciones);
      setState(() {
        programaciones = loadedProgramaciones;
        print('funciona programacion');
        print(programaciones);
      });
      print("paso la funcion");

    } catch (error) {
      print('dio error en la vista');
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programaciones Académicas'),
      ),
      body: errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : ListView.builder(
              itemCount: programaciones.length,
              itemBuilder: (context, index) {
                final programacion = programaciones[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('ID: ${programacion.id}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cupos: ${programacion.cupos}'),
                              Text('Carrera(s):'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: programacion.carreras.map((carrera) {
                                  return Text('- ${carrera.nombre}');
                                }).toList(),
                              ),
                              Text('Materia: ${programacion.materia.nombre}'),
                              Text('Grupo: ${programacion.grupo.nombre}'),
                              Text('Docente: ${programacion.usuario.name}'),
                              Text('Programación Horarios:'),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: programacion.programacionHorarios.map((programacionhr) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('- Módulo: ${programacionhr.modulo.nro}'),
                                      Text('- Aula: ${programacionhr.aula.nro}'),
                                      Text('- Horario: ${programacionhr.horario.dia} ${programacionhr.horario.horarioInicio}-${programacionhr.horario.horarioFin}'),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}