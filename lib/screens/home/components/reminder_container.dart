import 'package:flutter/material.dart';
import 'package:reminders_app/constants.dart';

Widget reminderContainer(Size size, tarea, BuildContext context) {
  return Container(
      height: size.height * 0.10,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: kAccentColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
            spreadRadius: .3,
            blurRadius: 2,
            blurStyle: BlurStyle.outer,
          ),
        ],
        color:
            Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  tarea['task'].toString()[0].toUpperCase() +
                      tarea['task'].toString().substring(1),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding / 10),
                  child: Text(
                    tarea['inserted_at'].toString().split('T')[0],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: size.height * 0.015,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  tarea['inserted_at'].toString().split('T')[1].substring(0, 5),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: size.height * 0.035,
                    // fontFamily:
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 5),
                  child: Icon(
                    Icons.watch_later_outlined,
                    size: size.height * 0.045,
                  ),
                ),
              ],
            )
          ],
        ),
      ));
}
