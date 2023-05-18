import 'package:flutter/material.dart';
import 'package:reminders_app/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Widget newTaskDialog(BuildContext context) {
  final TextEditingController nombreTareaController = TextEditingController();
  Size size = MediaQuery.of(context).size;

  void closeDialog() {
    Navigator.of(context).pop();
  }

  void handleNewTask() async {
    final newTask = await supabase.from('todos').insert({
      'user_id': supabase.auth.currentUser?.id,
      'task': nombreTareaController.text
    });
    closeDialog();
  }

  Dialog customDialog = Dialog(
    backgroundColor: Theme.of(context).colorScheme.background,
    child: Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width - (2 * kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(children: <Widget>[
        TextField(
          controller: nombreTareaController,
          decoration: const InputDecoration(
            hintText: 'Nombre para su nueva tarea.',
            label: Text('Nueva Tarea'),
          ),
        ),
        const Spacer(
          flex: 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                      Size(size.width / 3.5, size.height / 12.5))),
              onPressed: () {
                handleNewTask();
              },
              child: Text(
                'Guardar',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
            ),
          ],
        ),
      ]),
    ),
  );
  return customDialog;
}
