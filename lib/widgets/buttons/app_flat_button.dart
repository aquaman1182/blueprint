import 'package:blueprint/config/app_color.dart';
import 'package:flutter/material.dart';

class AppFlatButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color color;
  final Color? disabledColor;
  final Color textColor;
  final void Function()? onPressed;
  final EdgeInsets? padding;
  final double radius;
  final bool dense;
  AppFlatButton({
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.color = AppColor.background,
    this.disabledColor,
    this.textColor = Colors.white,
    this.padding,
    this.radius = 40,
    this.dense = false,
  });

  Color getTextColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled,
    };

    if (states.any(interactiveStates.contains)) {
      return textColor.withAlpha(400);
    }
    return textColor;
  }

  Color getBackgroundColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.disabled,
    };

    if (states.any(interactiveStates.contains)) {
      return disabledColor ?? color.withAlpha(400);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextButton(
        child: this.child,
        onPressed: this.onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(padding ??
              EdgeInsets.symmetric(vertical: dense ? 10 : 16, horizontal: 12)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          )),
          foregroundColor: MaterialStateProperty.resolveWith(getTextColor),
          backgroundColor:
              MaterialStateProperty.resolveWith(getBackgroundColor),
          overlayColor: MaterialStateProperty.resolveWith(
              (states) => Colors.white.withOpacity(0.1)),
        ),
      ),
    );
  }
}
