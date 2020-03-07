import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _registerFocusNode = FocusNode();

  String _username;

  @override
  Widget build(BuildContext context) {
    final topMediaQueryData = MediaQuery.of(context);
    final topHeight = topMediaQueryData.viewPadding.deflateSize(topMediaQueryData.size).height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _registerFocusNode.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: topHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'WebTrit',
                              style: Theme.of(context).textTheme.display3,
                            ),
                            Text(
                              'Phone',
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        initialValue: _username,
                        focusNode: _registerFocusNode,
                        decoration: InputDecoration(
                          labelText: 'Choose a username',
                          helperText: '', // reserve space for validator message
                        ),
                        textInputAction: TextInputAction.send,
                        onFieldSubmitted: (_) => _register(),
                        onSaved: (value) {
                          _username = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlineButton(
                        onPressed: _register,
                        child: Text('Register'),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Text('Some copyright'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_registerFormKey.currentState.validate()) {
      _registerFormKey.currentState.save();
      Navigator.pushReplacementNamed(context, '/main');
    }
  }
}
