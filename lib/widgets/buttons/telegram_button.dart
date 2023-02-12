import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelegramButton extends StatefulWidget {
  final String url;
  final String name;
  bool isShortened;
  IconData? icon;
  Color color;
  TelegramButton(this.url, {required this.name,this.isShortened = false,this.icon,this.color = Colors.black});

  @override
  State<TelegramButton> createState() => _TelegramButtonState();
}

class _TelegramButtonState extends State<TelegramButton> with TickerProviderStateMixin{
  bool _isHovered = false;
  late AnimationController animationController;
  late Animation<double> animation;


  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 300),vsync: this);
    animation = Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));   
    Future.delayed(const Duration(milliseconds: 100)).whenComplete(() => animationController.forward());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.isShortened ? (_isHovered ? 44 : 40) :(_isHovered ? 176 : 160),
      height: _isHovered ? 44 : 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: widget.color,
      ),
      child: TextButton(
        onHover: (value) => setState(() {_isHovered = value;}),
        onPressed: () => launchUrl(Uri.parse(widget.url)),
        child: Row(
          children: [
            Icon(widget.icon ?? (_isHovered ? Icons.arrow_forward : Icons.telegram)),
            if (!widget.isShortened) Expanded(
                child: FadeTransition(
                  opacity: animation,
                  child: Text(
                              widget.name,
                              style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                )),
          ],
        ),
      ),
    );
  }
}
