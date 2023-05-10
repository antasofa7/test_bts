import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:my_apps/cubit/auth_cubit.dart';
import 'package:my_apps/cubit/checklist_item_cubit.dart';
import 'package:my_apps/cubit/checklists_cubit.dart';
import 'package:my_apps/cubit/delete_checklist_cubit.dart';
import 'package:my_apps/cubit/delete_checklist_item_cubit.dart';
import 'package:my_apps/cubit/register_cubit.dart';
import 'package:my_apps/cubit/save_checklist_cubit.dart';
import 'package:my_apps/cubit/save_checklist_item_cubit.dart';
import 'package:my_apps/cubit/update_item_name_cubit.dart';
import 'package:my_apps/cubit/update_item_status_cubit.dart';
import 'package:my_apps/models/checklist_model.dart';
import 'package:my_apps/pages/detail_page.dart';
import 'package:my_apps/pages/home_page.dart';
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
        BlocProvider(
          create: (context) => ChecklistsCubit(),
        ),
        BlocProvider(
          create: (context) => SaveChecklistCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteChecklistCubit(),
        ),
        BlocProvider(
          create: (context) => ChecklistItemCubit(),
        ),
        BlocProvider(
          create: (context) => SaveChecklistItemCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateItemNameCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateItemStatusCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteChecklistItemCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        initialRoute: LoginPage.routeName,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          HomePage.routeName: (context) => const HomePage(),
          DetailPage.routeName: (context) => DetailPage(
              model:
                  ModalRoute.of(context)?.settings.arguments as DataCheckList)
        },
      ),
    );
  }
}
