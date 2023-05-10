import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_apps/cubit/register_cubit.dart';
import 'package:my_apps/pages/login_page.dart';
import 'package:my_apps/widgets/button.dart';
import 'package:my_apps/widgets/input_field.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.register.message ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ));
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginPage.routeName,
              (route) => false,
            );
          } else if (state is RegisterFailed) {
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
          if (state is RegisterLoading) {
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
                padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 24.0),
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
                      height: 8.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            InputField(
                              label: 'Email address',
                              inputType: TextInputType.emailAddress,
                              suffixIcon: false,
                              controller: _emailController,
                              helperText: '',
                              inputAction: TextInputAction.next,
                            ),
                            InputField(
                              label: 'Password',
                              inputType: TextInputType.visiblePassword,
                              passwordField: true,
                              suffixIcon: true,
                              controller: _passwordController,
                              helperText: '',
                              inputAction: TextInputAction.next,
                            ),
                            InputField(
                              label: 'Username',
                              inputType: TextInputType.text,
                              suffixIcon: false,
                              controller: _usernameController,
                              helperText: '',
                            ),
                            const SizedBox(
                              height: 32.0,
                            ),
                            ButtonWidget(
                                label: 'REGISTER',
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterCubit>().register(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        username: _usernameController.text);
                                  }
                                }),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ButtonWidget(
                                label: 'LOGIN',
                                outlined: true,
                                onPress: () =>
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      LoginPage.routeName,
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
