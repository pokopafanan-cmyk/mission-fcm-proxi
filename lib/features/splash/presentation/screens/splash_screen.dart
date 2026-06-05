import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../generated/assets.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // wait for 2 seconds to show splash screen
    // context.read<PinBloc>().add(const PinStatusRequested());
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted) {
        context.read<AuthBloc>().add(const AuthCheckStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                // child: Image.asset(
                //   Assets.logoControlUnion,
                //   height: 75,
                //   width: 75,
                // ),
                child: Assets.logo.controlUnion.image(
                  height: 75,
                  width: 75,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppText(
                text: "Bienvenue",
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


