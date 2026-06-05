import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/textfields/app_email_field.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/show_message.dart';
import '../bloc/request_password_reset/request_password_reset_bloc.dart';
import '../widgets/auth_text.dart';


class RequestPasswordResetScreen extends StatefulWidget {

  const RequestPasswordResetScreen({super.key});

  @override
  State<RequestPasswordResetScreen> createState() => _RequestPasswordResetScreenState();
}

class _RequestPasswordResetScreenState extends State<RequestPasswordResetScreen> {

  late TextEditingController _emailController;


  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestPasswordResetBloc, RequestPasswordResetState>(
      listenWhen: (previous, current) => previous.submissionStatus != current.submissionStatus,
      listener: (BuildContext context, RequestPasswordResetState state) {
        if (state.submissionStatus.isInProgress) {
          AppLoader.show(context: context);
        }

        if (state.submissionStatus.isSuccess) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message ?? "", isError: false);

          context.pushReplacementNamed(RoutePath.signIn.name);
        }

        if (state.submissionStatus.isFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message ?? "Erreur");
        }
      },
      builder: (context, state) {
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

                AppEmailField(
                  hintText: "Email",
                  labelText: "Email",
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => context.read<RequestPasswordResetBloc>().add(RequestPasswordResetEmailChanged(value.trim())),
                ),

                AuthText(),

                AppBtnValidate(
                  label: 'Enregister',
                  enabled: state.canSubmit,
                  backgroundColor: AppColor.primaryColor,
                  onPress: () => context.read<RequestPasswordResetBloc>().add(RequestPasswordResetSubmitted()),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}



