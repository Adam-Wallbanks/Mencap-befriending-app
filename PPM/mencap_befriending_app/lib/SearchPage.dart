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
    List<String> items = ["1", "2", "3", "4", "3", "3", "3", "2", "3", "a", "b", "c", "d", "e", "f", "g", "h"];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return getCard(items[index], index, context);
      },
    );
  }

  Widget getCard(String item, int index, BuildContext context) {
    bool isExpanded = expandedStates[index];
    double deviceWidth = MediaQuery.of(context).size.width;
    double circleSize = deviceWidth > 600 ? 30.0 : 20.0;
    double fontSize = deviceWidth > 600 ? 16.0 : 14.0;
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
                      height: circleSize,
                      width: circleSize,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(circleSize / 2),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(item),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Postcode: XXXXX",
                            style: TextStyle(fontSize: fontSize),
                          ),
                          Text(
                            "Hours Available: X",
                            style: TextStyle(fontSize: fontSize),
                          ),
                          if (isExpanded) ...[
                            Text(
                              "Age: XX",
                              style: TextStyle(fontSize: fontSize),
                            ),
                            Text(
                              "Additional Information",
                              style: TextStyle(fontSize: fontSize),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        DayCircle(day: "M", circleSize: circleSize, fontSize: fontSize),
                        const SizedBox(width: 5),
                        DayCircle(day: "T", circleSize: circleSize, fontSize: fontSize),
                        const SizedBox(width: 5),
                        DayCircle(day: "W", circleSize: circleSize, fontSize: fontSize),
                        const SizedBox(width: 5),
                        DayCircle(day: "T", circleSize: circleSize, fontSize: fontSize),
                        const SizedBox(width: 5),
                        DayCircle(day: "F", circleSize: circleSize, fontSize: fontSize),
                        const SizedBox(width: 5),
                        DayCircle(day: "S", circleSize: circleSize, fontSize: fontSize),
                        const SizedBox(width: 5),
                        DayCircle(day: "S", circleSize: circleSize, fontSize: fontSize),
                      ],
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.thumb_up, color: Colors.white),
                        onPressed: () {
                          // Perform thumbs up action here
                        },
                      ),
                    ),
                  ),
                ],
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
  final double circleSize;
  final double fontSize;

  const DayCircle({
    required this.day,
    required this.circleSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
