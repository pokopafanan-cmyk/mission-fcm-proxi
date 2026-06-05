import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../../core/shared/widgets/textfields/app_phone_field.dart';
import '../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/textfields/app_email_field.dart';
import '../../../../core/shared/widgets/textfields/app_textfield.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/update_user/update_user_bloc.dart';


class UpdateUserScreen extends StatefulWidget {

  const UpdateUserScreen({super.key});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {

  final _numeroMask = MaskTextInputFormatter(mask: "## ## ## ## ##", filter: {"#": RegExp(r"[0-9]")});

  late TextEditingController _nomController;
  late TextEditingController _loginController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  late TextEditingController _numeroController;
  late TextEditingController _numeroIntlController;


  @override
  void initState() {
    super.initState();

    final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;
    context.read<UpdateUserBloc>().add(UpdateUserFormInitialized(user));

    _loginController = TextEditingController(text: user.login);
    _nomController = TextEditingController(text: user.nom);
    _prenomController = TextEditingController(text: user.prenoms);
    _emailController = TextEditingController(text: user.email);
    _numeroController = TextEditingController();
    _numeroIntlController = TextEditingController();

    _numeroController.value = _numeroMask.updateMask(
      mask: "## ## ## ## ##",
      newValue: TextEditingValue(text: user.localMobile),
      filter: {"#": RegExp(r"[0-9]")},
    );
  }


  @override
  void dispose() {
    _loginController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _numeroController.dispose();
    _numeroIntlController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateUserBloc, UpdateUserState>(

      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,

      listener: (BuildContext context, UpdateUserState state) {

        if (state.submissionStatus.isInProgress) {
          AppLoader.show(context: context);
        }

        if (state.submissionStatus.isSuccess) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!, isError: false);
          context.read<AuthBloc>().add(AuthUserUpdated(state.user!),);
          context.pop();
        }

        if (state.submissionStatus.isFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!);
        }
      },
      builder: (BuildContext context, UpdateUserState state) {
        return Scaffold(
          appBar: AppBar(
            title: AppText(text: "Edit User"),
            centerTitle: true,
          ),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [

                AppTextField(
                  hintText: "Login",
                  labelText: "Login",
                  controller: _loginController,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<UpdateUserBloc>().add(UpdateUserLoginChanged(value.trim())),
                ),

                AppTextField(
                  hintText: "Nom",
                  labelText: "Nom",
                  controller: _nomController,
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<UpdateUserBloc>().add(UpdateUserNomChanged(value.trim())),
                ),

                AppTextField(
                  hintText: "Prénoms",
                  labelText: "Prénoms",
                  controller: _prenomController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<UpdateUserBloc>().add(UpdateUserPrenomsChanged(value.trim())),
                ),

                AppEmailField(
                  hintText: "Email",
                  labelText: "Email",
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<UpdateUserBloc>().add(UpdateUserEmailChanged(value.trim())),
                ),

                AppPhoneField(
                  hintText: "Numéro",
                  labelText: "Numéro",
                  controller: _numeroController,
                  textInputFormatters: [_numeroMask],
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<UpdateUserBloc>().add(UpdateUserMobileChanged(value.trim())),
                ),

                // AppIntlPhoneField(
                //   hintText: "Numéro",
                //   labelText: "Numéro",
                //   controller: _numeroIntlController,
                //   countries: myCountriesAl,
                //   textInputAction: TextInputAction.done,
                //   onCountryChanged: (Country country) {},
                //   onChanged: (PhoneNumber phoneNumber) {
                //     context.read<UpdateUserBloc>().add(UpdateUserMobileChanged(phoneNumber.number));
                //   },
                // ),

                AppBtnValidate(
                  label: 'Enregister',
                  // enabled: state.isValid && state.isModified && !state.submissionStatus.isInProgress,
                  enabled: state.canSubmit,
                  backgroundColor: AppColor.gradient1,
                  onPress: () => context.read<UpdateUserBloc>().add(UpdateUserSubmitted()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




