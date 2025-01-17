import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/src/tweens/delay_tween.dart';

class MySpinKitFadingCircle extends StatefulWidget {
  const MySpinKitFadingCircle({
    Key? key,
    this.color,
    this.tip = '',
    this.size = 50.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null) &&
                tip is String,
            'You should specify either a itemBuilder or a color'),
        super(key: key);

  final Color? color;
  final double size;
  final String? tip;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  _SpinKitFadingCircleState createState() => _SpinKitFadingCircleState();
}

class _SpinKitFadingCircleState extends State<MySpinKitFadingCircle>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox.fromSize(
            size: Size.square(widget.size),
            child: Stack(
              children: List.generate(12, (i) {
                final _position = widget.size * .5;
                return Positioned.fill(
                  left: _position,
                  top: _position,
                  child: Transform(
                    transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                    child: Align(
                      alignment: Alignment.center,
                      child: FadeTransition(
                        opacity:
                            DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                                .animate(_controller),
                        child: SizedBox.fromSize(
                            size: Size.square(widget.size * 0.15),
                            child: _itemBuilder(i)),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Text(
            widget.tip!,
            style: const TextStyle(fontSize: 18, color: Color(0xFF000000)),
          )
        ],
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration:
              BoxDecoration(color: widget.color, shape: BoxShape.circle));
}
