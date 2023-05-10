import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_apps/cubit/auth_cubit.dart';
import 'package:my_apps/pages/home_page.dart';
import 'package:my_apps/pages/register_page.dart';
import 'package:my_apps/services/user_service.dart';
import 'package:my_apps/widgets/button.dart';
import 'package:my_apps/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 1500),
      () async {
        bool? isLoggedIn = await UserService().checkLogin();
        if (isLoggedIn!) {
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.routeName,
            (route) => false,
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.routeName,
              (route) => false,
            );
          } else if (state is AuthErrors) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.errors.errorMessage ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.errorMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        }, builder: (context, state) {
          Widget widgetLoading = const SizedBox();
          if (state is AuthLoading) {
            widgetLoading = Container(
              height: double.infinity,
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              child: Center(
                child: CircularProgressIndicator(
                    strokeWidth: 6.0,
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.6)),
              ),
            );
          }
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Text(
                      'My APPS',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Image.asset(
                      'assets/images/Mobile-login-Cristina.png',
                      width: MediaQuery.of(context).size.width - 120.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputField(
                              label: 'Username',
                              inputType: TextInputType.emailAddress,
                              suffixIcon: false,
                              controller: _usernameController,
                              helperText: '',
                              inputAction: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            InputField(
                              label: 'Password',
                              inputType: TextInputType.visiblePassword,
                              passwordField: true,
                              suffixIcon: true,
                              controller: _passwordController,
                              helperText: '',
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            ButtonWidget(
                                label: 'LOGIN',
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().login(
                                        username: _usernameController.text,
                                        password: _passwordController.text);
                                  }
                                }),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ButtonWidget(
                                label: 'REGISTER',
                                outlined: true,
                                onPress: () =>
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RegisterPage.routeName,
                                      (route) => false,
                                    ))
                          ],
                        ))
                  ]),
                ),
              ),
              widgetLoading
            ],
          );
        }));
  }
}
