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
  List<bool> expandedStates = List.filled(17, false);

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
    List<String> items = [
      "1"
    ];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return getCard(items[index], index);
      },
    );
  }

  Widget getCard(String id, int index) {
    bool isExpanded = expandedStates[index];
    return Card(
      child: GestureDetector(
        onTap: () {
          setState(() {
            expandedStates[index] = !isExpanded;
          });
        },
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                        child: Text(id),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
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
                          if (isExpanded) ...[
                            Text(
                              "Age: XX",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Additional Information",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ],
                      ),
                    ),
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
                if (isExpanded) ...[
                  SizedBox(height: 10),
                  // Add additional expanded content here
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Card> GetClientBody(List<Client> clients) {
  List<Card> cards = [];

  return cards;
}

Card clientCard(Client client) {
  return Card();
}

class DayCircle extends StatelessWidget {
  final String day;
  final Color color;
  const DayCircle({required this.day, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: (color.computeLuminance() > 0.179)
                  ? Colors.black
                  : Colors.white),
        ),
      ),
    );
  }
}
