import 'package:blueprint/config/app_color.dart';
import 'package:blueprint/widgets/buttons/app_border_button.dart';
import 'package:blueprint/widgets/buttons/app_flat_button.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  Flat,
  Border,
}

class AppButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  final double? width;
  final double? height;
  final void Function()? onPressed;
  final AppButtonType type;
  final EdgeInsets? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool dense;
  final double radius;
  AppButton({
    this.onPressed,
    this.text,
    this.color = AppColor.primary,
    this.textColor = Colors.white,
    this.icon,
    this.width,
    this.height,
    this.type = AppButtonType.Flat,
    this.padding,
    this.fontSize = 16,
    this.fontWeight,
    this.dense = false,
    this.radius = 40,
  });

  Color get _color {
    return color ?? AppColor.primary;
  }

  Color get _textColor {
    return textColor ??
        (type == AppButtonType.Flat ? AppColor.onPrimary : AppColor.primary);
  }

  Widget buildChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (this.icon != null) this.icon!,
        if (this.icon != null && this.text != null) const SizedBox(width: 12),
        if (this.text != null)
          Text(
            this.text!,
            style: TextStyle(
              color: _textColor,
              fontSize: fontSize ?? (dense ? 12 : 14),
              fontWeight: this.fontWeight ?? FontWeight.bold,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.type == AppButtonType.Flat)
      return AppFlatButton(
        width: this.width,
        height: this.height,
        child: buildChild(),
        color: _color,
        textColor: _textColor,
        onPressed: this.onPressed,
        padding: this.padding,
        dense: dense,
        radius: radius,
      );

    if (this.type == AppButtonType.Border)
      return AppBorderButton(
        width: this.width,
        height: this.height,
        child: buildChild(),
        color: _color,
        textColor: _textColor,
        onPressed: this.onPressed,
        padding: this.padding,
        dense: dense,
        radius: radius,
      );
    return Container();
  }
}
