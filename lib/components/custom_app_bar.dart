import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders_app/constants.dart';

import 'notifier.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = '',
    this.titleColor = kLightText,
    this.titleWidget,
    this.isAuth,
    this.isReturnable = false,
  }) : super(key: key);

  final bool? isReturnable;
  final bool? isAuth;
  final Color? titleColor;
  final String title;
  final Widget? titleWidget;

  @override
  CustomAppBarState createState() => CustomAppBarState();

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80.0,
      );
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    void handleThemeChange() {
      if (Provider.of<AppStateNotifier>(context, listen: false).isDarkMode ==
          false) {
        Provider.of<AppStateNotifier>(context, listen: false).updateTheme(true);
      } else {
        Provider.of<AppStateNotifier>(context, listen: false)
            .updateTheme(false);
      }
    }

    IconData getTheme() {
      if (!Provider.of<AppStateNotifier>(context).isDarkMode) {
        return Icons.dark_mode_sharp;
      } else {
        return Icons.light_mode_sharp;
      }
    }

    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Stack(
            children: [
              Positioned.fill(
                child: widget.titleWidget == null
                    ? Center(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: widget.isAuth == false
                                ? widget.isReturnable == false
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : kLightBackground
                                : widget.titleColor,
                          ),
                        ),
                      )
                    : Center(
                        child: widget.titleWidget,
                      ),
              ),
              Row(
                mainAxisAlignment: widget.isAuth == false
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.isAuth == false
                    ? <Widget>[
                        IconButton(
                          onPressed: () {
                            widget.isReturnable == false
                                ? Scaffold.of(context).openDrawer()
                                : Navigator.of(context)
                                    .pushReplacementNamed('/');
                          },
                          iconSize: 32,
                          alignment: Alignment.center,
                          splashRadius: 15,
                          splashColor: Theme.of(context).colorScheme.tertiary,
                          icon: Icon(
                            widget.isReturnable == false
                                ? Icons.menu
                                : Icons.arrow_back_outlined,
                            color: widget.isReturnable == false
                                ? Theme.of(context).colorScheme.onPrimary
                                : kLightBackground,
                          ),
                        ),
                        IconButton(
                          onPressed: () => handleThemeChange(),
                          alignment: Alignment.center,
                          iconSize: 32,
                          splashRadius: 15,
                          splashColor: kSecondaryColor,
                          icon: Icon(
                            getTheme(),
                            color: widget.isReturnable == false
                                ? Theme.of(context).colorScheme.onPrimary
                                : kLightBackground,
                          ),
                        )
                      ]
                    : <Widget>[
                        IconButton(
                          onPressed: () => handleThemeChange(),
                          alignment: Alignment.center,
                          iconSize: 32,
                          splashRadius: 15,
                          splashColor: kSecondaryColor,
                          icon: Icon(
                            getTheme(),
                            color: kLightBackground,
                          ),
                        )
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
