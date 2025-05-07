import 'package:flutter/material.dart';
import 'package:ecosmart_app/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => 
                  value!.isEmpty ? 'Campo requerido' : 
                  !value.contains('@') ? 'Email inválido' : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                validator: (value) => 
                  value!.length < 6 ? 'Mínimo 6 caracteres' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await AuthService.register(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                      'operario' // O el rol seleccionado
                    );
                    
                    if (success) {
                      Fluttertoast.showToast(msg: '¡Registro exitoso!');
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      Fluttertoast.showToast(msg: 'Error en el registro');
                    }
                  }
                },
                child: const Text('Crear cuenta'),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: const Text('¿Ya tienes cuenta? Inicia sesión'),
              )
            ],
          ),
        ),
      ),
    );
  }
}