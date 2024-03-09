import 'package:blueprint/config/app_color.dart';
import 'package:flutter/material.dart';

class AppTextForm extends StatefulWidget {
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final String? label;
  final TextStyle? textStyle;
  final String? hintText;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final bool? filled;
  final Color? fillColor;
  final Color? borderSide;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final bool? obscureText;
  final int? minLine;
  final int? maxLine;
  const AppTextForm({
    this.fieldKey,
    Key? key,
    this.label,
    this.textStyle,
    this.hintText = "",
    this.contentPadding,
    this.keyboardType,
    this.filled = true,
    this.fillColor,
    this.borderSide,
    this.controller,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.obscureText = false,
    this.minLine = 1,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppTextForm> {
  late Color? _labelColor;

  @override
  void initState() {
    super.initState();
    _labelColor = const Color(0xFF707974);
    widget.focusNode?.addListener(_updateLabelColor);
  }

  void _updateLabelColor() {
    if (widget.focusNode?.hasFocus ?? false) {
      setState(() {
        _labelColor = (widget.fieldKey?.currentState?.hasError ?? false)
                      ? AppColor.primary
                      : AppColor.onPrimary;
      });
    } else {
      setState(() {
        _labelColor = AppColor.background;
      });
    }
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_updateLabelColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: TextFormField(
        key: widget.fieldKey,
        obscureText: widget.obscureText ?? false,
        keyboardType: widget.keyboardType,
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _labelColor,
          ),
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(
              color: AppColor.primary,
              width: 1
            ),
          ),
          contentPadding: widget.contentPadding,
        ),
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: widget.controller,
        validator: widget.validator,
        onSaved: (value) => widget.onSaved!(value?.trim()),
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        autovalidateMode: widget.autovalidateMode,
        minLines: widget.minLine,
        maxLines: widget.maxLine,
      ),
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.fieldKey?.currentState?.validate();
        }
      },
    );
  }
}
