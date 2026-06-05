import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/shared/widgets/textfields/app_password_field.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/reset_password/reset_password_bloc.dart';


class ResetPasswordScreen extends StatefulWidget {

  final String userKey;

  const ResetPasswordScreen({super.key, required this.userKey});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  late TextEditingController _passwordController;
  late TextEditingController _confirmNewPasswordController;


  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    context.read<ResetPasswordBloc>().add(ResetPasswordUserKeyChanged(widget.userKey));
  }


  @override
  void dispose() {
    _passwordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(

      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,

      listener: (BuildContext context, ResetPasswordState state) {

        if (state.submissionStatus.isInProgress) {
          AppLoader.show(context: context);
        }

        if (state.submissionStatus.isSuccess) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!, isError: false);
        }

        if (state.submissionStatus.isFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!);
        }
      },
      builder: (BuildContext context, ResetPasswordState state) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(text: "Reset Password"),
            centerTitle: true,
          ),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [

                AppPasswordField(
                  hintText: "Nouveau mot de passe",
                  labelText: "Nouveau mot de passe",
                  controller: _passwordController,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) => context.read<ResetPasswordBloc>().add(ResetPasswordChanged(value)),
                ),

                AppPasswordField(
                  hintText: "Confirmer nouveau mot de passe",
                  labelText: "Confirmer nouveau mot de passe",
                  controller: _confirmNewPasswordController,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.none,
                  onChanged: (value) => context.read<ResetPasswordBloc>().add(ResetConfirmPasswordChanged(value)),
                ),

                AppBtnValidate(
                  label: 'Enregister',
                  enabled: state.canSubmit,
                  backgroundColor: AppColor.gradient1,
                  onPress: () => context.read<ResetPasswordBloc>().add(ResetPasswordSubmitted()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




