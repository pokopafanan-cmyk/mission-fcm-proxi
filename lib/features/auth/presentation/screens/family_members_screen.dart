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
import '../../../../core/shared/widgets/textfields/app_date_field.dart';
import '../../../../core/shared/widgets/textfields/app_email_field.dart';
import '../../../../core/shared/widgets/textfields/app_identity_document_picker.dart';
import '../../../../core/shared/widgets/textfields/app_textfield.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/signup/signup_bloc.dart';
import '../widgets/auth_text.dart';
import '../widgets/label_radio_button.dart';


class FamilyMemberScreen extends StatefulWidget {

  const FamilyMemberScreen({super.key});


  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {

  final _numeroMask = MaskTextInputFormatter(mask: "## ## ## ## ##", filter: {"#": RegExp(r"[0-9]")});

  late TextEditingController _nomController;
  late TextEditingController _loginController;
  late TextEditingController _prenomController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _emailController;
  late TextEditingController _numeroController;
  late TextEditingController _numeroIntlController;
  late TextEditingController _relationshipController;
  late TextEditingController _ageController;
  late TextEditingController _ageDeathController;
  late TextEditingController _causeDeathController;

  String groupValue = "Living";
  List<String> formule = ["Living", "Deceased"];


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
    _relationshipController = TextEditingController();
    _ageController = TextEditingController();
    _ageDeathController = TextEditingController();
    _causeDeathController = TextEditingController();
    _numeroIntlController = TextEditingController();

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
    _relationshipController.dispose();
    _ageController.dispose();
    _ageDeathController.dispose();
    _causeDeathController.dispose();
    _numeroIntlController.dispose();
    super.dispose();
  }

  void onChanged(String? value) {
    if (value == null) return;
    setState(() {
      groupValue = value;
    });
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
          appBar: CustomAppBar(title: 'Family Members',),
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
                  hintText: "Relationship",
                  labelText: "Relationship",
                  controller: _relationshipController,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (text) {},
                ),

                AppTextField(
                  hintText: "Age",
                  labelText: "Age",
                  controller: _ageController,
                  textCapitalization: TextCapitalization.words,
                  textInputType: TextInputType.numberWithOptions(),
                  onChanged: (text) {},
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
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpMobileChanged(value.trim())),
                ),

                Row(
                  children: formule.map((value) {
                    return MyRadio(
                      label: value,
                      value: value,
                      groupValue: groupValue,
                      onChanged: onChanged,
                      backgroundColor: Colors.white,
                    );
                  }).toList(),
                ),

                SizedBox(height: 20,),

                AppTextField(
                  hintText: "Age at death",
                  labelText: "Age at death",
                  controller: _ageDeathController,
                  textCapitalization: TextCapitalization.words,
                  textInputType: TextInputType.numberWithOptions(),
                  onChanged: (text) {},
                ),

                AppTextField(
                  hintText: "Cause of death",
                  labelText: "Cause of death",
                  controller: _causeDeathController,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onChanged: (text) {},
                ),


                AppBtnValidate(
                  label: 'Enregister',
                  // enabled: state.isValid && !state.submissionStatus.isInProgress,
               //   enabled: state.canSubmit,
                  enabled: true,
                 // backgroundColor: AppColor.primaryColor,
                //  onPress: () => context.read<SignUpBloc>().add(SignUpSubmitted()),
                  onPress: () => context.pushNamed(RoutePath.signupOtp.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




