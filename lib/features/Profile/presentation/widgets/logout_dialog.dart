import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../core/config/enums.dart';
import '../../../../core/shared/widgets/buttons/app_dialog_button.dart';
import '../../../../core/shared/widgets/common/app_loader.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_dialog.dart';
import '../../../../core/shared/widgets/common/show_app_dialog.dart';
import '../../../../core/utils/show_message.dart';


class LogoutDialog extends StatelessWidget {

  const LogoutDialog({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggingOut) {
          AppLoader.show(context: context, message: state.message,);
        }

        if (state is AuthUnauthenticated) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message, isError: false);
        }

        if (state is AuthFailure) {
          AppLoader.hide(context);
          AppMessage.showToast(msg: state.message);
        }
      },
      child: CustomDialog(
        addDivider: false,
        title: 'Déconnexion',
        buttonMargin: true,
        button: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            AppDialogButton(
              enabled: true,
              text: "Non",
              onTap: () => Navigator.of(context).pop(),
            ),
            AppDialogButton(
              enabled: true,
              text: "Oui",
              onTap: () => context.read<AuthBloc>().add(AuthUserLogout(LogoutReason.userInitiated)),
            ),
          ],
        ),
        children: [
          SizedBox(height: 30,),
          Center(
            child: AppText(
              textAlign: TextAlign.center,
              fontSize: 14,
              color: Colors.black,
              text: 'Voulez-vous vraiment vous déconnecter ?',
            ),
          ),
          // SizedBox(height: 15,),
        ],
      ),
    );
  }
}


Future<void> showLogoutDialog(BuildContext context,) async {
  return await showAppDialog<void>(
    context: context,
    barrierDismissible: false,
    child: LogoutDialog(),
  );
}


