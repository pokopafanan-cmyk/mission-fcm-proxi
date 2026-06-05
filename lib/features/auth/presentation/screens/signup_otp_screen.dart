import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/di/init_dependencies.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/shared/widgets/textfields/app_pin_field.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/signin2/signin2_bloc.dart';
import '../bloc/timer/timer_bloc.dart';
import '../widgets/count_down_timer.dart';


class SignupOtpScreen extends StatefulWidget {

  const SignupOtpScreen({super.key});

  @override
  State<SignupOtpScreen> createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreen> {

  late TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    final userTime = context.read<SignIn2Bloc>().state.userTime;
    context.read<TimerBloc>().add(TimerStarted(duration: userTime));
  }
  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignIn2Bloc, SignIn2State>(
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,

      listener: (BuildContext context, SignIn2State state) {
        if (state.submissionStatus.isInProgress) {
          AppLoader.show(context: context);
        }

        if (state.submissionStatus.isSuccess) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!, isError: false);

          if (state.isResend) {
            context.read<TimerBloc>().add(TimerStarted(duration: state.userTime));
          } else {
            context.pushReplacementNamed(RoutePath.home.name);
          }
        }

        if (state.submissionStatus.isFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message!);

          if (state.tryCount <= 0) {
            context.pushReplacementNamed(RoutePath.signIn2.name);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(title: 'Code OTP',),
          body: Center(
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.all(AppSize.screenPadding),
              shrinkWrap: true,
              children: [
                AppText(
                  text: 'Vérification',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromRGBO(30, 60, 87, 1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                AppText(
                  text: 'Saisissez le code envoyé au numéro',
                  fontSize: 16,
                  color: const Color.fromRGBO(133, 153, 170, 1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                AppText(
                //  text: "+225 ${sl<AppUtils>().formatNumberGroups(state.mobile.value, 2)}",
                  text: "+225 07 49 62 66 42",
                  fontSize: 16,
                  color: const Color.fromRGBO(30, 60, 87, 1),
                  textAlign: TextAlign.center,
                  fontStyle: FontStyle.italic,
                ),

                const SizedBox(height: 25),

                AppPinField(
                  length: 6,
                  controller: _pinController,
                  onCompleted: (pin) {
                   // context.read<SignIn2Bloc>().add(SignInVerifyOtp());
                  },
                  onChanged: (value) => context.read<SignIn2Bloc>().add(SignInEnteredOtpChanged(value.trim())),
                ),

                const SizedBox(height: 10),

                CountDownTimer(
                  onPressed: () => context.read<SignIn2Bloc>().add(SignInRequestOtp()),
                ),

                AppBtnValidate(
                  label: 'Connexion',
                 enabled: true,
                 // enabled: state.canVerifyOtp,
                //  backgroundColor: AppColor.gradient1,
                  //onPress: () => context.read<SignIn2Bloc>().add(SignInVerifyOtp()),
                  onPress: () => context.pushNamed(RoutePath.codePin.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}





