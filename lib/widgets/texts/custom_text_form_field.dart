import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/theme/provider/theme_provider.dart';

class AppTextFiled extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final bool isRequired;
  final String? countryCode;
  final String? flagEmoji;
  final void Function(Country)? onCountryChanged;

  final int? maxLength;
  final bool showCounter;
  const AppTextFiled({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.isRequired = false,
    this.countryCode,
    this.flagEmoji,
    this.onCountryChanged,
    this.maxLength,
    this.showCounter = false
  });

  @override
  State<AppTextFiled> createState() => _AppTextFiledState();
}

class _AppTextFiledState extends State<AppTextFiled> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }



  @override
  Widget build(BuildContext context) {

    // final dark = HelperFunction.isDarkMode(context);
    final dark = context.watch<ThemeProvider>().isDarkMode;


    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType??(widget.maxLines > 1 ? TextInputType.multiline : TextInputType.text),
      obscureText: _obscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.maxLines > 1 ? TextInputAction.newline: TextInputAction.next,
      autocorrect: false,
      enableSuggestions: !widget.obscureText,
      minLines: widget.maxLines,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      maxLength: widget.maxLength,
      buildCounter: widget.showCounter
             ? (context, {required currentLength, required maxLength, required isFocused}){
        return Text(
          "$currentLength / $maxLength",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        );
      }
      : null,
      decoration: InputDecoration(
        label:  RichText(
          text: TextSpan(
            text: widget.label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            children: widget.isRequired
                ? [
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]
                : [],
          ),
        ),
        hintText: widget.hint,
          prefixIcon: (widget.countryCode != null && widget.flagEmoji != null)
              ? GestureDetector(
            onTap: (){
              showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  countryListTheme: CountryListThemeData(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    bottomSheetHeight: 500,
                    textStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                      ),
                      prefixIconColor: Theme.of(context).iconTheme.color,
                      filled: true,
                      fillColor: dark ? Colors.grey.shade900 : Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onSelect: (Country country){
                    if(widget.onCountryChanged != null){
                      widget.onCountryChanged!(country);
                    }
                  }
                  );
            },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  margin: const EdgeInsets.only(left: 8, right: 4, top: 15, bottom: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: dark ? Colors.grey.shade700 : Colors.grey.shade400 ),
                    borderRadius: BorderRadius.circular(8),
                    color: dark ? AppColors.darkGrey : AppColors.lightGrey,
                  ),
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.flagEmoji!, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 6),
                  Text(
                    widget.countryCode!,
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                   Icon(Icons.arrow_drop_down, size: 18,
                    color:Theme.of(context).iconTheme.color ,),
                ],
                            ),
                          ),
              )
              : widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText
            ?IconButton(
                onPressed: (){
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                icon: Icon(
                  _obscure
                  ? FontAwesomeIcons.eyeSlash
                      : FontAwesomeIcons.eye,
                  size: 18,
                )
            )
              : null),
      ),
    );
  }
}
