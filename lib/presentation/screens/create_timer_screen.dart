import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/blocs/create_timer_bloc/create_timer_bloc.dart';
import 'package:odoo_apexive/models/task_timer.dart';
import 'package:odoo_apexive/presentation/styles/app_dimens.dart';
import 'package:odoo_apexive/presentation/styles/vector_graphics.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/app_bar_small_title.dart';
import 'package:odoo_apexive/presentation/widgets/gradient_scaffold.dart';
import 'package:odoo_apexive/presentation/widgets/app_bar/main_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odoo_apexive/presentation/widgets/opacity_button.dart';

class CreateTimerScreen extends StatelessWidget {
  const CreateTimerScreen({super.key});

  static const routeName = '/createTimer';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CreateTimerFormBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = BlocProvider.of<CreateTimerFormBloc>(context);

            return FormBlocListener<CreateTimerFormBloc, String, String>(
              onSubmitting: (context, state) {
                debugPrint("submitting");
              },
              onSubmissionFailed: (context, state) {
                debugPrint("failed $state");
              },
              onFailure: (context, state) {
                debugPrint("failure");
              },
              onSuccess: (context, state) {
                context.read<TaskListBloc>().add(
                      AddTaskTimer(
                        taskTimer: TaskTimer(
                          task: formBloc.taskSelectField.state.value ?? "",
                          project:
                              formBloc.projectSelectField.state.value ?? "",
                          description: formBloc.descriptionTextField.value,
                          isFavourite: formBloc.isFavoriteCheckBox.value,
                        ),
                      ),
                    );
                Navigator.pop(context);
              },
              child: GradientScaffold(
                appBar: MainAppBar(
                  centerTitle: true,
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios_new_rounded)),
                  title: AppBarSmallTitle(
                      title: AppLocalizations.of(context)!.createTimer),
                ),
                body: ScrollableFormBlocManager(
                  formBloc: formBloc,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            _FormDropDown(
                              selectField: formBloc.projectSelectField,
                              labelText: AppLocalizations.of(context)!.project,
                            ),
                            _FormDropDown(
                              selectField: formBloc.taskSelectField,
                              labelText: AppLocalizations.of(context)!.task,
                            ),
                            _FormTextField(
                              textFieldBloc: formBloc.descriptionTextField,
                              hintText:
                                  AppLocalizations.of(context)!.description,
                            ),
                            _FormCheckBoxField(
                              booleanFieldBloc: formBloc.isFavoriteCheckBox,
                              text: AppLocalizations.of(context)!.makeFavorite,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      OpacityButton(
                        title: AppLocalizations.of(context)!.createTimer,
                        onTap: () {
                          //TODO: form validation with formBloc.submit() is not working
                          formBloc.onSubmitting();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class _FormDropDown extends StatelessWidget {
  const _FormDropDown({
    super.key,
    required this.selectField,
    required this.labelText,
  });

  final SelectFieldBloc<String, dynamic> selectField;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.xxxc,
      child: DropdownFieldBlocBuilder<String>(
        selectFieldBloc: selectField,
        showEmptyItem: false,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: AppDimens.ml),
            child: SvgPicture.asset(
              AppVectorGraphics.chevronDown,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(AppDimens.s)),
          ),
        ),
        itemBuilder: (context, value) => FieldItem(
          child: Text(value),
        ),
      ),
    );
  }
}

class _FormCheckBoxField extends StatelessWidget {
  const _FormCheckBoxField({
    super.key,
    required this.booleanFieldBloc,
    required this.text,
  });

  final BooleanFieldBloc booleanFieldBloc;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.xc,
      child: CheckboxFieldBlocBuilder(
        booleanFieldBloc: booleanFieldBloc,
        body: Text(text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                )),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    super.key,
    required this.textFieldBloc,
    required this.hintText,
  });

  final TextFieldBloc textFieldBloc;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.xxxc,
      child: TextFieldBlocBuilder(
        textFieldBloc: textFieldBloc,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(AppDimens.s)),
          ),
        ),
      ),
    );
  }
}
