
import 'supabasemanager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'decorations.dart';
import 'Encrypter.dart';


class SettingsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  SettingsPage({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userid = arg['userid'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[300]!, Colors.green[300]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const SizedBox(height: 16.0),
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ChangeUsername',
                            arguments: {'userid': userid});
                        print(userid.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                      ),
                      icon: Icon(Icons.person),
                      label: const Text(
                        "Change Username",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/ChangePassword',
                            arguments: {'userid': userid});
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                      ),
                      icon: Icon(Icons.lock),
                      label: const Text(
                        "Change Password",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onToggleTheme,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                      ),
                      icon: Icon(Icons.lightbulb_circle_sharp),
                      label: const Text(
                        "Toggle Light/Dark mode",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 24.0,
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class ChangeUsernameSettings extends StatelessWidget {
  SupabaseManager supabase = SupabaseManager();
  //Setting class
  final formKey = GlobalKey<FormState>();
  final oldUsernameController = TextEditingController();
  final newUsernameController = TextEditingController();

  ChangeUsernameSettings({super.key});
  
  get value => null;

  @override
  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userid = arg['userid'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        decoration: pageDecoration,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                SizedBox(height: 16.0),
                Column(
                  children: [
                    TextFormField(
                      controller: oldUsernameController,
                      decoration: InputDecoration(
                        labelText: 'Old Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: newUsernameController,
                      decoration: InputDecoration(
                        labelText: 'New Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new username';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Encrypter encrypter = Encrypter();
                          String newUsername = encrypter.encryptBase64(newUsernameController.text);
                          String oldUsername = encrypter.encryptBase64(oldUsernameController.text);
                          PostgrestFilterBuilder query = supabase.UpdateUserDetails(userid, 'username', oldUsername, newUsername);
                          print(query);
                          await query;
                          showDialog(
                              context: context,
                              builder: (BuildContext builder) => AlertDialog(
                                    title: const Text("Sign Up"),
                                    content: const Text("Username changed"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: Text('Update Username'),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordSettings extends StatelessWidget {
  SupabaseManager supabase = SupabaseManager();
  //Setting class
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  ChangePasswordSettings({super.key});

  get value => null;

  @override
  @override
  Widget build(BuildContext context) {

    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    String userid = arg['userid'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        decoration: pageDecoration,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                SizedBox(height: 16.0),
                Column(
                  children: [
                    TextFormField(
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new password';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new password';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Encrypter encrypter = Encrypter();
                          String newPassword = encrypter.hashPassword(newPasswordController.text);
                          String oldPassword =  encrypter.hashPassword(oldPasswordController.text);
                          PostgrestFilterBuilder query = supabase.UpdateUserDetails(userid, 'password', oldPassword, newPassword);
                          await query;
                          showDialog(
                              context: context,
                              builder: (BuildContext builder) => AlertDialog(
                                title: const Text("Sign Up"),
                                content: const Text("Password Changed"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                        }
                      },
                      child: Text('Update Password'),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}