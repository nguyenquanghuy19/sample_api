import 'package:flutter/material.dart';

enum SelectedToggleButton { right, left }

class ToggleButton extends StatefulWidget {
  final double width;
  final double height;

  final String leftDescription;
  final String rightDescription;

  final Color toggleColor;
  final Color toggleBackgroundColor;
  final Color toggleBorderColor;
  final Color toggleBorderColorSelected;

  final Color inactiveTextColor;
  final Color activeTextColor;

  final double _leftToggleAlign = -1;
  final double _rightToggleAlign = 1;

  final VoidCallback onLeftToggleActive;
  final VoidCallback onRightToggleActive;

  final SelectedToggleButton defaultToggleActive;

  final TextStyle appTextLeft;

  final TextStyle appTextRight;

  const ToggleButton({
    Key? key,
    required this.appTextRight,
    required this.appTextLeft,
    required this.width,
    required this.height,
    required this.toggleBackgroundColor,
    required this.toggleBorderColor,
    required this.toggleBorderColorSelected,
    required this.toggleColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.leftDescription,
    required this.rightDescription,
    required this.onLeftToggleActive,
    required this.onRightToggleActive,
    required this.defaultToggleActive,
  }) : super(key: key);

  @override
  ToggleButtonState createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  double _toggleXAlign = -1;

  @override
  void initState() {
    super.initState();
    _toggleXAlign =
        widget.defaultToggleActive == SelectedToggleButton.left ? -1 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.toggleBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        border: Border.all(color: widget.toggleBorderColor),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(_toggleXAlign, 5),
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: widget.width * 0.4,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.toggleColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                border: Border.all(color: widget.toggleBorderColorSelected),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  _toggleXAlign = widget._rightToggleAlign;
                },
              );
              widget.onRightToggleActive();
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: widget.width * 0.4,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.rightDescription,
                  style: widget.appTextRight,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  _toggleXAlign = widget._leftToggleAlign;
                },
              );
              widget.onLeftToggleActive();
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: widget.width * 0.4,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.leftDescription,
                  style: widget.appTextLeft.copyWith(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
