
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/shared/widgets/common/screen_title.dart';

import '../../../../core/shared/widgets/textfields/app_code_pin_field.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/signup/signup_bloc.dart';



class CodePinScreen extends StatefulWidget {

  const CodePinScreen({super.key});


  @override
  State<CodePinScreen> createState() => _CodePinScreenState();
}

class _CodePinScreenState extends State<CodePinScreen> {

  final _numeroMask = MaskTextInputFormatter(mask: "## ## ## ## ##", filter: {"#": RegExp(r"[0-9]")});

  late TextEditingController _codePinController;
  late TextEditingController _confirmCodePinController;


  @override
  void initState() {
    super.initState();
    _codePinController = TextEditingController();
    _confirmCodePinController = TextEditingController();
  }


  @override
  void dispose() {
    _codePinController.dispose();
    _confirmCodePinController.dispose();
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
          appBar: CustomAppBar(title: 'Code Pin',),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [

                ScreenTitle(
                    title: "Définissez un code pin",
                    subtitle: "Ce code vous permettra d'accéder à l'application "
                ),

                AppCodePinField(
                  hintText: "Code PIN (4 chiffres)",
                  controller: _codePinController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpPrenomsChanged(value.trim())),
                ),


                AppCodePinField(
                  hintText: "Confirmer le code PIN",
                  controller: _confirmCodePinController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<SignUpBloc>().add(SignUpPrenomsChanged(value.trim())),
                ),



                //AuthText(),

                AppBtnValidate(
                  enabled: true,
                  label: 'Continuer',
                  // enabled: state.isValid && !state.submissionStatus.isInProgress,
                 // enabled: state.canSubmit,
                  backgroundColor: AppColor.primaryColor,
                  onPress: () => context.pushNamed(RoutePath.home.name),
                  //onPress: () => context.read<SignUpBloc>().add(SignUpSubmitted()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}




