import 'package:flutter/services.dart';
import 'dart:math';

///  pattern_formatter: ^4.0.1

///
/// An abstract class extends from [TextInputFormatter] and does numeric filter.
/// It has an abstract method `_format()` that lets its children override it to
/// format input displayed on [TextField]
///
abstract class NumberInputFormatter extends TextInputFormatter {
  TextEditingValue? _lastNewValue;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    /// nothing changes, nothing to do
    if (newValue.text == _lastNewValue?.text) {
      return newValue;
    }
    _lastNewValue = newValue;

    /// remove all invalid characters
    newValue = _formatValue(oldValue, newValue);

    /// current selection
    int selectionIndex = newValue.selection.end;

    /// format original string, this step would add some separator
    /// characters to original string
    final newText = _formatPattern(newValue.text);

    /// count number of inserted character in new string
    int insertCount = 0;

    /// count number of original input character in new string
    int inputCount = 0;
    for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (_isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    /// adjust selection according to number of inserted characters staying before
    /// selection
    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    /// if selection is right after an inserted character, it should be moved
    /// backward, this adjustment prevents an issue that user cannot delete
    /// characters when cursor stands right after inserted characters
    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !_isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: selectionIndex),
        composing: TextRange.empty
    );
  }

  /// check character from user input or being inserted by pattern formatter
  bool _isUserInput(String s);

  /// format user input with pattern formatter
  String _formatPattern(String digits);

  /// validate user input
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue);
}


class MoneyInputFormatter extends NumberInputFormatter {

  static final RegExp _digitOnlyRegex = RegExp(r'\d+');
  static final FilteringTextInputFormatter _digitOnlyFormatter = FilteringTextInputFormatter.allow(_digitOnlyRegex);

  final String separator;

  MoneyInputFormatter({this.separator = ' '});

  @override
  String _formatPattern(String digits) {
    if (digits.isEmpty) return '';

    StringBuffer buffer = StringBuffer();
    int index = 0;

    // Formatage avec séparateurs tous les 3 chiffres en partant de la fin
    for (int i = digits.length - 1; i >= 0; i--) {
      if (index > 0 && index % 3 == 0) {
        buffer.write(separator);
      }
      buffer.write(digits[i]);
      index++;
    }

    // Inverser le résultat vehicle on a construit à l'envers
    String result = buffer.toString().split('').reversed.join('');
    return result;
  }

  @override
  TextEditingValue _formatValue(TextEditingValue oldValue, TextEditingValue newValue) {
    return _digitOnlyFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool _isUserInput(String s) {
    return _digitOnlyRegex.firstMatch(s) != null;
  }
}
