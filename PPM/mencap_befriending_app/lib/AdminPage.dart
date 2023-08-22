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
              Expanded(
                child: Container(
                  width: 140,
                  child: FloatingActionButton(
                    heroTag: 'clients',
                    onPressed: () {
                      // Handle button press for "Clients"
                    },
                    child: Text('Clients'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 140,
                  child: FloatingActionButton(
                    heroTag: 'userManagement',
                    onPressed: () {
                      Navigator.pushNamed(context, '/UserManagementPage',
                          arguments: {'userid': userid});
                    },
                    child: Text('User Management'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 140,
                  child: FloatingActionButton(
                    heroTag: 'searchPage',
                    onPressed: () {
                      // Handle button press for "Requests"
                    },
                    child: Text('Continue As User'),
                  ),
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
                          //Text(
                          //  "Dave Jones",
                          // style: TextStyle(fontSize: 16),
                          //),
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
                        // Add button 1 functionality
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
