import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Image.asset(
            'assets/laundry_pic1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Image.asset('assets/lavatory_logo.png', height: 200, width: 400),
              Column(
                children: [
                  Center(
                      child: Text('Log In',
                          style: const TextStyle(fontSize: 40.0),
                          textAlign: TextAlign.center)),
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      child: TextFormField(
                        obscureText: isObscure,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                isObscure = !isObscure;
                                setState(() {});
                              },
                              icon: Icon(isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        minimumSize: const Size(250.0, 50.0),
                        backgroundColor: Color.fromARGB(255, 9, 214, 241)),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(),
                      child: Text('forgot password')),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
