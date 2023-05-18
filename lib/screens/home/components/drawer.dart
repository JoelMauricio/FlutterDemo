import 'package:flutter/material.dart';
import 'package:reminders_app/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Widget homeDrawer(BuildContext context) {
  late User? user = supabase.auth.currentUser;

  void handleLogout() {
    supabase.auth.signOut();
    if (supabase.auth.currentSession == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  return Drawer(
    elevation: 10000,
    backgroundColor: Theme.of(context).colorScheme.onBackground,
    child: SizedBox(
      width: MediaQuery.of(context).size.width / 1.4,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size(80, 80),
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.5)),
            accountName: user == null
                ? Text(
                    'usuario',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    textScaleFactor: 1.2,
                  )
                : Text(user.email.toString().split('@')[0],
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
            accountEmail: user == null
                ? Text('correo',
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary))
                : Text(user.email.toString(),
                    textScaleFactor: 1,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary)),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: kSecondaryColor,
              child: Icon(
                Icons.person,
                size: 60,
                color: kAccentColor,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text(
              'Cerrar Sesion',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onTap: () => handleLogout(),
            hoverColor: kSecondaryColor,
          ),
        ],
      ),
    ),
  );
}
