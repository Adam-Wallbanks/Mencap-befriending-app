import 'dart:async';
import 'package:supabase/supabase.dart';

const supabaseURL = 'https://bbchavdidouzbotpgxzi.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJiY2hhdmRpZG91emJvdHBneHppIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzc3MDcyNDYsImV4cCI6MTk5MzI4MzI0Nn0.ilEmtJmQX1oOwQj7sYQUbT8jSf-sGzs5lrx4hgTUm-w';

class SupabaseManager {
  final client = SupabaseClient(supabaseURL, supabaseKey);


  InsertQuery(String table, List<String> fields, List<dynamic> values) {
    //Build values
    Map<String, dynamic> valueMap = {};
    for (String field in fields) {
      valueMap[field] = values[fields.indexOf(field)];
    }
    return client.from(table).insert(valueMap);
  }

  SelectQuery(String table, List<String> fields) {
    String field = fields.join(",");
    var query = client.from(table).select(field);
    return query;
  }

  Future<List<String>> SelectUser(String username, String password)
  async {
    List<String> list = ["","",""];
    var query = client.from('Users').select('userid,username,password').eq('username', username).eq('password', password);
    var results = await query;
    print(results.toString());
    if(results.toString() != "[]")
      {
        list.clear();
        list.add(results[0]['userid'].toString());
        list.add(results[0]['username']);
        list.add(results[0]['password']);
      }
      print(list.toString());
    return list;
  }

  UpdateQuery(String table, String field, String oldvalue, String newvalue) {
    var update = {field : newvalue};
    var match = {field : oldvalue};
    return client.from(table).update(update).match(match);
  }

  UpdateUserDetails(String userid, String field, String oldvalue, String newvalue) {
    int usernum = int.parse(userid);
    print(usernum.toString());
    return client.from("Users").update({field : newvalue}).match({field : oldvalue, 'userid' : usernum});
  }

  MultiUpdateQuery(String table, List<String> fields, List<String> oldvalues, List<String> newvalues) async {
    //Store all Queries
    var queries = [];

    //If params are not all same size
    if(fields.length != oldvalues.length || fields.length != newvalues.length)
    {
      print("Not all same size!");
    }
    else
    {
      //For every index of queries
      for(int i = 0; i < fields.length ; i ++)
      {
        //Construct query
        var update = {fields[i] : newvalues[i]};
        var match = {fields[i] : oldvalues[i]};
        //Add to queries
        queries.add(client.from(table).update(update).match(match));
      }
    }
    //Return Queries
    return queries;
  }

  InsertUser(String first, String last, String email, String username, String password) async {
    dynamic values;
    values =
    {
      'first_name' : first,
      'last_name' : last,
      'email' : email,
      'username': username,
      'password': password
    };
     PostgrestFilterBuilder query = client.from("Users").insert(values);
     return query;
  }

  InsertRequest(String userid, String clientid ,String note)
  {
    PostgrestFilterBuilder query = client.from("Requests").insert({'userid' : userid, 'clientid' : clientid , 'notes' : note});
    return query;
  }

  Future<bool> ValidateUser(String username ,String password)
  async {
    bool returnBool = false;
    try
    {
      PostgrestFilterBuilder query = client.from("Users").select("username,password");
      query = query.eq('username', username).eq('password', password);
      dynamic results = await query;
      if(results.toString() != "[]")
      {
        returnBool = true;
      }
    }
    catch(e)
    {
      print(e.toString());
    }
    return returnBool;
  }

  GetClients()
  {
    try{
      PostgrestFilterBuilder query = client.from("Clients").select('*');
      return query;
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  LikePostcode(String prefix, PostgrestFilterBuilder query)
  {
    prefix = prefix.toUpperCase();
    query = query.like("postcode", prefix +"%");
    return query;
  }

  OnDays(List<String> days, PostgrestFilterBuilder query)
  {
    String filter = '';
    for(String day in days)
    {
      filter += 'daysfree.like.' + "%" + day + "%" + ",";
    }
    if(days.length != 0){
      filter = filter.substring(0,filter.length-1);
      print(filter);
      query = query.or(filter);
    }
    print(query.toString());
    return query;
  }

}