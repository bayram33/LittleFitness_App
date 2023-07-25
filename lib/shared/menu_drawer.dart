import "package:app/screen/bmi_screen.dart";
import "package:app/screen/homapage.dart";
import "package:app/screen/session_screen.dart";
import "package:app/screen/weather_screen.dart";
import "package:flutter/material.dart";

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      "Home",
      "BMI Calculator",
      "Weather",
      "Traning",
    ];
    List<Widget> menuItems = [];
    menuItems.add(
      const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Text(
          "Fitness For You",
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(
        ListTile(
          title: Text(
            element,
            style: const TextStyle(fontSize: 18),
          ),
          onTap: () {
            switch (element) {
              case "Home":
                screen = const HomePage();
                break;
              case "BMI Calculator":
                screen = const BmiCalculater();
                break;
              case "Weather":
                screen = const WeatherScreen();
                break;
              case "Traning":
                screen = const SessionScreen();
                break;
            }
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => screen,
              ),
            );
          },
        ),
      );
    }
    return menuItems;
  }
}
