import 'package:dimofinf_camera_app/utils/page_route_name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../exetensions/exetnsion.dart';
import '../utils/utils.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  final String title = 'Sign In';

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;

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
        child: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              _EmailPasswordForm(mediaQuery),
              Center(
                child: GestureDetector(
                  child: Text(
                    "Don't Have account Sign up now",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white, fontSize: 16),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(PageRouteName.SIGNUP),
                ),
              ),
              Spacer(
                flex: 3,
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  final mediaQuery;

  _EmailPasswordForm(this.mediaQuery);

  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(2)),
            validator: (String value) {
              if (!Validator.isEmail(value)) {
                return 'Please enter some text';
              }
              return null;
            },
          ).addStyleOnly(widget.mediaQuery),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(2)),
            validator: (String value) {
              if (value.isEmpty) return 'Please enter some text';
              return null;
            },
            obscureText: true,
          ).addStyleOnly(widget.mediaQuery),
          loading ? Center(child: CircularProgressIndicator(),) : Text(
            'Sign in',
            style: Theme
                .of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ).addSocialStyleOnly(widget.mediaQuery, _signInWithEmailAndPassword),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )).user;
      setState(() {
        loading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("${user.email} signed in"),
      ));
      Navigator.of(context).pushNamed(PageRouteName.CAMERA);
    } catch (e) {
      setState(() {
        loading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }
}
