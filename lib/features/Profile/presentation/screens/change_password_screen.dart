import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/shared/widgets/textfields/app_password_field.dart';
import '../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/change_password/change_password_bloc.dart';


class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;
    context.read<ChangePasswordBloc>().add(ChangeLoginChanged(user.login));
  }


  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(

      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,

      listener: (BuildContext context, ChangePasswordState state) {

        if (state.submissionStatus.isInProgress) {
          AppLoader.show(context: context);
        }

        if (state.submissionStatus.isSuccess) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!, isError: false);
          context.pop();
        }

        if (state.submissionStatus.isFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!);
        }
      },
      builder: (BuildContext context, ChangePasswordState state) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(text: "Change Password"),
            centerTitle: true,
          ),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [

                AppPasswordField(
                  hintText: "Mot de passe actuel",
                  labelText: "Mot de passe actuel",
                  controller: _oldPasswordController,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) => context.read<ChangePasswordBloc>().add(ChangeOldPasswordChanged(value)),
                ),

                AppPasswordField(
                  hintText: "Nouveau mot de passe",
                  labelText: "Nouveau mot de passe",
                  controller: _newPasswordController,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) => context.read<ChangePasswordBloc>().add(ChangeNewPasswordChanged(value)),
                ),

                AppPasswordField(
                  hintText: "Confirmer nouveau mot de passe",
                  labelText: "Confirmer nouveau mot de passe",
                  controller: _confirmNewPasswordController,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.none,
                  onChanged: (value) => context.read<ChangePasswordBloc>().add(ChangeConfirmNewPasswordChanged(value)),
                ),

                AppBtnValidate(
                  label: 'Enregister',
                  // enabled: state.isValid && !state.submissionStatus.isInProgress,
                  enabled: state.canSubmit,
                  backgroundColor: AppColor.gradient1,
                  onPress: () => context.read<ChangePasswordBloc>().add(ChangePasswordSubmitted()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




