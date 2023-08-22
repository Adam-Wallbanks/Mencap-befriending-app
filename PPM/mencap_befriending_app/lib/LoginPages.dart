import 'supabasemanager.dart';
import 'package:flutter/material.dart';
import 'Encrypter.dart';
import 'decorations.dart';
import 'dimensions.dart';
import 'data.dart' as data;

class MobileLoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SupabaseManager supabase = SupabaseManager();

  double maxWidth;
  double maxHeight;


  MobileLoginPage({required this.maxWidth, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/nottingham_mencap_logo.png',
              width: 100,
              height: 100,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: pageDecoration,
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(175, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 75, 50, 75),
                  child: Column(
                    children: [
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

                          bool valid =
                              await supabase.ValidateUser(username, password);

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
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                    ],
                                  )).then((value) async {
                            if (valid) {
                              data.User userdetails =
                                  await supabase.SelectUser(username, password);
                              String userid = userdetails.id;
                              bool isadmin = userdetails.admin;
                              print(userid);
                              print("Isadmin?");
                              print(isadmin.toString());
                              if (!isadmin) {
                                Navigator.pushNamed(context, "/SearchPage",
                                    arguments: {
                                      'userid': userid,
                                    });
                              }
                              else{
                                Navigator.pushNamed(context, "/AdminMenu",
                                    arguments: {
                                      'userid': userid,
                                    });
                              }
                            }
                          });
                        },
                        child: const Text('Log In'),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(175, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15)),
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

class DesktopLoginPage extends StatelessWidget {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SupabaseManager supabase = SupabaseManager();

  double maxWidth;
  double maxHeight;

  DesktopLoginPage({required this.maxWidth, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        flexibleSpace: Align(
          alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/nottingham_mencap_logo.png',
              width: 200,
              height: 200,
              alignment: Alignment.bottomCenter,
            ),
          ),
      ),
      body: Container(
        decoration: pageDecoration,
          child: Row(
            children: [
              Spacer(flex: LoginWidthFlex(maxWidth)[1]),
              Flexible(
                flex: LoginWidthFlex(maxWidth)[0],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer( flex: 3,),
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(175, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Spacer(flex: 1,),
                            Flexible(
                              flex: 5,
                              child: Column(
                                children: [
                                  const Spacer(flex: 1),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      children: [
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

                                            bool valid =
                                            await supabase.ValidateUser(username, password);

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
                                                      onPressed: () =>
                                                          Navigator.pop(context, 'OK'),
                                                      child: const Text('OK',
                                                          style:
                                                          TextStyle(color: Colors.black)),
                                                    ),
                                                  ],
                                                )).then((value) async {
                                              if (valid) {
                                                data.User userdetails =
                                                await supabase.SelectUser(username, password);
                                                String userid = userdetails.id;
                                                bool isadmin = userdetails.admin;
                                                print(userid);
                                                print("Isadmin?");
                                                print(isadmin);
                                                Navigator.pushNamed(context, "/SearchPage",
                                                    arguments: {
                                                      'userid': userid,
                                                    });
                                              }
                                            });
                                          },
                                          child: const Text('Log In'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(flex: 1),
                                ],
                              ),
                            ),
                            Spacer(flex: 1,)
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 1,),
                    Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(175, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15)),
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
                    const Spacer(flex: 3,)
                  ],
                ),
              ),
              Spacer(flex: LoginWidthFlex(maxWidth)[1],)
            ],
          ),
        ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < MobileWidth || constraints.maxHeight < MobileHeight)  {
        return MobileLoginPage(maxWidth: constraints.maxWidth, maxHeight: constraints.maxHeight,);
      } else {
        return DesktopLoginPage(maxWidth: constraints.maxWidth, maxHeight: constraints.maxHeight,);
      }
    });
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
                                    child: const Text('OK',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              ));
                      //Return to log in page
                      Navigator.of(context).pop();

                      //Input details into supabase
                      await supabase.InsertUser(
                          firstname, lastname, email, username, password);
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
