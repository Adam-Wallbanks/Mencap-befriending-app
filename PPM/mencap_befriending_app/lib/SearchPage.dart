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
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List<String> items = ["1", "2","3","4","3","3","3","2","3","a","b","c","d","e","f","g","h"];
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return getCard(items[index]);
      },
    );
  }

  Widget getCard(String item) {
    return Card(
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
                  child: Text(
                    item
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                "Test Text",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Client>> QueryClients(PostgrestFilterBuilder query)
{
  final completer =  Completer<List<Client>>();
  final List<Client> clients = [];

  query.then((values) {
    clients.clear();
    for(dynamic value in values) {
      Client client = Client.complete(value['id'].toString(), value['days'], value['town'], value['postcode'], value['hours'], value['age'], value['notes']);
      clients.add(client);
    }
    completer.complete(clients);
  }).catchError((error) {
    completer.completeError(error);
  });

  return completer.future;
}

List<Card> ClientstoCards(List<Client> clients)
{
  List<Card> cards = [];

  for (Client client in clients)
    {
      Card card = Card(

      );
    }

  return cards;
}



