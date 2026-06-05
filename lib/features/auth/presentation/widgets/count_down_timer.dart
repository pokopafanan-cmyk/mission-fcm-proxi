import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../core/di/init_dependencies.dart";
import "../../../../core/shared/widgets/buttons/app_action_button.dart";
import "../../../../core/shared/widgets/common/app_text.dart";
import "../../../../core/theme/app_color.dart";
import "../../../../core/utils/app_utils.dart";
import "../bloc/timer/timer_bloc.dart";


class CountDownTimer extends StatelessWidget {

  final VoidCallback onPressed;
  final double paddingBottom;

  const CountDownTimer({
    super.key,
    required this.onPressed,
    this.paddingBottom = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if(state is TimerRunComplete) {
            return Center(
              child: AppActionButton(
                paddingBottom: 0,
                title: 'Renvoyer le code',
                icon: Icons.refresh_rounded,
                onTap: onPressed,
              ),
            );
          }
          else if(state is TimerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_alarms_sharp, color: AppColor.secondaryColor,),
                SizedBox(width: 8,),
                AppText(
                  fontSize: 14,
                  text: "Prochain code dans ${sl<AppUtils>().formatHHMMSS(state.duration)}",
                  // color: AppColor.primaryColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}




