import 'package:demo_game_night/utilities/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/cubits/auth_cubit/auth_cubit.dart';
import '../../domain/entities/user_address.dart';

class RegisterScreenStep2 extends StatefulWidget {
  const RegisterScreenStep2({super.key});

  @override
  State<RegisterScreenStep2> createState() => _RegisterScreenStep2State();
}

class _RegisterScreenStep2State extends State<RegisterScreenStep2> {
  final _formKey = GlobalKey<FormState>();
  final _plzController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _plzController.dispose();
    _streetController.dispose();
    _numberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final address = UserAddress(
        plz: _plzController.text,
        street: _streetController.text,
        number: _numberController.text,
        location: _locationController.text,
      );

      context.read<AuthCubit>().submitAdress(address);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adresse eingeben')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => AuthGate()),
              (route) => false,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _streetController,
                  decoration: const InputDecoration(labelText: 'Straße'),
                  validator: (value) =>
                      value!.isEmpty ? 'Straße erforderlich' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(labelText: 'Nummer'),
                  validator: (value) =>
                      value!.isEmpty ? 'Nummer erforderlich' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _plzController,
                  decoration: const InputDecoration(labelText: 'PLZ'),
                  validator: (value) =>
                      value!.isEmpty ? 'PLZ erforderlich' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Ort'),
                  validator: (value) =>
                      value!.isEmpty ? 'Ort erforderlich' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Registrieren'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
