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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
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
                      // Handle button press for "User Management"
                    },
                    child: Text('User Management'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 140,
                  child: FloatingActionButton(
                    heroTag: 'likesDislikes',
                    onPressed: () {
                      // Handle button press for "Likes/Dislikes"
                    },
                    child: Text('Likes/Dislikes'),
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
