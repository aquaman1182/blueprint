import 'package:blueprint/config/app_color.dart';
import 'package:flutter/material.dart';

class AppBorderButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final double radius;
  final bool dense;

  AppBorderButton({
    required this.child,
    this.width,
    this.height,
    this.color = AppColor.primary,
    this.textColor = AppColor.primary,
    required this.onPressed,
    this.padding,
    this.radius = 40,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding ??
              EdgeInsets.symmetric(vertical: dense ? 10 : 16, horizontal: 12)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )),
          foregroundColor: MaterialStateProperty.all(textColor),
          overlayColor: MaterialStateProperty.all(textColor.withOpacity(0.1)),
          side: MaterialStateProperty.all(BorderSide(color: color)),
        ),
        child: this.child,
        onPressed: this.onPressed,
      ),
    );
  }
}
