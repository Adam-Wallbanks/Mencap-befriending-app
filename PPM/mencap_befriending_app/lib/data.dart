class Client
{
  String id = "", days = "", town = "", postcode = "", hours = "", age = "", notes = "";


  Client();

  Client.complete(this.id,this.days,this.town,this.postcode,this.hours,this.age,this.notes);
}

class User
{
  String id = "", username = "", password = "", first = "", last = "", email = "";
  bool admin = false;

  User();

  User.complete(this.id,this.username,this.password,this.first,this.last,this.email,this.admin);
}