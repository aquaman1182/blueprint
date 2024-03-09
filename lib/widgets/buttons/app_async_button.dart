import 'package:blueprint/widgets/buttons/app_border_button.dart';
import 'package:blueprint/widgets/buttons/app_flat_button.dart';
import 'package:flutter/material.dart';

enum AppAsyncButtonType {
  Flat,
  Border,
}

class AppAsyncButton extends StatefulWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? disabledColor;
  final Widget? icon;
  final double? width;
  final AppAsyncButtonType type;
  final Future<void> Function()? onPressed;
  final EdgeInsets? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool dense;
  final double radius;

  AppAsyncButton({
    this.onPressed,
    required this.text,
    this.color,
    this.textColor,
    this.disabledColor,
    this.icon,
    this.width,
    this.type = AppAsyncButtonType.Flat,
    this.padding,
    this.fontSize,
    this.fontWeight,
    this.dense = false,
    this.radius = 40,
  });

  @override
  _AppAsyncButtonState createState() => _AppAsyncButtonState();
}

class _AppAsyncButtonState extends State<AppAsyncButton> {
  bool _loading = false;

  Color get color {
    return widget.color ?? const Color(0xFF186B53);
  }

  Color get textColor {
    return widget.textColor ??
        (widget.type == AppAsyncButtonType.Flat
            ? Colors.white
            : Colors.white);
  }

  Future handlePress() async {
    setState(() {
      _loading = true;
    });

    try {
      await widget.onPressed!();
    } catch (e) {
      print(e);
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget buildChild() {
    if (this._loading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) widget.icon!,
        if (widget.icon != null) const SizedBox(width: 14),
        Text(
          widget.text,
          style: TextStyle(
            color: textColor,
            fontSize: widget.fontSize ?? (widget.dense ? 12 : 14),
            fontWeight: widget.fontWeight ?? FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == AppAsyncButtonType.Flat)
      return AppFlatButton(
        width: widget.width,
        child: buildChild(),
        color: color,
        textColor: textColor,
        disabledColor: widget.disabledColor,
        onPressed:
            _loading || widget.onPressed == null ? null : this.handlePress,
        padding: widget.padding,
        dense: widget.dense,
        radius: widget.radius,
      );

    if (widget.type == AppAsyncButtonType.Border)
      return AppBorderButton(
        width: widget.width,
        child: buildChild(),
        color: color,
        textColor: textColor,
        onPressed: _loading ? null : this.handlePress,
        padding: widget.padding,
        dense: widget.dense,
        radius: widget.radius,
      );

    return Container();
  }
}
