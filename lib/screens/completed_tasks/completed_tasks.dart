import 'package:flutter/material.dart';
import 'package:reminders_app/components/custom_app_bar.dart';
import 'package:reminders_app/constants.dart';
import 'package:reminders_app/screens/home/components/reminder_container.dart';
import 'package:reminders_app/screens/home/components/task_placeholder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final session = supabase.auth.currentSession;

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  CompletedTasksPageState createState() => CompletedTasksPageState();
}

class CompletedTasksPageState extends State<CompletedTasksPage> {
  late List completedTasks = List.empty();

  Future<void> getData() async {
    final List res = await supabase
        .from('todos')
        .select(
          '*',
        )
        .eq('user_id', session?.user.id)
        .eq('is_complete', true)
        .eq('is_deleted', false);
    setState(() {
      completedTasks = res;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 414) {
            return const Placeholder();
          } else {
            return Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      color: kAccentColor.withOpacity(0.9),
                    )),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    child: completedTasks.isEmpty
                        ? Center(
                            child: taskPlaceholder(
                                context,
                                size,
                                Icons.pending_actions_outlined,
                                'Parece que tienes tareas pendientes.',
                                true),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(kDefaultPadding / 4),
                            itemCount: completedTasks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: kDefaultPadding / 2),
                                child: reminderContainer(
                                    size, completedTasks[index], context, true),
                              );
                            },
                          ),
                  ),
                )
              ],
            );
          }
        },
      ),
      appBar: const CustomAppBar(
        title: 'Completados',
        isAuth: false,
        isReturnable: true,
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
