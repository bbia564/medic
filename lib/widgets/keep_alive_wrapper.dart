import 'package:flutter/material.dart';

class KeepAliveWrapper extends StatefulWidget {
  final Widget child;
  bool isKeep;

  KeepAliveWrapper({Key? key, required this.child, this.isKeep = true})
      : super(key: key);

  @override
  __KeepAliveWrapperState createState() => __KeepAliveWrapperState();
}

class __KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.isKeep != widget.isKeep) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.isKeep;
}