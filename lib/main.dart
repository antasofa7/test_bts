import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_apps/cubit/auth_cubit.dart';
import 'package:my_apps/cubit/register_cubit.dart';
import 'package:my_apps/pages/homepage.dart';
import 'package:my_apps/pages/login_page.dart';
import 'package:my_apps/pages/register_page.dart';
import 'package:my_apps/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          HomePage.routeName: (context) => const HomePage()
        },
      ),
    );
  }
}
