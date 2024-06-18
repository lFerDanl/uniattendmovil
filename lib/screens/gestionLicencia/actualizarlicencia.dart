import 'package:flutter/material.dart';
import 'package:uniattendmovil/models/licenciaform_model.dart';
import 'package:uniattendmovil/services/licencia_service.dart';

class ActualizarLicenciaScreen extends StatefulWidget {

  ActualizarLicenciaScreen();

  @override
  _ActualizarLicenciaScreenState createState() =>
      _ActualizarLicenciaScreenState();
}

class _ActualizarLicenciaScreenState extends State<ActualizarLicenciaScreen> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LicenciaService licenciaService = LicenciaService();
  LicenciaForm _licencia = LicenciaForm(tipo: '', fechaInicio: '', fechaFin: '');

  DateTime? _selectedFechaInicio; // Variable para almacenar la fecha de inicio seleccionada
  DateTime? _selectedFechaFin;
  late int licenciaId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    licenciaId = args['id'];
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> datosActualizados = {
        'tipo': _licencia.tipo,
        'fechaInicio': _licencia.fechaInicio,
        'fechaFin': _licencia.fechaFin,
      };

      try {
        await licenciaService.actualizarLicencia(licenciaId, datosActualizados);
        Navigator.pushReplacementNamed(context, '/licencias');
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error al actualizar la licencia: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _selectFechaInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedFechaInicio) {
      setState(() {
        _selectedFechaInicio = picked;
        _licencia.fechaInicio = _selectedFechaInicio!.toIso8601String().substring(0, 10); // Formato ISO para la fecha
      });
    }
  }

  Future<void> _selectFechaFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedFechaFin) {
      setState(() {
        _selectedFechaFin = picked;
        _licencia.fechaFin = _selectedFechaFin!.toIso8601String().substring(0, 10); // Formato ISO para la fecha
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Licencia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Tipo de Licencia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tipo de licencia';
                  }
                  return null;
                },
                onSaved: (value) {
                  _licencia.tipo = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () => _selectFechaInicio(context),
                child: Text(_selectedFechaInicio == null ? 'Seleccionar Fecha de Inicio' : 'Fecha de Inicio Seleccionada: ${_selectedFechaInicio!.toString().substring(0, 10)}'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () => _selectFechaFin(context),
                child: Text(_selectedFechaFin == null ? 'Seleccionar Fecha de Fin' : 'Fecha de Fin Seleccionada: ${_selectedFechaFin!.toString().substring(0, 10)}'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Guardar Licencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}