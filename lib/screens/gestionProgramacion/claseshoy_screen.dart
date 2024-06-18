import 'package:flutter/material.dart';
import 'package:uniattendmovil/models/asistenciae_model.dart';
import 'package:uniattendmovil/models/programacion_model.dart';
import 'package:uniattendmovil/services/asistencia_service.dart';
import 'package:uniattendmovil/services/programacion_service.dart';

class ClaseshoyScreen extends StatefulWidget {
  @override
  _ClaseshoyScreenState createState() => _ClaseshoyScreenState();
}

class _ClaseshoyScreenState extends State<ClaseshoyScreen> {
  final ProgramacionService programacionService = ProgramacionService();
  final AsistenciaService asistenciaService = AsistenciaService();
  List<Programacion> programaciones = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadProgramaciones();
  }

  Future<void> loadProgramaciones() async {
    try {
      List<Programacion> loadedProgramaciones = await programacionService.clasesHoy();
      
      // Cargar asistencias para cada programación
      for (var programacion in loadedProgramaciones) {
        for (var programacionHorario in programacion.programacionHorarios) {
          AsistenciaE? asistencia = await asistenciaService.getAsistenciaHoy(programacionHorario.id);
          if (asistencia != null) {
            programacion.asistencia = asistencia;
            break; // Si encontramos la asistencia, salimos del bucle interno
          }
        }
      }

      setState(() {
        programaciones = loadedProgramaciones;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
    }
  }

  Future<void> registrarAsistencia(String programacionHorarioId) async {
    try {
      await asistenciaService.registrarAsistencia(programacionHorarioId);
      loadProgramaciones();
    } catch (error) {
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
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text('- Asistencia: ${programacion.asistencia!.estado}'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              registrarAsistencia(programacionhr.id.toString(),);
                                            },
                                            child: Text('Registrar'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                }).toList(),
                              ),
                              // programacion.asistencia != null
                              //     ? Column(
                              //         crossAxisAlignment: CrossAxisAlignment.start,
                              //         children: [
                              //           Text('Asistencia: ${programacion.asistencia!.estado}'), // Aquí puedes mostrar otros detalles de la asistencia si es necesario
                              //         ],
                              //       )
                              //     : Container(), // Opcional: Mostrar un contenedor vacío si no hay asistencia
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