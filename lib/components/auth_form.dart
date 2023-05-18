import 'package:flutter/material.dart';
import 'package:reminders_app/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key? key,
    required this.type,
    this.title,
    this.firstBox,
    this.secondBox,
    this.btText,
    this.linkText,
  })  : assert(type == 'login' || type == 'signup'),
        super(key: key);

  final String? type;
  final String? title;
  final String? firstBox;
  final String? secondBox;
  final String? btText;
  final String? linkText;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> handleLogIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    goToHome(session);
  }

  void goToSignUp() {
    Navigator.of(context).pushReplacementNamed('/registration');
  }

  Future<void> handleSignUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    // final User? user = res.user;
    goToHome(session);
  }

  goToHome(session) {
    if (session != null) {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  goBack() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final kTitleStyle = TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.primary,
    );
    final kActionLinkStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    );
    final kFormTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onPrimary,
    );
    final kActionButtonStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.background,
    );
    return Center(
      child: Container(
        // setting the size of the white container
        height: size.height,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          //adding the border radius for only the top bar of the container
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
          boxShadow: [
            //adding the shadow
            BoxShadow(
              color: kLightText.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 50,
              blurStyle: BlurStyle.outer,
            )
          ],
          color: Theme.of(context)
              .colorScheme
              .background, // setting the color of the background
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title.toString(),
                style: kTitleStyle,
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                width: 400.0,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: widget.firstBox.toString(),
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelStyle: kFormTextStyle),
                ),
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                width: 400.0,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: widget.secondBox.toString(),
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      labelStyle: kFormTextStyle),
                ),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: widget.type == 'login'
                    ? () {
                        handleLogIn();
                      }
                    : () {
                        handleSignUp();
                      },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary),
                  minimumSize: MaterialStateProperty.all<Size>(
                    //setting the size of the button
                    const Size(400.0, 55.0),
                  ),
                  maximumSize: MaterialStateProperty.all<Size>(
                    const Size(double.infinity, 55.0),
                  ),
                ),
                child: Text(
                  widget.btText.toString(),
                  style: kActionButtonStyle,
                ),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                onPressed: widget.type == 'login'
                    ? () {
                        goToSignUp();
                      }
                    : () {
                        goBack();
                      }, // on click should send you to the register page
                child:
                    Text(style: kActionLinkStyle, widget.linkText.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
