import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odoo_apexive/blocs/bloc_exports.dart';
import 'package:odoo_apexive/blocs/create_timer_form_bloc/create_timer_form_bloc.dart';
import 'package:odoo_apexive/data/models/data_type.dart';
import 'package:odoo_apexive/data/models/project.dart';
import 'package:odoo_apexive/data/repository/timesheets_repo_impl.dart';
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
    final timesheetsApiBloc = TimesheetsApiBloc(TimesheetsRepoImpl());
    final taskListBloc = context.read<TaskListBloc>();
    final formBloc = CreateTimerFormBloc(
      timesheetsApiBloc: timesheetsApiBloc,
      taskListBloc: taskListBloc,
    );

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => formBloc,
          ),
          BlocProvider(
            create: (context) => timesheetsApiBloc,
          )
        ],
        child: Builder(
          builder: (context) {
            return FormBlocListener<CreateTimerFormBloc, String, String>(
              onSubmitting: (context, state) {
                debugPrint("submitting");
              },
              onSubmissionFailed: (context, state) {
                debugPrint("failed $state");
              },
              onFailure: (context, state) {
                debugPrint("failure");
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failureResponse!)));
              },
              onSuccess: (context, state) {
                Navigator.pop(context);
              },
              child: BlocListener<TimesheetsApiBloc, TimesheetsApiState>(
                bloc: timesheetsApiBloc,
                listener: (context, state) {
                  if (state is TimesheetsApiErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        action: SnackBarAction(
                          label: "Retry",
                          onPressed: state is TimesheetsApiProjectsRequestError
                              ? () => timesheetsApiBloc
                                  .add(const LoadProjectsEvent())
                              : () => timesheetsApiBloc.add(LoadTasksEvent(
                                  project: formBloc.projectSelectField.value
                                      as Project)),
                        ),
                      ),
                    );
                  }

                  if (state is TimesheetsApiProjectsRequestError) {}
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
                                labelText:
                                    AppLocalizations.of(context)!.project,
                                onChanged: (value) {
                                  formBloc.onProjectChanged(value);
                                },
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
                                text:
                                    AppLocalizations.of(context)!.makeFavorite,
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
              ),
            );
          },
        ));
  }
}

class _FormDropDown extends StatelessWidget {
  const _FormDropDown({
    required this.selectField,
    required this.labelText,
    this.onChanged,
  });

  final SelectFieldBloc<TimesheetsDataType, dynamic> selectField;
  final String labelText;
  final Function(TimesheetsDataType?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.xxxc,
      child: DropdownFieldBlocBuilder<TimesheetsDataType>(
        selectFieldBloc: selectField,
        showEmptyItem: false,
        onChanged: onChanged,
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
          child: Text(value.name),
        ),
      ),
    );
  }
}

class _FormCheckBoxField extends StatelessWidget {
  const _FormCheckBoxField({
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
