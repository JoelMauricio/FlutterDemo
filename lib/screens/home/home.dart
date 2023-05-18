import 'package:flutter/material.dart';
import 'package:reminders_app/components/custom_app_bar.dart';
import 'package:reminders_app/constants.dart';
import 'package:reminders_app/screens/home/components/category_card.dart';
import 'package:reminders_app/screens/home/components/drawer.dart';
import 'package:reminders_app/screens/home/components/new_task_dialog.dart';
import 'package:reminders_app/screens/home/components/reminder_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
final session = supabase.auth.currentSession;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late int total = 0;
  late List tasks = List.empty();
  late List completedTasks = List.empty();
  void getData() async {
    final List res = await supabase
        .from('todos')
        .select('*')
        .eq('user_id', session?.user.id);
    final List res2 = await supabase
        .from('todos')
        .select(
          '*',
        )
        .eq('user_id', session?.user.id)
        .eq('is_complete', false);
    final List res3 = await supabase
        .from('todos')
        .select(
          '*',
        )
        .eq('user_id', session?.user.id)
        .eq('is_complete', true);
    setState(() {
      total = res.length;
      tasks = res2;
      completedTasks = res3;
    });
  }

  @override
  void initState() {
    getData();
    if (session == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 414) {
            return _placeholder();
          } else {
            return mobileConfig(
                context, total, tasks.length, completedTasks.length, tasks);
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  // add the create new reminder functionality
                  context: context,
                  builder: (BuildContext context) => newTaskDialog(context));
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(kDefaultPadding),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: const Icon(
              Icons.add,
              color: kLightBackground,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: const CustomAppBar(
        title: 'Mis tareas',
        isAuth: false,
      ),
      extendBodyBehindAppBar: true,
      drawer: homeDrawer(context),
    );
  }

  Widget mobileConfig(BuildContext context, int total, int amount,
      int completedAmount, List tareas) {
    Size size = MediaQuery.of(context).size;

    void completeTask(tarea) async {
      await supabase
          .from('todos')
          .update({'is_complete': true}).match({'id': tarea['id']});
      getData();
    }

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
          // Categories
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          categoryCard(size, kAccentColor, 'Completados',
                              Icons.task, kDarkText, total, completedAmount)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // tasks
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: kDefaultPadding / 2,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: (size.height * 0.4) * 0.1,
                    width: double.maxFinite,
                    child: Text(
                      'Pendientes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.0225,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding / 10),
                      child: tareas.isEmpty == true
                          ? taskPlaceholder(context, size)
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.all(kDefaultPadding / 4),
                              itemCount: amount,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  direction: DismissDirection.horizontal,
                                  onDismissed: (DismissDirection direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      completeTask(tareas[index]);
                                    } else if (direction ==
                                        DismissDirection.startToEnd) {
                                      // deleteTask(tareas[index]);
                                    }
                                  },
                                  //left option
                                  background: dissmisableBackground(
                                      Colors.red,
                                      Icons.delete_outline_outlined,
                                      size,
                                      false),
                                  // right option
                                  secondaryBackground: dissmisableBackground(
                                      Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withOpacity(0.6),
                                      Icons.task_alt_rounded,
                                      size,
                                      true),
                                  key: UniqueKey(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: kDefaultPadding / 2),
                                    child: reminderContainer(
                                        size, tareas[index], context),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _placeholder() {
  return const Placeholder();
}

Widget taskPlaceholder(BuildContext context, Size size) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height / 4,
            width: size.width / 2,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary),
            child: Icon(
              Icons.find_in_page,
              color: Theme.of(context).colorScheme.tertiary,
              size: size.height / 6,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Text(
            'Parece que no tienes tareas pendientes.',
            style: TextStyle(fontSize: size.height * 0.025),
          )
        ],
      ),
    ),
  );
}

Widget dissmisableBackground(
    Color color, IconData iconData, Size size, bool isRight) {
  return Padding(
    padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
    child: Container(
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(kDefaultPadding / 4)),
        color: color,
      ),
      alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: isRight
            ? const EdgeInsets.only(right: kDefaultPadding / 2.5)
            : const EdgeInsets.only(left: kDefaultPadding / 2.5),
        child: Icon(
          iconData,
          color: Colors.white,
          size: size.height * 0.045,
        ),
      ),
    ),
  );
}
