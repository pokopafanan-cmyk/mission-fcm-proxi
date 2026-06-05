import 'package:flutter/material.dart';
import 'helpers.dart';
import '../../../theme/app_color.dart';
import '../common/app_text.dart';
import 'countries.dart';

class PickerDialogStyle {

  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {

  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;
  final String languageCode;

  const CountryPickerDialog({
    super.key,
    required this.searchText,
    required this.languageCode,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries.toList()
      ..sort((a, b) => a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    // const defaultHorizontalPadding = 40.0;
    // const defaultVerticalPadding = 24.0;
    const defaultHorizontalPadding = 20.0;
    const defaultVerticalPadding = 45.0;
    double fontSize = 16;
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: defaultVerticalPadding, horizontal: mediaWidth > (width + defaultHorizontalPadding * 2) ? (mediaWidth - width) / 2 : defaultHorizontalPadding),
      backgroundColor: widget.style?.backgroundColor ?? const Color(0xFFE7E7E7),
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      // insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
      contentPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0),),
        side: const BorderSide(width: 2, color: AppColor.primaryColor),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        margin: const EdgeInsets.only(bottom: 0),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: AppColor.primaryColor, width: 1.5,)),
        ),
        child: const Center(child: AppText(text: "Rechercher un pays", fontSize: 14,)),
      ),
      scrollable: false,
      content: SizedBox(
        width: double.maxFinite,
        //padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DialogSearchTextField(
              hintText: widget.searchText,
              onChanged: (value) {
                _filteredCountries = widget.countryList.stringSearch(value)
                  ..sort((a, b) => a.localizedName(widget.languageCode).compareTo(b.localizedName(widget.languageCode)),);
                if (mounted) setState(() {});
              },
            ),
            const SizedBox(height: 20),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: _filteredCountries.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    Material(
                      color: const Color(0xFFE7E7E7),
                      child: InkWell(
                        onTap: () {
                          _selectedCountry = _filteredCountries[index];
                          widget.onCountryChanged(_selectedCountry);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.white, width: 1.5,),),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 35,
                                    height: 30,
                                    child: Image.asset(
                                      'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                                      width: 32,
                                    )
                                  ),
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: AppText(
                                      text: _filteredCountries[index].localizedName(widget.languageCode),
                                      //fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  AppText(
                                    text: '+${_filteredCountries[index].dialCode}',
                                    //fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogSearchTextField extends StatelessWidget {

  final String hintText;
  final ValueChanged<String>? onChanged;
  const DialogSearchTextField({super.key, required this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {

    const fontSize = 14.0;

    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      cursorColor: const Color(0xFF707070),
      decoration: InputDecoration(
        suffixIcon: Container(
          padding: const EdgeInsets.only(right: 8, top: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10),),
            border: Border(left: BorderSide(color: AppColor.primaryColor, width: 1.0,),),
          ),
          child: IconButton(
            onPressed: () {  },
            splashRadius: 18,
            iconSize: 30,
            splashColor: Colors.white,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.search_rounded, size: 30, color: AppColor.primaryColor),
          ),
        ),
        hintText: hintText,
        //labelText: "Nom",
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        labelStyle: const TextStyle(
          color: Color(0xFF707070),
          fontSize: fontSize,
          //fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF707070),
          fontSize: fontSize,
          //fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          //borderSide: const BorderSide(color: Color(0xFF707070),),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          //borderSide: const BorderSide(color: Colors.transparent,),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          // borderSide: const BorderSide(color: Colors.transparent,),
          borderSide: const BorderSide(color: AppColor.primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
