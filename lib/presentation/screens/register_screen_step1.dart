import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/cubits/auth_cubit/auth_cubit.dart';
import 'register_screen_step2.dart';

class RegisterScreenStep1 extends StatefulWidget {
  const RegisterScreenStep1({super.key});

  @override
  State<RegisterScreenStep1> createState() => _RegisterScreenStep1State();
}

class _RegisterScreenStep1State extends State<RegisterScreenStep1> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String? _errorText;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      await authCubit.submitBasicInfo(
        username: _usernameController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrieren')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAwaitingAddress) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterScreenStep2()),
            );
          } else if (state is AuthError) {
            setState(() {
              _errorText = state.message;
            });
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  if (_errorText != null)
                    Text(_errorText!, style: const TextStyle(color: Colors.red)),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Benutzername'),
                    validator: (value) =>
                        value!.isEmpty ? 'Benutzername erforderlich' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Passwort'),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 4 ? 'Mind. 4 Zeichen' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'Vorname'),
                    validator: (value) =>
                        value!.isEmpty ? 'Vorname erforderlich' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Nachname'),
                    validator: (value) =>
                        value!.isEmpty ? 'Nachname erforderlich' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Weiter'),
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
