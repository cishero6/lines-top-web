
import 'package:flutter/material.dart';
import 'package:lines_top_web_project/providers/page_size_provider.dart';
import 'package:provider/provider.dart';
import '../../helpers/parallax_flow_delegate.dart';


class ParallaxImage extends StatefulWidget{
  ParallaxImage(this.image,this.scrollableKey);
  final AssetImage image;
  final GlobalKey scrollableKey;

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> with TickerProviderStateMixin{
  final GlobalKey<State<StatefulWidget>> _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var parContext = Provider.of<PageSizeProvider>(context).parallaxContext;

    if(widget.scrollableKey.currentContext == null){
      return const Center(child: CircularProgressIndicator(),);
    }    
    var height = Provider.of<PageSizeProvider>(context).height;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: height*2,
      child: Flow(
          delegate: ParallaxFlowDelegate(
            backgroundImageKey: _backgroundImageKey,
            listItemContext: parContext ?? context,
            scrollable: Scrollable.of(widget.scrollableKey.currentContext!)!,
          ),
          children: [
            Column(
              children: [
                Image(
                  repeat: ImageRepeat.repeat,
                  height: height/0.85,
                  image: widget.image,
                  key: _backgroundImageKey,
                  fit: BoxFit.cover,
                ),
              ],
            )
          ],
      ),
    );
  }
}
