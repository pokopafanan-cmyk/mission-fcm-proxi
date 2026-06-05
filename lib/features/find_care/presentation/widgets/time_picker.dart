import 'package:flutter/material.dart';

class TimeWheelPicker extends StatelessWidget {
  final FixedExtentScrollController controller;
  final List<int> items;
  final int selectedItem;
  final Function(int) onSelectedItemChanged;

  const TimeWheelPicker({
    super.key,
    required this.controller,
    required this.items,
    required this.selectedItem,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) => onSelectedItemChanged(items[index % items.length]),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: items.map((val) {
            final isSelected = val == selectedItem;
            return Center(
              child: Text(
                val.toString().padLeft(2, '0'),
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
    );
  }
}