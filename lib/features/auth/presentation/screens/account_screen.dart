import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/screen_title.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../generated/assets.dart';

class AccountScreen extends StatefulWidget {

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.all(AppSize.screenPadding),
          shrinkWrap: true,
          children: [
            // Image.asset(Assets.logoLogo, height: 120,),
            Image.asset(Assets.logo.logo.path, height: 120),
            SizedBox(height: 40,),
            ScreenTitle(
                title: "Trouver le meilleur spécialiste",
                subtitle: "Traitement par les meilleurs spécialistes du monde entier "
            ),

            AppBtnValidate(
              enabled: true,
              label: 'Sign In',
              onPress: () {
                context.pushNamed(RoutePath.signIn.name);
              },

              backgroundColor: AppColor.primaryColor,
            ),

            SizedBox(height: 10,),

            AppBtnValidate(
              enabled: true,
              label: 'Sign Up',
              textColor: AppColor.primaryColor,
              onPress: () {
                context.pushNamed(RoutePath.signUp.name);
              },
              backgroundColor: AppColor.whiteColor,
              border: Border.all(color: AppColor.primaryColor),
            ),


          ],
        ),
      ),
    );
  }
}


