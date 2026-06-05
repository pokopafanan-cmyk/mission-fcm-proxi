import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/shared/widgets/common/screen_title.dart';
import '../../../../core/shared/widgets/textfields/app_email_field.dart';
import '../../../../core/shared/widgets/textfields/app_password_field.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/signin/signin_bloc.dart';
import '../widgets/auth_text.dart';


class SignInScreen extends StatefulWidget {

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late TextEditingController _passwordController;
  late TextEditingController _emailController;


  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,

      listener: (BuildContext context, SignInState state) {
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
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Se connecter',),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [
                ScreenTitle(
                    title: "Choisissez le type d'insription",
                    subtitle: "Bienvenue ! Veuillez vous connecter à votre compte"
                ),

                SizedBox(height: 30,),

                AppEmailField(
                  hintText: "Email",
                  labelText: "Email",
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChanged: (text) {},
                ),

                AppPasswordField(
                  hintText: "Mot de passe",
                  labelText: "Mot de passe",
                  controller: _passwordController,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<SignInBloc>().add(SignInPasswordChanged(value)),
                ),

                // AuthText(signup: false,),

                Center(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        textAlign: TextAlign.center,
                        text: "Mot de passe oublié ?",
                        color: Colors.blueAccent,
                      ),
                    ),
                    onTap: () => context.goNamed(RoutePath.requestReset.name),
                  ),
                ),

                AppBtnValidate(
                  enabled: true,
                  label: 'Se Connecter',
                //  enabled: _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty,
                  onPress: () {
                    context.pushNamed(RoutePath.signInOtp.name);
                  },

                  // enabled: state.canSubmit,
                  // onPress: () => context.read<SignInBloc>().add(SignInSubmitted()),

                ),

                AuthText(signup: false,),
              ],
            ),
          ),
        );
      },
    );
  }
}




