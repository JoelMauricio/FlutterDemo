import 'package:flutter/material.dart';
import 'package:reminders_app/constants.dart';

Widget taskPlaceholder(BuildContext context, Size size, IconData icon,
    String message, bool centered) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: centered == true
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height / 4,
            width: size.width / 2,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.tertiary,
              size: size.height / 6,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Text(
            message,
            style: TextStyle(fontSize: size.height * 0.025),
          )
        ],
      ),
    ),
  );
}
