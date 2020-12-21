import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topMediaQueryData = MediaQuery.of(context);
    final topHeight = topMediaQueryData.viewPadding.deflateSize(topMediaQueryData.size).height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: topHeight,
              ),
              child: IntrinsicHeight(
                child: RegisterForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _registerFormKey = GlobalKey<FormState>();

  String _username;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Form(
          key: _registerFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Center(
                child: WebTritPhonePictureLogo(),
              ),
              SizedBox(
                height: 80,
              ),
              TextFormField(
                initialValue: _username,
                decoration: InputDecoration(
                  labelText: 'Choose a username',
                  helperText: '', // reserve space for validator message
                  errorText: state is RegistrationFailure ? state.reason : null,
                  errorMaxLines: 3,
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
                enabled: state is! RegistrationInProgress,
              ),
              SizedBox(
                height: 10,
              ),
              OutlineButton(
                onPressed: state is RegistrationInProgress ? null : _register,
                child: Text('Register'),
              ),
              SizedBox(
                height: 10,
              ),
              if (state is RegistrationInProgress)
                Center(
                  child: CircularProgressIndicator(),
                ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text('Some copyright'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _register() {
    if (_registerFormKey.currentState.validate()) {
      _registerFormKey.currentState.save();
      context.read<RegistrationBloc>().add(RegistrationProcessed(username: _username));
    }
  }
}
