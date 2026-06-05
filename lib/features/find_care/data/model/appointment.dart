

import 'package:proxi/features/find_care/data/model/section_model.dart';

class AppointmentData {
  static const List<Appointment> rend = [
    Appointment(
      id: "1",
      title: "Practice Organization",
      content: [
        SectionRowData(title: "Name for practice", value: "Physical Therapy"),
        SectionRowData(title: "Street 1", value: "Muldoon Rd, Anchorage"),
        SectionRowData(title: "City", value: "Anchorage"),
        SectionRowData(title: "State", value: "Atlantic Muldoon"),
        SectionRowData(title: "Zip or postal code", value: "46000"),
        SectionRowData(title: "Country", value: "United States of America"),
      ],
    ),
    Appointment(
      id: "2",
      title: "Education",
      content: [
        SectionRowData(title: "University", value: "Health Science University"),
      ],
    ),
    Appointment(
      id: "3",
      title: "Training",
      content: [
        SectionRowData(title: "Program", value: "Orthopedic Residency Program"),
      ],
    ),
    Appointment(
      id: "4",
      title: "Affiliation",
      content: [
        SectionRowData(title: "Member", value: "National PT Association"),
      ],
    ),
  ];
}