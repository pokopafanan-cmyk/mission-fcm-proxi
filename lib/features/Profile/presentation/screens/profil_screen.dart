import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/authentication/bloc/auth_bloc.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/config/enums.dart';
import '../../../../core/shared/widgets/buttons/app_text_button.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/theme/app_color.dart';
import '../bloc/users/users_bloc.dart';
import '../widgets/logout_dialog.dart';


class ProfilScreen extends StatefulWidget {

  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(UsersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(text: "Profil"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showLogoutDialog(context,);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: "Login: ${state.user.login}"),
                      AppText(text: "Nom: ${state.user.nom}"),
                      AppText(text: "Prénoms: ${state.user.prenoms}"),
                      AppText(text: "Mobile: ${state.user.displayMobile}"),
                      AppText(text: "Email: ${state.user.email}"),

                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextButton(
                              text: 'Edit Infos',
                              backgroundColor: AppColor.gradient1,
                              textColor: Colors.white,
                              onPress: () => context.pushNamed(RoutePath.updateUser.name),
                            ),
                          ),
                          const SizedBox(width: 30,),
                          Expanded(
                            child: AppTextButton(
                              text: 'Edit Password',
                              backgroundColor: AppColor.gradient1,
                              textColor: Colors.white,
                              onPress: () => context.pushNamed(RoutePath.changePassword.name),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 15,),
            BlocBuilder<UsersBloc, UsersState>(
              builder: (context, UsersState state) {
                if (state.status == Status.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.status == Status.failure) {
                  return Center(
                    child: AppText(text: "${state.message}"),
                  );
                }

                if (state.status == Status.success) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.users.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(height: 0.0, color: Colors.deepOrange,);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final user = state.users[index];
                        return ListTile(
                          title: AppText(
                            text: "${user.nom} ${user.prenoms}",
                            color: Colors.black,
                          ),
                          subtitle: AppText(
                            text: user.email,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                          trailing: AppText(
                            text: user.displayMobile,
                            fontSize: 12, color: Colors.black,
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}



