import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients"),
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
              Text(
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
