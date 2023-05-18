import 'package:flutter/material.dart';
import 'package:reminders_app/components/auth_form.dart';
import 'package:reminders_app/components/custom_app_bar.dart';
import 'package:reminders_app/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AuthForm(
        type: 'signup',
        title: 'Registrate',
        firstBox: 'Correo',
        secondBox: 'Contraseña',
        btText: 'Crear cuenta',
        linkText: 'Volver',
      ),
      appBar: const CustomAppBar(
        title: 'Reminders App',
        titleColor: kLightBackground,
      ),
      backgroundColor: kAccentColor.withOpacity(0.8),
    );
  }
}
