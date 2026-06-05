
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../doctors/presentation/screen/doctors_section_screen.dart';
import '../../../medical_specialty/presentation/screen/specialty_grid_section_screen.dart';
import '../../../medical_specialty/presentation/widgets/home_hero_seach.dart';
import '../../../medical_specialty/presentation/widgets/user_header.dart';
import '../widgets/section_header.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.screenPadding),
              child: const HomeUserHeader(),
            ),

            Expanded(
              child: CustomScrollView(
                slivers: [

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.screenPadding),
                    sliver: const SliverToBoxAdapter(
                      child: HomeHeroSearch(),
                    ),
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.screenPadding,
                    ).copyWith(top: 8, bottom: 12),
                    sliver: const SliverToBoxAdapter(
                      child: SectionHeader(title: "Spécialités"),
                    ),
                  ),

                  const SpecialtyGridSection(),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.screenPadding),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 18),
                        child: SectionHeader(
                          title: "Top Doctors",
                          onActionTap: () => context.pushNamed(RoutePath.fineCare.name),
                        ),
                      ),
                    ),
                  ),

                  const DoctorsSectionScreen(),

                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}