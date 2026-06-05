import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../../core/shared/widgets/textfields/app_password_field.dart';
import '../../../../../core/shared/widgets/textfields/app_phone_field.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/shared/widgets/common/screen_title.dart';
import '../../../../core/shared/widgets/intl_phone/countries.dart';
import '../../../../core/shared/widgets/intl_phone/intl_phone_textfield.dart';
import '../../../../core/shared/widgets/intl_phone/phone_number.dart';
import '../../../../core/shared/widgets/textfields/app_email_field.dart';
import '../../../../core/shared/widgets/textfields/app_identity_document_picker.dart';
import '../../../../core/shared/widgets/textfields/app_textfield.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/signup/signup_bloc.dart';
import '../widgets/auth_text.dart';


class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _numeroMask = MaskTextInputFormatter(mask: "## ## ## ## ##", filter: {"#": RegExp(r"[0-9]")});

  late TextEditingController _nomController;
  late TextEditingController _loginController;
  late TextEditingController _prenomController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;
  late TextEditingController _numeroController;
  late TextEditingController _numeroIntlController;
  late TextEditingController _idRectoController;
  late TextEditingController _idVersoController;


  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _emailController = TextEditingController();
    _numeroController = TextEditingController();
    _numeroIntlController = TextEditingController();
    _idRectoController = TextEditingController();
    _idVersoController = TextEditingController();
  }


  @override
  void dispose() {
    _loginController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _numeroController.dispose();
    _numeroIntlController.dispose();
    _idRectoController.dispose();
    _idVersoController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(

      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,

      listener: (BuildContext context, SignUpState state) {

        if (state.submissionStatus.isInProgress) {
          AppLoader.show(context: context);
        }

        if (state.submissionStatus.isSuccess) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!, isError: false);
          context.pushReplacementNamed(RoutePath.signIn.name);
        }

        if (state.submissionStatus.isFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!);
        }
      },
      builder: (BuildContext context, SignUpState state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Register',
          ),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [

                ScreenTitle(
                    title: "Choisissez le type d'insription",
                    subtitle: "Inscrivez-vous pour essayer nos services "
                ),
                AppTextField(
                  hintText: "Nom",
                  labelText: "Nom",
                  controller: _nomController,
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpNomChanged(value.trim())),
                ),

                AppTextField(
                  hintText: "Prénoms",
                  labelText: "Prénoms",
                  controller: _prenomController,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpPrenomsChanged(value.trim())),
                ),

                AppEmailField(
                  hintText: "Email",
                  labelText: "Email",
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpEmailChanged(value.trim())),
                ),

                AppPhoneField(
                  hintText: "Numéro",
                  labelText: "Numéro",
                  controller: _numeroController,
                  textInputFormatters: [_numeroMask],
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpMobileChanged(value.trim())),
                ),

                AppPasswordField(
                  hintText: "Mot de passe",
                  labelText: "Mot de passe",
                  controller: _passwordController,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpPasswordChanged(value.trim())),
                ),

                AppPasswordField(
                  hintText: "Confirmer mot de passe",
                  labelText: "Confirmer mot de passe",
                  controller: _confirmPasswordController,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpConfirmPasswordChanged(value.trim())),
                ),



                AuthText(),

                AppBtnValidate(
                  label: 'Enregister',
                 //  enabled: state.isValid && !state.submissionStatus.isInProgress,
                //  enabled: state.canSubmit,
                  enabled: true,
                  backgroundColor: AppColor.primaryColor,
                //  onPress: () => context.read<SignUpBloc>().add(SignUpSubmitted()),
                  onPress: () => context.pushNamed(RoutePath.familyMember.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




