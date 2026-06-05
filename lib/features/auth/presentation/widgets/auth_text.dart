import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/shared/widgets/common/app_text.dart';

class AuthText extends StatelessWidget {

  const AuthText({
    super.key,
    this.signup = true,
  });

  final bool signup;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () async {
          if(signup) {
            context.goNamed(RoutePath.signIn.name);
          } else {
            context.goNamed(RoutePath.signUp.name);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppText(
                text: signup ? "Vous avez déja un compte ?" : "Vous n'avez pas de compte ?",
              ),
              const SizedBox(height: 3,),
              AppText(
                fontSize: 16,
                text: signup ? "Connectez-vous" : "Inscrivez-vous",
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
