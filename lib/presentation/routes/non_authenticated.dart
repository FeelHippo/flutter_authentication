import 'package:flutter/material.dart';
import 'package:flutter_authentication/bloc/login/cubit.dart';
import 'package:flutter_authentication/presentation/common/app_scaffold.dart';
import 'package:flutter_authentication/presentation/common/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NonAuthenticatedRoute extends StatelessWidget {
  const NonAuthenticatedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginWidget();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Login Your\nAccount',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Email Address',
                          style: TextStyle(fontSize: 14),
                        ),
                        CustomTextFormField(
                          controller: _emailController,
                          validator: (String? value) {
                            if (value != null && value.isNotEmpty) {
                              final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value);
                              if (!emailValid) return 'Enter valid email';
                            }
                            return 'Enter valid email';
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 14),
                        ),
                        CustomTextFormField(
                          controller: _passwordController,
                          validator: (String? value) {
                            if (value != null && value.isNotEmpty) {
                              final bool passwordValid = RegExp(
                                r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$",
                              ).hasMatch(value);
                              if (!passwordValid) return 'Enter valid password';
                            }
                            return 'Enter valid password';
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        Text(
                          'Forgot Password ?',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(72),
                          ),
                          height: 56,
                          minWidth: MediaQuery.of(context).size.width - 20,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: _validateLogin,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Do Not Have an Account ?',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().authenticate(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data', textAlign: TextAlign.center),
        ),
      );
    }
  }
}
