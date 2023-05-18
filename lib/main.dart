import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app/components/notifier.dart';
import 'package:reminders_app/constants.dart';
import 'package:reminders_app/screens/home/home.dart';
import 'package:reminders_app/screens/signUp/sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reminders_app/screens/logIn/login_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://oxkilrtayvzauyowkndk.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im94a2lscnRheXZ6YXV5b3drbmRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODMyNTM3NzksImV4cCI6MTk5ODgyOTc3OX0.lwOuB_JwzcNzubpH7G5HNLVT93wEm2ksD0DYE76npQY',
  );

  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reminders App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (_) => const HomePage(),
            '/login': (_) => const LoginPage(),
            '/registration': (_) => const RegistrationPage(),
          },
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
