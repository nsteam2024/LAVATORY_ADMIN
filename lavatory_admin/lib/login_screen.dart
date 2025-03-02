import 'package:flutter/material.dart';
import 'package:lavatory_admin/homescreen.dart';

class LaundryAppUI extends StatelessWidget {
  const LaundryAppUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left side - Laundry image and text overlay
          Expanded(
            flex: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Laundry image
                Image.network(
                  'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                  fit: BoxFit.cover,
                ),
                // Dark overlay for better text visibility
                Container(color: Colors.black.withOpacity(0.4)),
                // Text overlay
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Find Your Perfect',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Laundry Spot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'The smart way to find laundry services in busy urban areas',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
                // BETA tag
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'BETA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // DEMO tag
              ],
            ),
          ),

          // Right side - Login form
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Lavatory',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Welcome back',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(height: 48),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: 500,
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  HomeScreen(),
              ),
            );},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 24),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      radius: 24,
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
