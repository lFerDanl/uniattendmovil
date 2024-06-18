import 'package:flutter/material.dart';

class AsistenciasScreen extends StatelessWidget {
  final List<Asistencia> asistencias = [
    Asistencia(
      id: 1,
      programacionHorario: ProgramacionHorario(
        programacionAcademica: Programacion(
          materia: Materia(nombre: 'Programación Avanzada'),
          grupo: Grupo(nombre: 'G01'),
        ),
        horario: Horario(dia: 'Lunes', horarioInicio: '08:00', horarioFin: '10:00'),
      ),
      usuario: User(name: 'Profesor A'),
      fecha: '2024-06-01',
      hora: '08:30',
      estado: 'Presente',
    ),
    Asistencia(
      id: 2,
      programacionHorario: ProgramacionHorario(
        programacionAcademica: Programacion(
          materia: Materia(nombre: 'Contabilidad Financiera'),
          grupo: Grupo(nombre: 'G02'),
        ),
        horario: Horario(dia: 'Martes', horarioInicio: '10:00', horarioFin: '12:00'),
      ),
      usuario: User(name: 'Profesor B'),
      fecha: '2024-06-02',
      hora: '10:15',
      estado: 'Ausente',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registros de Asistencias'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registros de Asistencias',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: asistencias.length,
                itemBuilder: (context, index) {
                  final asistencia = asistencias[index];
                  return Card(
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID: ${asistencia.id}'),
                          SizedBox(height: 8.0),
                          Text('Materia: ${asistencia.programacionHorario.programacionAcademica.materia.nombre}'),
                          SizedBox(height: 8.0),
                          Text('Grupo: ${asistencia.programacionHorario.programacionAcademica.grupo.nombre}'),
                          SizedBox(height: 8.0),
                          Text('Docente: ${asistencia.usuario.name}'),
                          SizedBox(height: 8.0),
                          Text('Horario: ${asistencia.programacionHorario.horario.dia} ${asistencia.programacionHorario.horario.horarioInicio}-${asistencia.programacionHorario.horario.horarioFin}'),
                          SizedBox(height: 8.0),
                          Text('Fecha: ${asistencia.fecha}'),
                          SizedBox(height: 8.0),
                          Text('Hora: ${asistencia.hora}'),
                          SizedBox(height: 8.0),
                          Text('Estado: ${asistencia.estado}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Asistencia {
  final int id;
  final ProgramacionHorario programacionHorario;
  final User usuario;
  final String fecha;
  final String hora;
  final String estado;

  Asistencia({
    required this.id,
    required this.programacionHorario,
    required this.usuario,
    required this.fecha,
    required this.hora,
    required this.estado,
  });
}

class ProgramacionHorario {
  final Programacion programacionAcademica;
  final Horario horario;

  ProgramacionHorario({
    required this.programacionAcademica,
    required this.horario,
  });
}

class Programacion {
  final Materia materia;
  final Grupo grupo;

  Programacion({
    required this.materia,
    required this.grupo,
  });
}

class Materia {
  final String nombre;

  Materia({required this.nombre});
}

class Grupo {
  final String nombre;

  Grupo({required this.nombre});
}

class User {
  final String name;

  User({required this.name});
}

class Horario {
  final String dia;
  final String horarioInicio;
  final String horarioFin;

  Horario({
    required this.dia,
    required this.horarioInicio,
    required this.horarioFin,
  });
}

// class ProgramacionesScreen extends StatelessWidget {
//   final List<Programacion> programaciones = [
//     Programacion(
//       id: 1,
//       cupos: '30',
//       carreras: [Carrera(nombre: 'Ingeniería Informática')],
//       materia: Materia(nombre: 'Programación Avanzada'),
//       grupo: Grupo(nombre: 'G01'),
//       usuario: User(name: 'Profesor A'),
//       programacionHorarios: [
//         ProgramacionHorario(
//           modulo: Modulo(nro: 1),
//           aula: Aula(nro: 101),
//           horario: Horario(dia: 'Lunes', horarioInicio: '08:00', horarioFin: '10:00'),
//         ),
//         ProgramacionHorario(
//           modulo: Modulo(nro: 2),
//           aula: Aula(nro: 102),
//           horario: Horario(dia: 'Miércoles', horarioInicio: '08:00', horarioFin: '10:00'),
//         ),
//       ],
//     ),
//     Programacion(
//       id: 2,
//       cupos: '25',
//       carreras: [Carrera(nombre: 'Administración de Empresas')],
//       materia: Materia(nombre: 'Contabilidad Financiera'),
//       grupo: Grupo(nombre: 'G02'),
//       usuario: User(name: 'Profesor B'),
//       programacionHorarios: [
//         ProgramacionHorario(
//           modulo: Modulo(nro: 3),
//           aula: Aula(nro: 201),
//           horario: Horario(dia: 'Martes', horarioInicio: '10:00', horarioFin: '12:00'),
//         ),
//         ProgramacionHorario(
//           modulo: Modulo(nro: 4),
//           aula: Aula(nro: 202),
//           horario: Horario(dia: 'Jueves', horarioInicio: '10:00', horarioFin: '12:00'),
//         ),
//       ],
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Programaciones Académicas'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Programaciones Académicas',
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: programaciones.length,
//                 itemBuilder: (context, index) {
//                   final programacion = programaciones[index];
//                   return Card(
//                     elevation: 3.0,
//                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('ID: ${programacion.id}'),
//                           SizedBox(height: 8.0),
//                           Text('Cupos: ${programacion.cupos}'),
//                           SizedBox(height: 8.0),
//                           Text('Carrera(s):'),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: programacion.carreras.map((carrera) {
//                               return Text('- ${carrera.nombre}');
//                             }).toList(),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text('Materia: ${programacion.materia.nombre}'),
//                           SizedBox(height: 8.0),
//                           Text('Grupo: ${programacion.grupo.nombre}'),
//                           SizedBox(height: 8.0),
//                           Text('Docente: ${programacion.usuario.name}'),
//                           SizedBox(height: 8.0),
//                           Text('Programación Horarios:'),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: programacion.programacionHorarios.map((programacionhr) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('- Módulo: ${programacionhr.modulo.nro}'),
//                                   Text('- Aula: ${programacionhr.aula.nro}'),
//                                   Text('- Horario: ${programacionhr.horario.dia} ${programacionhr.horario.horarioInicio}-${programacionhr.horario.horarioFin}'),
//                                   SizedBox(height: 8.0),
//                                 ],
//                               );
//                             }).toList(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Programacion {
//   final int id;
//   final String cupos;
//   final List<Carrera> carreras;
//   final Materia materia;
//   final Grupo grupo;
//   final User usuario;
//   final List<ProgramacionHorario> programacionHorarios;

//   Programacion({
//     required this.id,
//     required this.cupos,
//     required this.carreras,
//     required this.materia,
//     required this.grupo,
//     required this.usuario,
//     required this.programacionHorarios,
//   });
// }

// class Carrera {
//   final String nombre;

//   Carrera({required this.nombre});
// }

// class Materia {
//   final String nombre;

//   Materia({required this.nombre});
// }

// class Grupo {
//   final String nombre;

//   Grupo({required this.nombre});
// }

// class User {
//   final String name;

//   User({required this.name});
// }

// class ProgramacionHorario {
//   final Modulo modulo;
//   final Aula aula;
//   final Horario horario;

//   ProgramacionHorario({required this.modulo, required this.aula, required this.horario});
// }

// class Modulo {
//   final int nro;

//   Modulo({required this.nro});
// }

// class Aula {
//   final int nro;

//   Aula({required this.nro});
// }

// class Horario {
//   final String dia;
//   final String horarioInicio;
//   final String horarioFin;

//   Horario({required this.dia, required this.horarioInicio, required this.horarioFin});
// }