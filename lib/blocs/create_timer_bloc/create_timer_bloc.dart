import 'package:odoo_apexive/blocs/bloc_exports.dart';

class CreateTimerFormBloc extends FormBloc<String, String> {
  CreateTimerFormBloc() : super(autoValidate: false) {
    addFieldBlocs(fieldBlocs: [
      taskSelectField,
      projectSelectField,
      descriptionTextField,
      isFavoriteCheckBox,
    ]);
  }

  final taskSelectField = SelectFieldBloc(
    items: ['Task 1', 'Task 2'],
    validators: [FieldBlocValidators.required],
  );
  final projectSelectField = SelectFieldBloc(
    items: ['Project 1', 'Project 2'],
    validators: [FieldBlocValidators.required],
  );
  final descriptionTextField = TextFieldBloc();
  final isFavoriteCheckBox = BooleanFieldBloc();

  @override
  void onSubmitting() async {
    try {
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}
