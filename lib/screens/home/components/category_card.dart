import 'package:flutter/material.dart';
import 'package:reminders_app/constants.dart';

Widget categoryCard(BuildContext context, Size size, Color bgColor,
    String title, IconData icon, Color textColor, int total, int progress) {
  return InkWell(
    hoverColor: kAccentColor,
    splashColor: Theme.of(context).colorScheme.secondary,
    onTap: () {
      Navigator.of(context).pushReplacementNamed('/completed');
    },
    borderRadius: const BorderRadius.all(
      Radius.circular(kDefaultPadding / 4),
    ),
    child: Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      height: size.height * 0.3 * 0.5,
      width: size.width - (2 * kDefaultPadding),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.9),
        borderRadius: const BorderRadius.all(
          Radius.circular(kDefaultPadding / 4),
        ),
        boxShadow: [
          BoxShadow(
            color: kLightText.withOpacity(0.2),
            spreadRadius: .3,
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Flex(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            direction: Axis.vertical,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: size.height * 0.0225,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$progress/$total',
                style: TextStyle(
                  color: textColor,
                  fontSize: size.height * 0.0455,
                ),
              ),
            ],
          ),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: size.height * 0.09,
                color: kSecondaryColor,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
