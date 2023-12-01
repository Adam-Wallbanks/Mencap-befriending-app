import 'package:flutter/material.dart';
import 'data.dart';
import 'supabasemanager.dart';
import 'package:supabase/supabase.dart';
import 'dart:async';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

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
            icon: const Icon(Icons.settings),
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final clients = snapshot.data!;
            return GetClientBody(clients);
          }
        },
      ),
<<<<<<< Updated upstream
=======
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => FilterOptionsBottomSheet(
              applyFilters: applyFilters,
            ),
          );
        },
        child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.green],
                )),
            child: const Icon(Icons.filter_list)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
>>>>>>> Stashed changes
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
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(side: ,borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
        onTap: () {
          setState(() {
            expandedStates[index] = !isExpanded;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
<<<<<<< Updated upstream
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
=======
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Postcode: ${client.postcode}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Hours: ${client.hours}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: getDays(client.days, circleSize, fontSize),
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Age: ${client.age}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Additional Information: ${client.notes}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.thumb_up, color: Colors.white),
                              onPressed: () {
                                // Perform thumbs up action here
                              },
                            ),
>>>>>>> Stashed changes
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
      Color fontColor = const Color.fromARGB(100, 0, 0, 0);
      Color dayColor = const Color.fromARGB(175, 200, 200, 200);
      if (daystring[i] == comparedays[i]) {
        dayColor = Colors.white;
        fontColor = Colors.black;
      }
      DayCircle dayCircle = DayCircle(day: comparedays[i], circleColor: dayColor, circleSize: circleSize , fontSize: fontSize, fontColor: fontColor);
      days.add(dayCircle);
    }
    return days;
  }
<<<<<<< Updated upstream
=======

  void applyFilters(
      String postCode, List<bool> selectedDays, String ageRange) {
    // Apply the filters and update the client list based on the filter options
    // You can use the searchQuery, selectedDays, and ageRange variables to filter the data
    // For simplicity, I'll print the values here

    print('Search Query: $postCode');
    print('Selected Days: $selectedDays');
    print('Age Range: $ageRange');
  }
>>>>>>> Stashed changes
}

class DayCircle extends StatelessWidget {
  final String day;
  final double circleSize;
  final Color circleColor;
  final double fontSize;
  final Color fontColor;

<<<<<<< Updated upstream

  const DayCircle({
=======
  const DayCircle({super.key,
>>>>>>> Stashed changes
    required this.day,
    required this.circleSize,
    required this.fontSize,
    required this.circleColor,
    required this.fontColor

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
            color: fontColor
          ),
        ),
      ),
    );
  }
}
<<<<<<< Updated upstream
=======

class FilterOptionsBottomSheet extends StatefulWidget {
  final Function(String, List<bool>, String) applyFilters;

  const FilterOptionsBottomSheet({super.key, required this.applyFilters});

  @override
  _FilterOptionsBottomSheetState createState() =>
      _FilterOptionsBottomSheetState();
}

class _FilterOptionsBottomSheetState extends State<FilterOptionsBottomSheet> {
  String id = '';
  String postCode = '';
  List<bool> selectedDays = List.filled(7, false);
  String ageRange = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Search by id:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  id = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter id',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Search by postcode:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  postCode = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter Postcode',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Days Available:'),
            Wrap(
              children: [
                Checkbox(
                  value: selectedDays[0],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[0] = value ?? false;
                    });
                  },
                ),
                const Text('Mon'),
                Checkbox(
                  value: selectedDays[1],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[1] = value ?? false;
                    });
                  },
                ),
                const Text('Tue'),
                Checkbox(
                  value: selectedDays[2],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[2] = value ?? false;
                    });
                  },
                ),
                const Text('Wed'),
                Checkbox(
                  value: selectedDays[3],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[3] = value ?? false;
                    });
                  },
                ),
                const Text('Thu'),
                Checkbox(
                  value: selectedDays[4],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[4] = value ?? false;
                    });
                  },
                ),
                const Text('Fri'),
                Checkbox(
                  value: selectedDays[5],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[5] = value ?? false;
                    });
                  },
                ),
                const Text('Sat'),
                Checkbox(
                  value: selectedDays[6],
                  onChanged: (value) {
                    setState(() {
                      selectedDays[6] = value ?? false;
                    });
                  },
                ),
                const Text('Sun'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text('Age Range:'),
            DropdownButton<String>(
              value: ageRange, // Add a default value here
              onChanged: (value) {
                setState(() {
                  ageRange = value ?? '';
                });
              },
              items: const [
                DropdownMenuItem(
                  value: '', // Add a default value here
                  child: Text('Select Age Range'),
                ),
                DropdownMenuItem(
                  value: '0-18',
                  child: Text('0-18'),
                ),
                DropdownMenuItem(
                  value: '19-30',
                  child: Text('19-30'),
                ),
                DropdownMenuItem(
                  value: '31-50',
                  child: Text('31-50'),
                ),
                DropdownMenuItem(
                  value: '51+',
                  child: Text('51+'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Container(
              width: 140,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent),
                onPressed: () {
                  // Pass the selected filter options back to the parent widget
                  widget.applyFilters(postCode, selectedDays, ageRange);

                  Navigator.pop(context);
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes
