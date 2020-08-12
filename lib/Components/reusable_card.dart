import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableCard extends StatefulWidget {
  final Widget cardChild;
  final Function onPress;

  ReusableCard({this.cardChild, this.onPress});

  @override
  _ReusableCardState createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: Offset(-6.0, -6.0),
            blurRadius: 5.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: widget.onPress,
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            child: widget.cardChild,
            padding: EdgeInsets.all(18.3),
            decoration: BoxDecoration(
                color: kCardBackgroundColor,
                borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ),
    );
  }
}
