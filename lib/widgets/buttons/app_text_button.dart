import 'package:flutter/material.dart';

class AppTextButton extends StatefulWidget {
  AppTextButton({
    this.onPressed,
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.padding,
    this.minimumSize,
    this.visualDensity,
    this.tapTargetSize, required this.color,
  });
  final Function? onPressed;
  final String text;
  final Color color;
  final double? fontSize;
  final FontWeight fontWeight;
  final EdgeInsets? padding;
  final Size? minimumSize;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? tapTargetSize;

  @override
  AppTextButtonState createState() => AppTextButtonState();
}

class AppTextButtonState extends State<AppTextButton> {
  bool _loading = false;

  _handlePressed() async {
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

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _loading || widget.onPressed == null ? null : _handlePressed,
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => widget.color.withOpacity(0.2)),
        padding: widget.padding != null
            ? MaterialStateProperty.all<EdgeInsets>(widget.padding!)
            : null,
        minimumSize: widget.minimumSize != null
            ? MaterialStateProperty.all<Size>(widget.minimumSize!)
            : null,
        visualDensity: widget.visualDensity,
        tapTargetSize: widget.tapTargetSize,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontWeight: widget.fontWeight,
          fontSize: widget.fontSize,
          color: _loading || widget.onPressed == null
              ? widget.color.withOpacity(0.6)
              : widget.color,
        ),
      ),
    );
  }
}
