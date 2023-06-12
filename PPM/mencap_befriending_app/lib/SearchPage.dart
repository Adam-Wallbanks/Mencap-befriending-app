import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'supabasemanager.dart';
import 'package:supabase/supabase.dart';
import 'dart:async';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List<String> items = ["1", "2", "3", "4", "3", "3", "3", "2", "3", "a", "b", "c", "d", "e", "f", "g", "h"];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return getCard(items[index]);
      },
    );
  }

  Widget getCard(String item) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(item),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Postcode: XXXXX",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Hours Available: X",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    DayCircle(day: "M"),
                    const SizedBox(width: 5),
                    DayCircle(day: "T"),
                    const SizedBox(width: 5),
                    DayCircle(day: "W"),
                    const SizedBox(width: 5),
                    DayCircle(day: "T"),
                    const SizedBox(width: 5),
                    DayCircle(day: "F"),
                    const SizedBox(width: 5),
                    DayCircle(day: "S"),
                    const SizedBox(width: 5),
                    DayCircle(day: "S"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DayCircle extends StatelessWidget {
  final String day;

  const DayCircle({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}