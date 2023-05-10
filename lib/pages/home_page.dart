import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_apps/cubit/auth_cubit.dart';
import 'package:my_apps/cubit/checklists_cubit.dart';
import 'package:my_apps/cubit/delete_checklist_cubit.dart';
import 'package:my_apps/cubit/save_checklist_cubit.dart';
import 'package:my_apps/pages/detail_page.dart';
import 'package:my_apps/pages/login_page.dart';
import 'package:my_apps/widgets/add_item_dialog.dart';
import 'package:my_apps/widgets/button.dart';
import 'package:my_apps/widgets/delete_alert_widget.dart';
import 'package:my_apps/widgets/input_field.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    context.read<ChecklistsCubit>().get();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
              icon: Icon(
                Icons.login_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: () {
                context.read<AuthCubit>().logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginPage.routeName,
                  (route) => false,
                );
              })
        ],
      ),
      body: BlocBuilder<ChecklistsCubit, ChecklistsState>(
          builder: (context, state) {
        if (state is CheckListSuccess) {
          var data = state.models.data ?? [];
          return RefreshIndicator(
            onRefresh: () => context.read<ChecklistsCubit>().get(),
            child: data.isEmpty
                ? Center(
                    child: Text(
                      'Data is empty!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: List.generate(
                        data.length,
                        (i) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                onTap: () => Navigator.pushNamed(
                                    context, DetailPage.routeName,
                                    arguments: data[i]),
                                title: Text(
                                  data[i].name ?? '-',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                trailing: IconButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDeleteWidget(
                                            title: 'Delete ${data[i].name}?',
                                            deleteAction: BlocConsumer<
                                                DeleteChecklistCubit,
                                                DeleteChecklistState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteCheckListSuccess) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      state.message,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                  ));
                                                  context
                                                      .read<ChecklistsCubit>()
                                                      .get();
                                                } else if (state
                                                    is DeleteCheckListFailed) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      state.errorMessage,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .error,
                                                  ));
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is DeleteCheckListLoading) {
                                                  return Text('Loading..',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium);
                                                }
                                                return TextButton(
                                                    child: Text(
                                                      'Delete',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .error,
                                                          ),
                                                    ),
                                                    onPressed: () => context
                                                        .read<
                                                            DeleteChecklistCubit>()
                                                        .delete(
                                                            id: data[i].id!));
                                              },
                                            ),
                                          )),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            )),
                  ),
          );
        } else if (state is CheckListFailed) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is CheckListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const SizedBox();
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.background,
            size: 24.0,
          ),
          onPressed: () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AddItemDialog(
                  controller: _nameController,
                  saveButton:
                      BlocConsumer<SaveChecklistCubit, SaveChecklistState>(
                    listener: (context, state) {
                      if (state is SaveCheckListSuccess) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ));
                        context.read<ChecklistsCubit>().get();
                      } else if (state is SaveCheckListFailed) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            state.errorMessage,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is SaveCheckListLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ButtonWidget(
                          label: 'Save',
                          onPress: () => context
                              .read<SaveChecklistCubit>()
                              .save(name: _nameController.text));
                    },
                  ),
                ),
              )),
    );
  }
}
