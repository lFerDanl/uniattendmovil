import 'package:flutter/material.dart';
import 'package:uniattendmovil/models/licenciaform_model.dart';
import 'package:uniattendmovil/services/licencia_service.dart';

class CrearLicenciaScreen extends StatefulWidget {
  @override
  _CrearLicenciaScreenState createState() => _CrearLicenciaScreenState();
}

class _CrearLicenciaScreenState extends State<CrearLicenciaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LicenciaService licenciaService = LicenciaService();
  LicenciaForm _licencia = LicenciaForm(tipo: '', fechaInicio: '', fechaFin: '');

  DateTime? _selectedFechaInicio; // Variable para almacenar la fecha de inicio seleccionada
  DateTime? _selectedFechaFin; // Variable para almacenar la fecha de fin seleccionada

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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await licenciaService.guardarLicencia(_licencia.toJson());
        Navigator.pushReplacementNamed(context, '/licencias'); // Regresa a la pantalla anterior después de guardar
      } catch (error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error al guardar la licencia: $error'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Licencia'),
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