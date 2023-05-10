import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_apps/cubit/checklist_item_cubit.dart';
import 'package:my_apps/cubit/checklists_cubit.dart';
import 'package:my_apps/cubit/delete_checklist_cubit.dart';
import 'package:my_apps/cubit/save_checklist_cubit.dart';
import 'package:my_apps/cubit/save_checklist_item_cubit.dart';
import 'package:my_apps/cubit/update_item_name_cubit.dart';
import 'package:my_apps/cubit/update_item_status_cubit.dart';
import 'package:my_apps/models/checklist_model.dart';
import 'package:my_apps/widgets/add_item_dialog.dart';
import 'package:my_apps/widgets/button.dart';
import 'package:my_apps/widgets/delete_alert_widget.dart';
import 'package:my_apps/widgets/input_field.dart';

import '../cubit/delete_checklist_item_cubit.dart';

enum Mode { view, updatename, updatestatus }

class DetailPage extends StatefulWidget {
  static const String routeName = '/detail';
  final DataCheckList model;
  const DetailPage({super.key, required this.model});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _nameController = TextEditingController();

  Mode mode = Mode.view;
  bool? status;

  @override
  void initState() {
    context.read<ChecklistItemCubit>().get(id: widget.model.id!);
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
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.outline,
        ),
        title: Text(
          widget.model.name ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: BlocBuilder<ChecklistItemCubit, ChecklistItemState>(
          builder: (context, state) {
        if (state is CheckListItemSuccess) {
          var data = state.models.data ?? [];
          return RefreshIndicator(
            onRefresh: () =>
                context.read<ChecklistItemCubit>().get(id: widget.model.id!),
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
                                onTap: () => showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      status =
                                          data[i].itemCompletionStatus ?? false;
                                      return StatefulBuilder(
                                          builder: (context, stateDetail) {
                                        stateDetail(() => _nameController.text =
                                            data[i].name ?? '');
                                        return Dialog(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Item Name',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                                mode == Mode.updatename
                                                    ? InputField(
                                                        label: '',
                                                        controller:
                                                            _nameController,
                                                        suffixIcon: true,
                                                        suffixIconWidget: BlocConsumer<
                                                                UpdateItemNameCubit,
                                                                UpdateItemNameState>(
                                                            listener: (context,
                                                                state) async {
                                                          if (state
                                                              is UpdateItemNameSuccess) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                state.message,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              ),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                            ));
                                                            stateDetail(
                                                              () => mode =
                                                                  Mode.view,
                                                            );
                                                            await context
                                                                .read<
                                                                    ChecklistItemCubit>()
                                                                .get(
                                                                    id: widget
                                                                        .model
                                                                        .id!);
                                                          } else if (state
                                                              is UpdateItemNameFailed) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                state
                                                                    .errorMessage,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              ),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .error,
                                                            ));
                                                            stateDetail(
                                                              () => mode =
                                                                  Mode.view,
                                                            );
                                                          }
                                                        }, builder: (context,
                                                                state) {
                                                          if (state
                                                              is UpdateItemNameLoading) {
                                                            return const CircularProgressIndicator();
                                                          }
                                                          return IconButton(
                                                              onPressed: () => context
                                                                  .read<
                                                                      UpdateItemNameCubit>()
                                                                  .updateName(
                                                                      id: widget
                                                                          .model
                                                                          .id!,
                                                                      idItem: data[
                                                                              i]
                                                                          .id!,
                                                                      itemName:
                                                                          _nameController
                                                                              .text),
                                                              icon: Icon(
                                                                Icons.save,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ));
                                                        }))
                                                    : ListTile(
                                                        title: Text(
                                                          data[i].name ?? '-',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                        trailing: IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          onPressed: () =>
                                                              stateDetail(
                                                            () => mode =
                                                                Mode.updatename,
                                                          ),
                                                        ),
                                                      ),
                                                Text(
                                                  'Status',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                                ListTile(
                                                  title: mode ==
                                                          Mode.updatestatus
                                                      ? Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            ListTile(
                                                              title: Text(
                                                                'True',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                              leading:
                                                                  Radio<bool>(
                                                                value: true,
                                                                groupValue:
                                                                    status,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  stateDetail(() =>
                                                                      status =
                                                                          value);
                                                                },
                                                              ),
                                                            ),
                                                            ListTile(
                                                              title: Text(
                                                                'False',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
                                                              ),
                                                              leading:
                                                                  Radio<bool>(
                                                                value: false,
                                                                groupValue:
                                                                    status,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  stateDetail(() =>
                                                                      status =
                                                                          value);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          data[i]
                                                                  .itemCompletionStatus
                                                                  ?.toString() ??
                                                              '-',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                  trailing: mode ==
                                                          Mode.updatestatus
                                                      ? BlocConsumer<
                                                              UpdateItemStatusCubit,
                                                              UpdateItemStatusState>(
                                                          listener: (context,
                                                              state) async {
                                                          if (state
                                                              is UpdateItemStatusSuccess) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                state.message,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              ),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                            ));
                                                            stateDetail(
                                                              () => mode =
                                                                  Mode.view,
                                                            );
                                                            await context
                                                                .read<
                                                                    ChecklistItemCubit>()
                                                                .get(
                                                                    id: widget
                                                                        .model
                                                                        .id!);
                                                          } else if (state
                                                              is UpdateItemStatusFailed) {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                state
                                                                    .errorMessage,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge,
                                                              ),
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .error,
                                                            ));
                                                            stateDetail(
                                                              () => mode =
                                                                  Mode.view,
                                                            );
                                                          }
                                                        }, builder:
                                                              (context, state) {
                                                          if (state
                                                              is UpdateItemStatusLoading) {
                                                            return const CircularProgressIndicator();
                                                          }
                                                          return IconButton(
                                                              onPressed: () => context
                                                                  .read<
                                                                      UpdateItemStatusCubit>()
                                                                  .updateStatus(
                                                                    id: widget
                                                                        .model
                                                                        .id!,
                                                                    idItem:
                                                                        data[i]
                                                                            .id!,
                                                                  ),
                                                              icon: Icon(
                                                                Icons.save,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                              ));
                                                        })
                                                      : IconButton(
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          onPressed: () =>
                                                              stateDetail(() =>
                                                                  mode = Mode
                                                                      .updatestatus),
                                                        ),
                                                ),
                                                const SizedBox(
                                                  height: 32.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ButtonWidget(
                                                          label: 'Cancel',
                                                          outlined: true,
                                                          onPress: () => mode ==
                                                                  Mode.view
                                                              ? Navigator.pop(
                                                                  context)
                                                              : stateDetail(
                                                                  () => mode =
                                                                      Mode.view,
                                                                )),
                                                    ),
                                                    const SizedBox(
                                                      width: 8.0,
                                                    ),
                                                    // mode == Mode.updatename
                                                    //     ? Expanded(
                                                    //         child: )
                                                    //     : const SizedBox(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    }),
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
                                                DeleteChecklistItemCubit,
                                                DeleteChecklistItemState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteCheckListItemSuccess) {
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
                                                      .read<
                                                          ChecklistItemCubit>()
                                                      .get(
                                                          id: widget.model.id!);
                                                } else if (state
                                                    is DeleteCheckListItemFailed) {
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
                                                    is DeleteCheckListItemLoading) {
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
                                                            DeleteChecklistItemCubit>()
                                                        .delete(
                                                            id: widget
                                                                .model.id!,
                                                            idItem:
                                                                data[i].id!));
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
        } else if (state is CheckListItemFailed) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is CheckListItemLoading) {
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
                  saveButton: BlocConsumer<SaveChecklistItemCubit,
                      SaveChecklistItemState>(
                    listener: (context, state) {
                      if (state is SaveCheckListItemSuccess) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ));
                        context
                            .read<ChecklistItemCubit>()
                            .get(id: widget.model.id!);
                      } else if (state is SaveCheckListItemFailed) {
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
                              .read<SaveChecklistItemCubit>()
                              .save(
                                  id: widget.model.id!,
                                  itemName: _nameController.text));
                    },
                  ),
                ),
              )),
    );
  }
}
