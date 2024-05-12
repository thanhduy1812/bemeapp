import 'package:flutter/material.dart';

class GtdSwitchLabel extends StatefulWidget {
  final double width;
  final double height;

  final String leftDescription;
  final String rightDescription;

  final Color? toggleColor;
  final Color? toggleBackgroundColor;

  final Color? inactiveTextColor;
  final Color? activeTextColor;

  final double _leftToggleAlign = -1;
  final double _rightToggleAlign = 1;

  final VoidCallback onLeftToggleActive;
  final VoidCallback onRightToggleActive;

  const GtdSwitchLabel(
      {Key? key,
      required this.width,
      required this.height,
      this.toggleBackgroundColor,
      this.toggleColor,
      this.activeTextColor,
      this.inactiveTextColor,
      required this.leftDescription,
      required this.rightDescription,
      required this.onLeftToggleActive,
      required this.onRightToggleActive})
      : super(key: key);

  @override
  GtdSwitchLabelState createState() => GtdSwitchLabelState();
}

class GtdSwitchLabelState extends State<GtdSwitchLabel> {
  double _toggleXAlign = -1;

  late Color _leftDescriptionColor;
  late Color _rightDescriptionColor;

  @override
  void initState() {
    super.initState();
    _leftDescriptionColor = widget.activeTextColor ?? Colors.grey.shade900;
    _rightDescriptionColor = widget.inactiveTextColor ?? Colors.grey.shade500;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.toggleBackgroundColor ?? Colors.grey.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0),
        ),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(_toggleXAlign, 0),
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: widget.width * 0.5,
              height: widget.height,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: widget.toggleColor ?? Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(6.0),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _toggleXAlign = widget._leftToggleAlign;
                _leftDescriptionColor = widget.activeTextColor ?? Colors.grey.shade900;
                _rightDescriptionColor = widget.inactiveTextColor ?? Colors.grey.shade500;
              });
              widget.onLeftToggleActive();
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: widget.width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.leftDescription,
                    style: TextStyle(color: _leftDescriptionColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _toggleXAlign = widget._rightToggleAlign;
                _leftDescriptionColor = widget.inactiveTextColor ?? Colors.grey.shade500;
                _rightDescriptionColor = widget.activeTextColor ?? Colors.grey.shade900;
              });
              widget.onRightToggleActive();
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: widget.width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.rightDescription,
                    style: TextStyle(color: _rightDescriptionColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
