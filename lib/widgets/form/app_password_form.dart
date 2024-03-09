import 'package:blueprint/config/app_color.dart';
import 'package:flutter/material.dart';

class AppPasswordForm extends StatefulWidget {
  final GlobalKey<FormFieldState<String>>? fieldKey;
  final String? label;
  final TextStyle? textStyle;
  final String? hintText;
  final String? helperText;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;
  final AutovalidateMode autovalidateMode;
  AppPasswordForm({
    this.fieldKey,
    Key? key,
    this.label,
    this.textStyle,
    this.hintText,
    this.helperText,
    this.contentPadding,
    this.fillColor,
    this.controller,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.focusNode,
    this.autofocus = false,
    this.autovalidateMode = AutovalidateMode.disabled,
  }) : super(key: key);

  @override
  _AppPasswordFormState createState() => _AppPasswordFormState();
}

class _AppPasswordFormState extends State<AppPasswordForm> {
  bool _showPassword = false;
  late Color _labelColor;

  String? _validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'パスワードを入力してください';
    }
    if (value.length < 8) {
      return 'パスワードは8文字以上で入力してください';
    }

    String pattern = r'^[0-9a-zA-Z-!"#$%&()*,./:;?@[\]^_`{|}~+<=>]{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'パスワードは英数字または指定された記号のみを含めてください';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _labelColor = const Color(0xFF707974);
    widget.focusNode?.addListener(_updateLabelColor);
  }

  void _updateLabelColor() {
    if (widget.focusNode?.hasFocus ?? false) {
      setState(() {
        _labelColor = (widget.fieldKey?.currentState?.hasError ?? false) ? const Color(0xFFBA1A1A) : const Color(0xFF186B53);
      });
    } else {
      setState(() {
        _labelColor = const Color(0xFF707974);
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
        keyboardType: TextInputType.visiblePassword,
        obscureText: !this._showPassword,
        autovalidateMode: widget.autovalidateMode,
        autofocus: widget.autofocus,
        style: widget.textStyle,
        validator:
            widget.validator != null ? widget.validator : _validatePass,
        controller: widget.controller,
        cursorColor: AppColor.primary,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: _labelColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: const BorderSide(color: AppColor.primary),
          ),
          hintText: widget.hintText,
          helperText: widget.helperText,
          contentPadding: widget.contentPadding,
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                this._showPassword = !this._showPassword;
              });
            },
          ),
        ),
        onSaved: (value) => widget.onSaved!(value?.trim()),
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
      ),
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          widget.fieldKey?.currentState?.validate();
        }
      },
    );
  }
}
