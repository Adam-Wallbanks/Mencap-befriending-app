import 'package:flutter/material.dart';
import 'data.dart';
import 'supabasemanager.dart';
import 'package:supabase/supabase.dart';
import 'dart:async';

class AdminMenuPage extends StatefulWidget {
  @override
  _AdminMenuPageState createState() => _AdminMenuPageState();
}

class _AdminMenuPageState extends State<AdminMenuPage> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userid = arg['userid'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/Settings',
                  arguments: {'userid': userid});
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle button press for "Clients
                  Navigator.pushNamed(context, '/clientManager',
                    arguments: {'userid': userid});
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(200, 100), // Fixed dimensions
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('Clients'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/UserManagementPage',
                      arguments: {'userid': userid});
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(200, 100), // Fixed dimensions
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('User Management'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press for "Requests"
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  minimumSize: Size(200, 100), // Fixed dimensions
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('Continue As User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<bool> expandedStates = List.filled(17, false);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userid = arg['userid'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: "Add",
            onPressed: () {
              //Add new User
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: () {
              Navigator.pushNamed(context, '/Settings',
                  arguments: {'userid': userid});
            },
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List<String> items = ["Dave Jones", "Adam Sheep", "Tom Christ", "Luke Robot", "Lana", "Siena", "Beth", "Bryan", "3", "a", "b", "c", "d", "e", "f", "g", "h"];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return getCard(items[index], index);
      },
    );
  }

  Widget getCard(String item, int index) {
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
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(item),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isExpanded) ...[
                            Text(
                              "Username: XX",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Email: XX",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Password: XX",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Information: XX",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button 1 functionality
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 5),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Add button 2 functionality
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          SizedBox(width: 5),
                          Text("Delete"),
                        ],
                      ),
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

class TableView extends StatefulWidget {
  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List<Map<String, dynamic>> clientData = [
    {
      'clientId': '1',
      'days': 'Monday',
      'town': 'town',
      'postcode': '12345',
      'hours': '40',
      'age': '28',
      'notes': 'Sample notes for client 1',
    },
    {
      'clientId': '2',
      'days': 'Thursday',
      'town': 'town',
      'postcode': '67890',
      'hours': '35',
      'age': '34',
      'notes': 'Sample notes for client 2',
    },
    // Add more client data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Clients')),
        body: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Client ID')),
                  DataColumn(label: Text('Days')),
                  DataColumn(label: Text('Town')),
                  DataColumn(label: Text('Postcode')),
                  DataColumn(label: Text('Hours')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('Notes')),
                ],
                rows: clientData.map((client) {
                  return DataRow(cells: [
                    DataCell(Text(client['clientId'])),
                    DataCell(Text(client['days'])),
                    DataCell(Text(client['town'])),
                    DataCell(Text(client['postcode'])),
                    DataCell(Text(client['hours'])),
                    DataCell(Text(client['age'])),
                    DataCell(Text(client['notes'])),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
