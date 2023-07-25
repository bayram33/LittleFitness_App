import "package:app/data/http_helper.dart";
import "package:app/data/weather.dart";
import "package:flutter/material.dart";

import "../shared/menu_drawer.dart";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController txtPlace = TextEditingController();
  Weather result = Weather("", "", 0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MenuDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: txtPlace,
                decoration: InputDecoration(
                  hintText: "Enter a City",
                  suffixIcon: IconButton(
                    onPressed: getData,
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            weatherRow(
              context,
              name: "Place : ",
              value: result.name,
            ),
            weatherRow(
              context,
              name: "Description : ",
              value: result.description,
            ),
            weatherRow(
              context,
              name: "temperature : ",
              value: result.temperature?.toStringAsFixed(2),
            ),
            weatherRow(
              context,
              name: "feelslike : ",
              value: result.feelslike?.toStringAsFixed(2),
            ),
            weatherRow(
              context,
              name: "pressure : ",
              value: result.pressure?.toStringAsFixed(2),
            ),
            weatherRow(
              context,
              name: "humidity : ",
              value: result.humidity?.toStringAsFixed(2),
            ),
          ],
        ),
      ),
    );
  }

  Padding weatherRow(BuildContext context, {String? name, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name ?? "Empty",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value ?? "Empty",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(txtPlace.text);
    setState(() {});
  }
}
