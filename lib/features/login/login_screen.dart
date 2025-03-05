import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavatory_admin/features/homescreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'loginbloc/login_bloc_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  final LoginBlocBloc _loginBloc = LoginBlocBloc();

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBlocBloc>.value(
        value: _loginBloc,
        child: BlocConsumer<LoginBlocBloc, LoginBlocState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            } else if (state is LoginFailureState) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Failed'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return Row(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    ],
                  ),
                ),

                // Right side - Login form
                Expanded(
                  flex: 1,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            SizedBox(height: 48),
                            SizedBox(
                              width: 500,
                              child: TextFormField(
                                controller: _emailController,
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
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: _isObscure,
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
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _loginBloc.add(
                                      LoginEvent(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: state is LoginLoadingState
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text('Login'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
