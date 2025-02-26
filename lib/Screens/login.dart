
import 'package:bmi_app/Splash_Onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthPage(),
  ));
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _email;

  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submitLogin() {
    if (_loginFormKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  void _submitSignUp() {
    if (_signupFormKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Image.network(
                   'https://media.istockphoto.com/id/1281150061/vector/register-account-submit-access-login-password-username-internet-online-website-concept.jpg?s=612x612&w=0&k=20&c=9HWSuA9IaU4o-CK6fALBS5eaO1ubnsM08EOYwgbwGBo=',
               height: 150,),
                SizedBox(height: 20),
                Text(
                  _isLogin ? 'Welcome \nLogin to your account' : 'Sign Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontFamily: 'RubikBold', color: Colors.black),
                ),
                SizedBox(height: 20),
                _isLogin ? _buildLoginForm() : _buildSignUpForm(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: _toggleForm,
                  child: Text(
                    _isLogin ? 'Create an account' : 'Already have an account? Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Username',
              icon: Icon(Icons.person)),
              
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              onSaved: (value) {
                _username = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password',
              icon: Icon(Icons.lock)),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.blueColor),
                minimumSize: WidgetStatePropertyAll(
                  Size(300, 55),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),

              onPressed: _submitLogin,
              child: Text('Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(26.0),
                  fontFamily: 'RubikBold',
                ),
              ),),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        key: _signupFormKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Username',
              icon:Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              onSaved: (value) {
                _username = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email',
              icon:Icon(Icons.email)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password',
              icon:Icon(Icons.lock)),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.blueColor),
                  minimumSize: WidgetStatePropertyAll(
                    Size(300, 55),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              onPressed: _submitSignUp,
              child: Text('Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(20.0),
                  fontFamily: 'RubikBold',
                ),),

            ),
          ],
        ),
      ),
    );
  }
}
