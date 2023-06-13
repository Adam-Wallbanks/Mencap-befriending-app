import 'supabasemanager.dart';
import 'package:flutter/material.dart';
import 'Encrypter.dart';
import 'decorations.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SupabaseManager supabase = SupabaseManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        flexibleSpace: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/nottingham_mencap_logo.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
      body: Container(
        decoration: pageDecoration,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Perform login functionality here
                  String username = userController.text;
                  String password = passwordController.text;
                  Encrypter encrypter = new Encrypter();

                  username = encrypter.encryptBase64(username);
                  password = encrypter.hashPassword(password);

                  bool valid = await supabase.ValidateUser(username, password);

                  String dialogMessage = "";

                  if (valid) //If there is a valid account match
                      {
                    dialogMessage = "Login Valid";
                    valid = true;
                  } else {
                    dialogMessage = "Login Invalid";
                  }
                  showDialog(
                      context: context,
                      builder: (BuildContext builder) => AlertDialog(
                        title: const Text("Log In"),
                        content: Text(dialogMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK', style:TextStyle(color: Colors.black)),
                          ),
                        ],
                      )).then((value) async {
                    if (valid) {
                      List<String> userdetails = await supabase.SelectUser(username, password);
                      String userid = userdetails[0];
                      print(userid);
                      Navigator.pushNamed(context, "/SearchPage", arguments: {
                        'userid' : userid,
                      });
                    }
                  });
                },
                child: const Text('Log In'),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont Have an Account? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  SupabaseManager supabase = SupabaseManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        decoration: pageDecoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a Username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      String firstname = firstNameController.text,
                          lastname = lastNameController.text,
                          email = emailController.text,
                          username = userNameController.text,
                          password = passwordController.text;


                      Encrypter encrypter = new Encrypter();

                      username = encrypter.encryptBase64(username);
                      password = encrypter.hashPassword(password);
                      email = encrypter.encryptBase64(email);
                      firstname = encrypter.encryptBase64(firstname);
                      lastname = encrypter.encryptBase64(lastname);


                      await showDialog(
                          context: context,
                          builder: (BuildContext builder) => AlertDialog(
                            title: const Text("Sign Up"),
                            content: const Text("Account Created"),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'OK'),
                                child: const Text('OK', style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ));
                      //Return to log in page
                      Navigator.of(context).pop();

                      //Input details into supabase
                      await supabase.InsertUser(
                          firstname,
                          lastname,
                          email,
                          username,
                          password
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}