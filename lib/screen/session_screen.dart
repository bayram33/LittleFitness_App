import "package:app/data/session.dart";
import "package:app/data/sp_helper.dart";
import "package:app/shared/menu_drawer.dart";
import "package:flutter/material.dart";

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  List<Session> sessions = [];
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtDuration = TextEditingController();
  SPHelper helper = SPHelper();
  @override
  void initState() {
    helper.init().then((value) {
      updateSession();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSessionDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: getContent(),
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Insert Traning Session"),
          content: SingleChildScrollView(
            child: Column(children: [
              TextField(
                controller: txtDescription,
                decoration: const InputDecoration(
                  hintText: "Description :) ",
                ),
              ),
              TextField(
                controller: txtDuration,
                decoration: const InputDecoration(
                  hintText: "Duration :)",
                ),
              ),
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                txtDescription.text = "";
                txtDuration.text = "";
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: saveSession,
              child: const Text("Save"),
            )
          ],
        );
      },
    );
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = "${now.day}-${now.month}-${now.year}";
    int id = helper.getCounter() + 1;
    Session newSession = Session(
      id: id,
      date: today,
      description: txtDescription.text,
      duration: int.tryParse(txtDuration.text),
    );
    helper.writeSession(newSession).then((value) {
      updateSession();
      helper.setCounter();
    });
    txtDescription.text = "";
    txtDuration.text = "";
    Navigator.pop(context);
  }

  void updateSession() {
    sessions = helper.getSession();
    setState(() {});
  }

  List<Widget> getContent() {
    List<Widget> tiles = [];
    for (var element in sessions) {
      tiles.add(
        Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            helper
                .deleteSession(element.id ?? 0)
                .then((value) => updateSession());
          },
          child: ListTile(
            title: Text("${element.description}"),
            subtitle: Text("${element.date}- duration ${element.duration} min"),
          ),
        ),
      );
    }
    return tiles;
  }
}
