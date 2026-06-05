
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_path.dart';
import '../../../../core/config/app_sizes.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/shared/widgets/common/screen_title.dart';
import '../../../../core/shared/widgets/textfields/app_textfield.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../generated/assets.dart';
import '../widgets/dotted_line.dart';

class CreateAppointments extends StatefulWidget {
  const CreateAppointments({super.key});

  @override
  State<CreateAppointments> createState() => _CreateAppointmentsState();
}

class _CreateAppointmentsState extends State<CreateAppointments> {
  late TextEditingController _patientNameController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _patientNameController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: 'Create Appointment',
      ),
      body: Center(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.all(AppSize.screenPadding),
          shrinkWrap: true,
          children: [
            Row(
              children: [
                const Column(
                  children: [
                    AppText(text: "17", color: AppColor.blackColor, fontWeight: FontWeight.bold),
                    AppText(text: "OCT", fontWeight: FontWeight.bold, color: Colors.grey),
                  ],
                ),
                const SizedBox(width: 20),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green[50],
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(Assets.images.avarta.path),
                  ),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Dr. Abraham Pigeon", color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                    AppText(text: "Physical Therapy", fontSize: 14, color: Colors.grey),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            ScreenTitle(
              title: "Détails du rendez-vous",
              subtitle: "Veuillez remplir les informations ci-dessous",
            ),

            const SizedBox(height: 20),

            AppTextField(
              hintText: "Patient Name",
              labelText: "Nom du Patient",
              controller: _patientNameController,
              textCapitalization: TextCapitalization.characters,
              onChanged: (value) {},
            ),

            AppTextField(
              hintText: "Start time",
              labelText: "Heure de début",
              controller: _startTimeController,
              readOnly: true,
              onTap: () => _selectTime(context, _startTimeController),
              onChanged: (value) {},
            ),

            AppTextField(
              hintText: "End time",
              labelText: "Heure de fin",
              controller: _endTimeController,
              readOnly: true,
              onTap: () => _selectTime(context, _endTimeController),
              onChanged: (value) {},
            ),

            AppTextField(
              hintText: "Description",
              labelText: "Description",
              controller: _descriptionController,
              maxLines: 3,
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            _rowText("Duration", "1h 5min"),
            const SizedBox(height: 12),
            _rowText("Total Bill", "30 000f"),

            const SizedBox(height: 30),

            AppBtnValidate(
              label: 'Sauvegarder',
              enabled: true,
              backgroundColor: AppColor.primaryColor,
              onPress: () {
                context.pushNamed(RoutePath.maKing.name);
              },
            ),

            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  Widget _rowText(String title, String subtitle) {
    return Row(
      children: [
        AppText(text: title, fontWeight: FontWeight.bold),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: 1,
            child: CustomPaint(
              painter: DottedLinePainter(color: Colors.grey),
            ),
          ),
        ),
        AppText(text: subtitle, color: Colors.grey, fontWeight: FontWeight.bold),
      ],
    );
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }
}