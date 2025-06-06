import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/themes/theme.dart';

class FormInputField extends StatefulWidget {
  final String labelText;
  final FormFieldValidator<String>? fieldValidator;
  final bool password;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? initialValue;
  final int? maxLength;
  final double borderWidth;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final int minLines, maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool filled;
  final Color? fillColor;
  final bool readOnly;
  final VoidCallback? onTap;

  FormInputField({
    required this.labelText,
    this.fieldValidator,
    this.password = false,
    this.textInputType,
    this.textInputAction,
    this.controller,
    this.initialValue,
    this.maxLength,
    this.borderWidth = 3.0,
    this.enabled = true,
    this.onChanged,
    this.minLines = 1,
    this.maxLines = 1,
    this.suffix,
    this.onFieldSubmitted,
    this.focusNode,
    this.inputFormatters,
    this.filled = false,
    this.fillColor,
    this.prefix,
    this.readOnly = false,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  _FormInputFieldState createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText,
            style: TextStyle(
              color: AppColors.hintColor,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Theme.of(context).textSelectionTheme.selectionColor,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          minLines: widget.minLines,
          maxLines: !widget.password ? widget.maxLines : 1,
          validator: widget.fieldValidator,
          obscureText: widget.password && !_passwordVisible,
          maxLength: widget.maxLength,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          controller: widget.controller,
          initialValue: widget.initialValue,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            filled: widget.filled,
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon != null
                ? Container(
                    width: 20,
                    height: 20,
                    child: Center(
                      child: widget.prefixIcon,
                    ),
                  )
                : null,
            labelStyle: TextStyle(color: Color(0xFF7E8CA0)),
            suffixIcon: widget.password
                ? Opacity(
                    opacity: _passwordVisible ? 1 : 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Image(
                          image: AssetImage('assets/password.png'),
                          width: 25,
                          height: 25,
                        ),
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ))
                : widget.suffix,
            hintText:
                "${'enter'.tr} ${widget.labelText.toLowerCase().replaceAll("add", "").trim()}",
            errorStyle: TextStyle(
                color: Theme.of(context).colorScheme.error, fontSize: 12),
            prefix: widget.prefix,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: widget.borderWidth == 0
                    ? Colors.transparent
                    : Theme.of(context).primaryColor,
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: widget.prefixIcon == null ? 15 : 0, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: widget.borderWidth == 0
                    ? Colors.transparent
                    : AppColors.borderColor,
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: widget.borderWidth == 0
                    ? Colors.transparent
                    : AppColors.borderColor,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: widget.borderWidth == 0
                      ? Colors.transparent
                      : AppColors.borderColor,
                  width: 1.5),
            ),
          ),
          readOnly: widget.readOnly,
          onTap: widget.onTap,
        ),
      ],
    );
  }
}

extension CapExtension on String {
  String get capitalizeEachWord =>
      this.split(" ").map((str) => str.capitalize).join(" ");
}
