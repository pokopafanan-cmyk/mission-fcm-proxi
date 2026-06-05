import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/common/app_text.dart';
class MyRadio extends StatelessWidget {

  final String label;
  final String value;
  final String groupValue;
  final Color backgroundColor;
  final Function(String?) onChanged;
  final FontWeight fontWeight;
  final double radius;
  final double fontSize;
  final Color color;

  const MyRadio({
    super.key,
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.groupValue,
    required this.onChanged,
    this.fontWeight = FontWeight.w700,
    this.color = Colors.black,
    this.fontSize = 16,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(radius),
        child: Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Transform.scale(
                scale: 1.1,
                child: Theme(
                  data: Theme.of(context).copyWith(unselectedWidgetColor: Theme.of(context).primaryColor,),
                  child: Radio<String>(
                    value: value,
                    groupValue: groupValue,
                    onChanged: (newValue) => onChanged(newValue),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 12,),
              Flexible(
                child: AppText(
                  text: label,
                  fontSize: fontSize,
                  color: color,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
