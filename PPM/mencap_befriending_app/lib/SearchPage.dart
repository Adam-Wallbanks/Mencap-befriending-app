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
  SupabaseManager supabase = SupabaseManager();
  List<bool> expandedStates = List.filled(17, false);
  late Future<List<Client>> clientsFuture;

  @override
  void initState() {
    super.initState();
    clientsFuture = getClients(supabase.GetClientsQuery());
  }

  Future<List<Client>> getClients(PostgrestFilterBuilder query) {
    final completer = Completer<List<Client>>();
    final List<Client> clients = [];

    query.then((values) {
      clients.clear();
      for (dynamic value in values) {
        Client addClient = Client.complete(
            value['id'].toString(),
            value['days'],
            value['town'],
            value['postcode'],
            value['hours'],
            value['age'],
            value['notes']);
        clients.add(addClient);
      }
      print(clients.toString());
      completer.complete(clients);
    }).catchError((error) {
      completer.completeError(error);
    });

    return completer.future;
  }

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
      body: FutureBuilder<List<Client>>(
        future: clientsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final clients = snapshot.data!;
            return GetClientBody(clients);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => FilterOptionsBottomSheet(),
          );
        },
        child: Icon(Icons.filter_list),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget GetClientBody(List<Client> clients) {
    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        return clientCard(clients[index], index);
      },
    );
  }

  Card clientCard(Client client, int index) {
    bool isExpanded = expandedStates[index];
    double deviceWidth = MediaQuery.of(context).size.width;
    double circleSize = deviceWidth > 600 ? 35.0 : 30.0;
    double fontSize = deviceWidth > 600 ? 18.0 : 14.0;
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
            borderRadius: BorderRadius.circular(15),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(client.id),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Postcode: " + client.postcode,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Hours Available: " + client.hours,
                            style: TextStyle(fontSize: 16),
                          ),
                          if (isExpanded) ...[
                            Text(
                              "Age: " + client.age,
                              style: TextStyle(fontSize: 16),
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
                      children: getDays(client.days, circleSize, fontSize),
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

  List<DayCircle> getDays(String daystring, double circleSize, double fontSize) {
    List<DayCircle> days = [];
    const String comparedays = "MTWTFSS";

    for (int i = 0; i < 7; i++) {
      Color fontColor = Color.fromARGB(100, 0, 0, 0);
      Color dayColor = Color.fromARGB(175, 200, 200, 200);
      if (daystring[i] == comparedays[i]) {
        dayColor = Colors.white;
        fontColor = Colors.black;
      }
      DayCircle dayCircle = DayCircle(
        day: comparedays[i],
        circleColor: dayColor,
        circleSize: circleSize,
        fontSize: fontSize,
        fontColor: fontColor,
      );
      days.add(dayCircle);
    }
    return days;
  }
}

class DayCircle extends StatelessWidget {
  final String day;
  final double circleSize;
  final Color circleColor;
  final double fontSize;
  final Color fontColor;

  const DayCircle({
    required this.day,
    required this.circleSize,
    required this.fontSize,
    required this.circleColor,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}

class FilterOptionsBottomSheet extends StatefulWidget {
  @override
  _FilterOptionsBottomSheetState createState() =>
      _FilterOptionsBottomSheetState();
}

class _FilterOptionsBottomSheetState extends State<FilterOptionsBottomSheet> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text('Search:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter search query',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Apply filters and update the client list
                // based on the searchQuery and other filter options
                Navigator.pop(context);
              },
              child: Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
