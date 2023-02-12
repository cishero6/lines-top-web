import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ReviewButton extends StatefulWidget {
  final title;
  final text;
  final double? width;
  final double? height;
  bool hasHoverColor;
  final void Function(void Function()) pageSetState;
  SizingInformation sizingInformation;
  ReviewButton(this.title, this.text, this.pageSetState, this.sizingInformation,
      {this.width, this.height, this.hasHoverColor = false});

  @override
  State<ReviewButton> createState() => _ReviewButtonState();
}

class _ReviewButtonState extends State<ReviewButton>
    with TickerProviderStateMixin {
  bool _isOpened = false;
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  _toggleContainer() {
    if (!_isOpened) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(const Color.fromARGB(0, 0, 0, 0))),
      onHover: (value) => setState(() {
        _isHovered = value;
      }),
      onPressed: () {
        _toggleContainer();
        setState(() {
          _isOpened = !_isOpened;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: (widget.hasHoverColor)
                ? (widget.sizingInformation.isDesktop
                    ? ((_isHovered && !_isOpened)
                        ? const Color.fromARGB(25, 0, 0, 0)
                        : const Color.fromARGB(0, 0, 0, 0))
                    : (_isOpened)
                        ? const Color.fromARGB(0, 0, 0, 0)
                        : const Color.fromARGB(25, 0, 0, 0))
                : const Color.fromARGB(0, 0, 0, 0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: _isHovered
                      ? const Color.fromARGB(90, 0, 0, 0)
                      : const Color.fromARGB(0, 0, 0, 0),
                  child: Icon(
                    _isOpened ? Icons.close : Icons.add,
                  ),
                ),
              ],
            ),
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    widget.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
