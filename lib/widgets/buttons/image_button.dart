import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageButton extends StatefulWidget {
  ImageButton(this.image, this.title,this.onPressed);
  AssetImage image;
  String title;
  void Function() onPressed;

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton>
    with TickerProviderStateMixin {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isHovering ? 220 : 200,
          height: _isHovering ? 320 : 300,
          decoration: BoxDecoration(image: DecorationImage(image: widget.image,fit:BoxFit.cover)),
          child: TextButton(
            onHover: (isHovered) => setState(() {
              _isHovering = isHovered;
            }),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    const ContinuousRectangleBorder()),
                overlayColor: MaterialStateProperty.all(const Color.fromARGB(0, 0, 0, 0)),
                    ),
            onPressed: widget.onPressed,
            child: const Text(''),
          ),
        ),
        const SizedBox(height: 10,),
        Text(widget.title,style: Theme.of(context).textTheme.bodyMedium,),
      ],
    );
  }
}
