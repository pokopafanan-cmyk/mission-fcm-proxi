import "package:flutter/material.dart";
import "package:mask_text_input_formatter/mask_text_input_formatter.dart";
import "../../../theme/app_color.dart";
import '../../../theme/app_theme.dart';
import "countries.dart";
import "intl_phone_field.dart";
import "phone_number.dart";


/// Règles de numérotation par indicatif pays.
/// La clé correspond à l’indicatif sans le "+" (ex: "225").

class PhoneRules {

  final int maxLength;
  final bool Function(String number) validator;
  final MaskTextInputFormatter mask;
  final String hint;

  const PhoneRules({
    required this.maxLength,
    required this.validator,
    required this.mask,
    required this.hint,
  });
}

final Map<String, PhoneRules> phoneRules = {

  // Côte d'Ivoire
  "225": PhoneRules(
    maxLength: 10,
    hint: "00 00 00 00 00",
    mask: MaskTextInputFormatter(
      mask: "## ## ## ## ##",
      filter: {"#": RegExp(r"[0-9]")},
    ),
    validator: (number) =>
    number.length == 10 &&
        (number.startsWith("01") ||
            number.startsWith("05") ||
            number.startsWith("07")),
  ),

  // Mali, Burkina, Togo, Bénin (8 chiffres)
  "223": PhoneRules(
    maxLength: 8,
    hint: "00 00 00 00",
    mask: MaskTextInputFormatter(
      mask: "## ## ## ##",
      filter: {"#": RegExp(r"[0-9]")},
    ),
    validator: (number) => number.length == 8,
  ),
  "226": PhoneRules(
    maxLength: 8,
    hint: "00 00 00 00",
    mask: MaskTextInputFormatter(
      mask: "## ## ## ##",
      filter: {"#": RegExp(r"[0-9]")},
    ),
    validator: (number) => number.length == 8,
  ),
  "228": PhoneRules(
    maxLength: 8,
    hint: "00 00 00 00",
    mask: MaskTextInputFormatter(
      mask: "## ## ## ##",
      filter: {"#": RegExp(r"[0-9]")},
    ),
    validator: (number) => number.length == 8,
  ),
  "229": PhoneRules(
    maxLength: 8,
    hint: "00 00 00 00",
    mask: MaskTextInputFormatter(
      mask: "## ## ## ##",
      filter: {"#": RegExp(r"[0-9]")},
    ),
    validator: (number) => number.length == 8,
  ),

  // Guinée : 8 ou 9
  "224": PhoneRules(
    maxLength: 9,
    hint: "00 00 00 000",
    mask: MaskTextInputFormatter(
      mask: "## ## ## ###",
      filter: {"#": RegExp(r"[0-9]")},
    ),
    validator: (number) => number.length == 8 || number.length == 9,
  ),
};



class AppIntlPhoneField extends StatefulWidget {

  final String hintText;
  final String? labelText;
  final bool enabled;
  final bool showDropdownIcon;
  final bool disableLengthCheck;
  final String? initialValue;
  final String initialCountryCode;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<Country>? onCountryChanged;
  final List<Country> countries;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FocusNode? focusNode;

  const AppIntlPhoneField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.onCountryChanged,
    required this.countries,
    this.initialValue,
    this.labelText,
    this.initialCountryCode = "CI",
    this.textInputAction = TextInputAction.next,
    this.floatingLabelBehavior,
    this.enabled = true,
    this.showDropdownIcon = true,
    this.disableLengthCheck = true,
    this.focusNode,
  });

  @override
  State<AppIntlPhoneField> createState() => _AppIntlPhoneFieldState();
}

class _AppIntlPhoneFieldState extends State<AppIntlPhoneField> {

  late String countryDial;
  late MaskTextInputFormatter currentMask;
  late String currentHint;

  @override
  void initState() {
    super.initState();
    countryDial = _dialFromIso(widget.initialCountryCode);
    final rules = phoneRules[countryDial]!;

    currentMask = rules.mask;
    currentHint = rules.hint;
  }



  /// Récupère l’indicatif téléphonique à partir du code ISO du pays (ex: "CI" → "225")
  String _dialFromIso(String iso) {
    final lower = iso.toLowerCase();

    final found = widget.countries.firstWhere(
          (c) => c.code.toLowerCase() == lower,
      orElse: () =>
          widget.countries.firstWhere((c) => c.code.toLowerCase() == "ci",
              orElse: () => widget.countries.first),
    );

    return found.dialCode.replaceAll("+", "");
  }

  /// Vérifie la validité du numéro saisi en fonction des règles du pays courant
  bool _isValid() {
    final number = widget.controller.text.replaceAll(" ", "");
    return phoneRules[countryDial]?.validator(number) ?? false;
  }

  // Méthode utilitaire pour créer un style de bordure
  OutlineInputBorder _border({Color? color, double? width}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color ?? AppColor.gradient2, width: width ?? 1.0),
  );

  /// Met à jour les règles, le masque et le hint lorsque l’utilisateur change de pays
  void _updateCountry(Country country) {
    setState(() {
      countryDial = country.dialCode.replaceAll("+", "");
      final rules = phoneRules[countryDial] ?? phoneRules["225"]!;
      currentMask = rules.mask;
      currentHint = rules.hint;
      widget.controller.clear();
    });

    widget.onCountryChanged?.call(country);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.controller,
      builder: (_, __, ___) {

        final isValid = _isValid();
        final dynamicColor = Theme.of(context).primaryColor.withValues(alpha: isValid ? 1.0 : 0.3);
        final borderWidth = isValid ? 1.5 : 1.0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: IntlPhoneField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            countries: widget.countries,
            initialValue: widget.initialValue,
            initialCountryCode: widget.initialCountryCode,
            enabled: widget.enabled,
            disableLengthCheck: widget.disableLengthCheck,
            showDropdownIcon: widget.showDropdownIcon,
            dropdownIconPosition: IconPosition.trailing,
            inputFormatters: [currentMask],
            searchText: "Recherche",
            decoration: InputDecoration(
              hintText: currentHint,
              labelText: widget.labelText,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              errorStyle: const TextStyle(height: 0.01),
              enabledBorder: _border(color: isValid ? dynamicColor : AppColor.gradient2, width: borderWidth,),
              focusedBorder: _border(color: dynamicColor, width: 1.5,),
              focusedErrorBorder: _border(color: dynamicColor, width: 1.5,),
              errorBorder: _border(),
            ),
            onCountryChanged: _updateCountry,
            onChanged: widget.onChanged,
          ),
        );
      },
    );
  }
}

