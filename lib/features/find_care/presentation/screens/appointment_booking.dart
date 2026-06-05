
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../app/router/route_path.dart';
import '../../../../core/shared/widgets/buttons/app_btn_validate.dart';
import '../../../../core/shared/widgets/common/app_text.dart';
import '../../../../core/shared/widgets/common/custom_app_bar.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../generated/assets.dart';


class AppointmentBooking extends StatefulWidget {
  const AppointmentBooking({super.key});

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  DateTime selectedDate = DateTime(2025, 11, 17);
  DateTime focusedDate = DateTime(2025, 11, 1);
  final FixedExtentScrollController _hourController = FixedExtentScrollController();
  final FixedExtentScrollController _minuteController = FixedExtentScrollController();

  int selectedHour = 0;
  int selectedMinute = 0;

  final List<int> hours = List.generate(24, (i) => i);
  final List<int> minutes = List.generate(12, (i) => i * 5);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hourController.jumpToItem(hours.indexOf(selectedHour));
      _minuteController.jumpToItem(minutes.indexOf(selectedMinute));
    });
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Book Appointment'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TableCalendar(
                firstDay: DateTime(2020, 1, 1),
                lastDay: DateTime(2030, 12, 31),
                focusedDay: focusedDate,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: CalendarFormat.month,
                availableGestures: AvailableGestures.horizontalSwipe,
                rowHeight: 44,
                daysOfWeekHeight: 24,

                selectedDayPredicate: (d) => isSameDay(selectedDate, d),
                onDaySelected: (sel, foc) {
                  setState(() {
                    selectedDate = sel;
                    focusedDate = foc;
                  });
                },
                onPageChanged: (foc) => setState(() => focusedDate = foc),

                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  headerPadding: EdgeInsets.only(bottom: 8),
                ),

                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    final prev = DateTime(day.year, day.month - 1, 1);
                    final next = DateTime(day.year, day.month + 1, 1);
                    final month = DateFormat('MMMM').format(day);
                    final year = DateFormat('yyyy').format(day);

                    return Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat('MMMM yyyy').format(prev),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withValues(alpha: 0.25),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  text: month,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                                const SizedBox(width: 6),
                                AppText(
                                  text: year,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: AppText(
                              text:  DateFormat('MMMM yyyy').format(next),
                              fontSize: 14,
                              color: Colors.black.withValues(alpha: 0.25),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  dowBuilder: (context, day) {
                    final label = DateFormat.E().format(day).substring(0, 1).toUpperCase();
                    return Center(
                      child: AppText(text: label, fontWeight: FontWeight.w700, color: AppColor.primaryColor,),
                    );
                  },
                ),

                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(fontWeight: FontWeight.w700),
                  weekdayStyle: TextStyle(fontWeight: FontWeight.w700),
                ),

                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  outsideDaysVisible: true,
                  outsideTextStyle:
                  TextStyle(color: Colors.black.withValues(alpha: 0.25)),
                  defaultTextStyle: const TextStyle(fontSize: 16),
                  weekendTextStyle: const TextStyle(fontSize: 16),
                  selectedDecoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Column(
                    children: [
                      AppText(
                        text: DateFormat('d').format(selectedDate),
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      AppText(
                        text: DateFormat('MMM').format(selectedDate).toUpperCase(),
                        fontWeight: FontWeight.bold,
                        color: AppColor.greyColor,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: CircleAvatar(
                      radius: 25,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.green[50],
                          child: Image.asset(Assets.images.avarta.path),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      AppText(
                        text: "Dr.Abraham Pigeon",
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      AppText(
                        text: "Physical Therapy",
                        fontSize: 14,
                        color: AppColor.greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                height: 200,
                margin: const EdgeInsets.only(top: 20, bottom: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          child: ListWheelScrollView.useDelegate(
                            controller: _hourController,
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedHour = hours[index % hours.length];
                              });
                            },
                            childDelegate: ListWheelChildLoopingListDelegate(
                              children: hours.map((h) {
                                final isSelected = h == selectedHour;
                                return Center(
                                  child: AppText(
                                      text: h.toString().padLeft(2, '0'),
                                      fontSize: isSelected ? 22 : 18,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? Colors.blue : Colors.black,

                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        SizedBox(
                          width: 80,
                          child: ListWheelScrollView.useDelegate(
                            controller: _minuteController,
                            itemExtent: 50,
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedMinute = minutes[index % minutes.length];
                              });
                            },
                            childDelegate: ListWheelChildLoopingListDelegate(
                              children: minutes.map((m) {
                                final isSelected = m == selectedMinute;
                                return Center(
                                  child: Text(
                                    m.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      fontSize: isSelected ? 22 : 18,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? Colors.blue : Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              AppBtnValidate(
                enabled: true,
                label: 'Confirm Appointment',
                onPress: () {
                  context.pushNamed(RoutePath.createAppoint.name);
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


class TimeSlotButton extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotButton({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: AppText(
            text: time,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey[800],),
      ),
    );
  }
}