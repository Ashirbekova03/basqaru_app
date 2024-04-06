import 'package:flutter/cupertino.dart';

class ScrollablePage extends StatefulWidget {

  final List<Widget> children;

  const ScrollablePage({super.key, required this.children});

  @override
  State<StatefulWidget> createState() {
    return _ScrollablePage();
  }
}

class _ScrollablePage extends State<ScrollablePage> {

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        padding: EdgeInsets.zero,
        children: widget.children,
      )
    );
  }
}