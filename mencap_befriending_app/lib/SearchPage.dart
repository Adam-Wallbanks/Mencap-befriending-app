import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mencap_befriending_app/supabasemanager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({ Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SupabaseManager supabase = new SupabaseManager();
  List<DataRow> dataRows = [];
  String userid = '',username = '', password = '';

  final TextEditingController filterController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    ClientsToRows(supabase.GetClients()).then((value) {
      setState(() {
        dataRows = value;
        final arg = ModalRoute.of(context)!.settings.arguments as Map;
        userid = arg['userid'];
      });
    });
  }

  void updateDataRows(List<DataRow> newDataRows) {
    setState(() {
      dataRows = newDataRows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients"),
        actions: <Widget> [
          IconButton(onPressed: ()
          {
            Navigator.pushNamed(context, '/Settings', arguments: {
              'userid' : userid
            });
          }, 
          icon: const Icon(Icons.settings))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: FittedBox(
          child: DataTable(
            columns: const [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("PostCode")),
              DataColumn(label: Text("Days Free")),
              DataColumn(label: Text("Likes/Dislikes")),
              DataColumn(label: Text(""))
            ],
            rows: dataRows,
            dataRowHeight: getRowHeight(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFilterMenu(context);
        },
        child: const Icon(Icons.filter_list, color: Colors.black,),
      ),
    );
  }

  void showFilterMenu(BuildContext context) {
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<String> selected = [];

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter filtersetState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final filteredData = await ClientsToRows(supabase.OnDays(selected, supabase.LikePostcode(filterController.text,supabase.GetClients())));
                        updateDataRows(filteredData);
                        Navigator.pop(context);
                      },
                      child: const Text('Apply filters'),
                    ),
                  ],
                ),
                TextField(
                  controller: filterController,
                  decoration: const InputDecoration(
                    labelText: 'Enter First Part of Postcode Here (e.g. NG1)',
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: days.length,
                    itemBuilder: (BuildContext context, int index) {
                      final filter = days[index];
                      return CheckboxListTile(
                        title: Text(filter),
                        value: selected.contains(filter),
                        onChanged: (value) {
                          filtersetState(() {
                            if (value == true) {
                              selected.add(filter);
                            } else {
                              selected.remove(filter);
                            }
                            print(selected.toString());
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  Future<List<DataRow>> ClientsToRows(PostgrestFilterBuilder query) {
    final completer = Completer<List<DataRow>>();
    final dataRows = [const DataRow(cells: [DataCell(Text("Start")), DataCell(Text("Start")), DataCell(Text("Start")), DataCell(Text("Start")),DataCell(Text("Start"))])];
    
    query.then((values) {
      dataRows.clear();
      for(dynamic value in values)
      {
        DataRow addRow = DataRow(cells: [
          DataCell(Text(value['id'].toString())),
          DataCell(Text(value['postcode'])),
          DataCell(Text(value['daysfree'])),
          DataCell(Text(value['dis/like'])),
          DataCell(Tooltip(
            child : IconButton(icon: const Icon(Icons.thumb_up), onPressed: () { openRequest(value['id'].toString()); }),
            message: "Request a Client",
            ))
        ]);
        dataRows.add(addRow);
      }
      print(dataRows.toString());
      completer.complete(dataRows);
    }).catchError((error) {
      completer.completeError(error);
    });
    
    return completer.future;
  }

  void openRequest(String clientid)
  {
    showDialog(context: context, builder: (BuildContext dialogContext) {
      return AlertDialog(
                    content: Stack(
                      children: <Widget>[
                        Form(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Request Client: ' + clientid),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: notesController,
                                 decoration: const InputDecoration(
                                labelText: 'Notes For Recipient',
                                ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton(
                                  child: const Text("Submit"),
                                  onPressed: () async {
                                    Navigator.pop(dialogContext);
                                    var query = supabase.InsertRequest(userid, clientid, notesController.text);
                                    await query;
                                  
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

    });
  }

  double getRowHeight() {
    if (kIsWeb) {
      // Set row height for web
      return 35.0;
    } else {
      // Set row height for mobile
      return 100.0;
    }
  }

}