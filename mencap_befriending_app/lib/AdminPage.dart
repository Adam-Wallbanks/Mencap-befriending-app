import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mencap_befriending_app/supabasemanager.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({ Key? key }) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  SupabaseManager supabase = new SupabaseManager();
  List<DataRow> dataRows = [];


  @override
  void initState() {
    // ClientsToRows(supabase.GetClients()).then((value) {
    //   setState(() {
    //     dataRows = value;
    //   });
    // });
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
          // showFilterMenu(context);
        },
      ),
    );
  }

  // void showFilterMenu(BuildContext context) {
  //   List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  //   List<String> selected = [];

  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setState) {
  //           return Container(
  //             height: MediaQuery.of(context).size.height * 0.6,
  //             child: Column(
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text('Cancel'),
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () async {
  //                         final filteredData = await supabase.ClientsToRows(supabase.OnDays(selected, supabase.LikePostcode(filterController.text,supabase.GetClients())));
  //                         updateDataRows(filteredData);
  //                         Navigator.pop(context);
  //                       },
  //                       child: Text('Apply filters'),
  //                     ),
  //                   ],
  //                 ),
  //                 Expanded(
  //                   child: TextField(
  //                     controller: filterController,
  //                     decoration: InputDecoration(
  //                       labelText: 'Enter First Part of Postcode Here (e.g. NG1)',
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     itemCount: days.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       final filter = days[index];
  //                       return CheckboxListTile(
  //                         title: Text(filter),
  //                         value: selected.contains(filter),
  //                         onChanged: (value) {
  //                           setState(() {
  //                             if (value == true) {
  //                               selected.add(filter);
  //                             } else {
  //                               selected.remove(filter);
  //                             }
  //                           });
  //                         },
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }


  double getRowHeight()
  {
    double rowHeight;
    bool platform  = kIsWeb;
    if(!platform)
    {
      rowHeight = 50;
    }
    else{
      rowHeight = 35;
    }

    return rowHeight;
  }
}