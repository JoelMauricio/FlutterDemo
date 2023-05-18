import 'package:flutter/material.dart';
import 'package:reminders_app/components/auth_form.dart';
import 'package:reminders_app/components/custom_app_bar.dart';
import 'package:reminders_app/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AuthForm(
        type: 'login',
        title: 'Iniciar Sesion',
        firstBox: 'Correo',
        secondBox: 'Contraseña',
        btText: 'Iniciar sesion',
        linkText: 'No tienes cuenta?',
      ),
      appBar: const CustomAppBar(
        title: 'Reminders App',
        titleColor: kLightBackground,
      ),
      backgroundColor: kAccentColor.withOpacity(0.8),
    );
  }
}
