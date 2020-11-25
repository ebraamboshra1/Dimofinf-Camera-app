import 'package:dimofinf_camera_app/utils/page_route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../exetensions/exetnsion.dart';
import '../utils/utils.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success, loading = false;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Color(0xff7267f3),
        elevation: 0,
      ),
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff7267f3),
            Color(0xff3e96d3),
            Color(0xff00cead),
          ],
        )),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (!Validator.isEmail(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ).addStyleOnly(mediaQuery),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(2)),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                obscureText: true,
              ).addStyleOnly(mediaQuery),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'Register',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ).addSocialStyleOnly(mediaQuery, _register),
              Container(
                alignment: Alignment.center,
                child: Text(_success == null
                    ? ''
                    : (_success
                        ? 'Successfully registered ' + _userEmail
                        : 'Registration failed')),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        loading = false;
        _success = true;
        Navigator.of(context).pushNamed(PageRouteName.CAMERA);
        _userEmail = user.email;
      });
    } else {
      setState(() {
        loading = false;
      });
      _success = false;
    }
  }
}
