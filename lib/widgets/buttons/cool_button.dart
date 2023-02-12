import 'package:flutter/material.dart';

class CoolButton extends StatefulWidget {
  final String text;
  final Color primaryColor;
  final Color hoverColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final double? opacity;
  final void Function() onPressed;

  CoolButton(this.text, {required this.primaryColor,required this.hoverColor,required this.onPressed,this.textStyle,this.height,this.width,this.opacity});

  @override
  State<CoolButton> createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton> with TickerProviderStateMixin{
  late Color _currentColor;
  late Color _currentTextColor;
  

  @override
  void initState() {
    _currentColor = widget.primaryColor;
    _currentTextColor = Colors.white;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.opacity == null ? 1 : widget.opacity!,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(color: _currentColor,borderRadius: BorderRadius.circular(50)),
        width: widget.width,
        height: widget.height,
        child: TextButton(
          style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
          onPressed: widget.onPressed,
          onHover: (didHover) {
            didHover
                ? _currentColor = widget.hoverColor
                : _currentColor = widget.primaryColor;
            didHover
                ? _currentTextColor = Colors.black
                : _currentTextColor = Colors.white;
            setState(() {});
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Text(
                widget.text,
                style: widget.textStyle == null ? TextStyle(color: _currentTextColor) : widget.textStyle!.copyWith(color: _currentTextColor),
              )),
        ),
      ),
    );
  }
}