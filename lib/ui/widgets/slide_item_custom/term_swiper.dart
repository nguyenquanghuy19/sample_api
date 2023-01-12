import 'dart:math';

import 'package:elearning/core/data/models/flash_card_model.dart';
import 'package:flutter/material.dart';

class TermSwiper extends StatefulWidget {
  /// list of TermModel for the swiper
  final List<TermModel> items;

  /// controller to trigger unswipe action
  final AppinioSwiperController? controller;

  /// duration of every animation
  final Duration duration;

  /// padding of the swiper
  final EdgeInsetsGeometry padding;

  /// maximum angle the card reaches while swiping
  final double maxAngle;

  /// threshold from which the card is swiped away
  final int threshold;

  /// set to true if swiping should be disabled, exception: triggered from the outside
  final bool isDisabled;

  /// set to false if unswipe should be disabled
  final bool allowUnswipe;

  /// set to true if the user can unswipe as many cards as possible
  final bool unlimitedUnswipe;

  /// set to true if the user can swipe left and right
  final bool horizontalSwipeEnabled;

  /// set to true if the user can swipe up and down
  final bool verticalSwipeEnabled;

  /// function that gets called with the new index and detected swipe direction when the user swiped or swipe is triggered by controller
  final Function onSwipe;

  /// function that gets called when there is no widget left to be swiped away
  final Function onEnd;

  /// function that gets triggered when the swiper is disabled
  final Function onTapDisabled;

  /// function that gets called with the boolean true when the last card gets unswiped and with the boolean false when there is no card to unswipe
  final Function unswipe;

  /// function that gets called with detected mode when the user swiped
  final Function onSwipeMode;

  /// direction in which the card gets swiped when triggered by controller, default set to right
  final TermSwiperDirection direction;

  final Widget Function(BuildContext context, TermModel data) itemBuilder;

  final Widget? placeHolder;

  /// function that gets called with detected mode when the user swiped
  final Function onUndoSwipe;

  const TermSwiper({
    Key? key,
    this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    this.duration = const Duration(milliseconds: 200),
    this.maxAngle = 30,
    this.threshold = 50,
    this.isDisabled = false,
    this.allowUnswipe = true,
    this.unlimitedUnswipe = false,
    this.horizontalSwipeEnabled = true,
    this.verticalSwipeEnabled = true,
    this.onTapDisabled = emptyFunction,
    this.onSwipe = emptyFunctionIndex,
    this.onEnd = emptyFunction,
    this.unswipe = emptyFunctionBool,
    this.direction = TermSwiperDirection.right,
    this.onSwipeMode = emptyFunctionMode,
    this.placeHolder,
    required this.itemBuilder,
    required this.items,
    this.onUndoSwipe = emptyFunctionUndo,
  })  : assert(maxAngle >= 0 && maxAngle <= 360),
        assert(threshold >= 1 && threshold <= 100),
        assert(direction != TermSwiperDirection.none),
        super(key: key);

  @override
  State createState() => _TermSwiperState();
}

class _TermSwiperState extends State<TermSwiper>
    with SingleTickerProviderStateMixin {
  double _left = 0;
  double _top = 0;
  double _total = 0;
  double _angle = 0;
  double _maxAngle = 0;
  double _scale = 0.9;
  double _difference = 40;

  int _swipeTyp = 0; // 1 = swipe, 2 = unswipe, 3 = goBack
  bool _tapOnTop = false; //position of starting drag point on card

  late AnimationController _animationController;
  late Animation<double> _leftAnimation;
  late Animation<double> _topAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _differenceAnimation;
  late Animation<double> _unSwipeLeftAnimation;
  late Animation<double> _unSwipeTopAnimation;

  bool _vertical = false;
  bool _horizontal = false;
  bool _isUnswiping = false;
  int _swipedDirectionVertical = 0; //-1 bottom, 1 top
  int _swipedDirectionHorizontal = 0; //-1 left, 1 right

  WidgetWrapper? _cardShow;
  TermUnswipeCard? _lastCard;

  // ignore: prefer_final_fields
  List<TermUnswipeCard?> _lastCards = [];
  TermSwiperDirection detectedDirection = TermSwiperDirection.none;

  TermOutlineMode _modeCurrent = TermOutlineMode.none;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      widget.controller!
        //swipe widget from the outside
        ..addListener(() {
          if (widget.controller!.state == TermSwiperState.swipe) {
            if (widget.items.isNotEmpty) {
              switch (widget.direction) {
                case TermSwiperDirection.right:
                  _swipeHorizontal(context);
                  break;
                case TermSwiperDirection.left:
                  _swipeHorizontal(context);
                  break;
                case TermSwiperDirection.top:
                  _swipeVertical(context);
                  break;
                case TermSwiperDirection.bottom:
                  _swipeVertical(context);
                  break;
                case TermSwiperDirection.none:
                  break;
              }
              _animationController.forward();
            }
          }
        })
        //swipe widget left from the outside
        ..addListener(() {
          if (widget.controller!.state == TermSwiperState.swipeLeft) {
            if (widget.items.isNotEmpty) {
              _left = -1;
              _swipeHorizontal(context);
              _animationController.forward();
            }
          }
        })
        //swipe widget right from the outside
        ..addListener(() {
          if (widget.controller!.state == TermSwiperState.swipeRight) {
            if (widget.items.isNotEmpty) {
              _left = widget.threshold + 1;
              _swipeHorizontal(context);
              _animationController.forward();
            }
          }
        })
        //unswipe widget from the outside
        ..addListener(() {
          if (widget.controller!.state == TermSwiperState.unswipe) {
            if (widget.allowUnswipe) {
              if (!_isUnswiping) {
                if (_lastCard != null || _lastCards.isNotEmpty) {
                  if (widget.unlimitedUnswipe) {
                    _unswipe(_lastCards.last!);
                  } else {
                    _unswipe(_lastCard!);
                  }
                  widget.unswipe(true);
                  _animationController.forward();
                } else {
                  widget.unswipe(false);
                }
              }
            }
          }
        });
    }

    if (widget.maxAngle > 0) {
      _maxAngle = widget.maxAngle * (pi / 180);
    }

    _animationController =
        AnimationController(duration: widget.duration, vsync: this);
    _animationController.addListener(() {
      //when value of controller changes
      if (_animationController.status == AnimationStatus.forward) {
        setState(() {
          if (_swipeTyp != 2) {
            _left = _leftAnimation.value;
            _top = _topAnimation.value;
          }
          if (_swipeTyp == 2) {
            _left = _unSwipeLeftAnimation.value;
            _top = _unSwipeTopAnimation.value;
          }
          _scale = _scaleAnimation.value;
          _difference = _differenceAnimation.value;
        });
      }
    });

    _animationController.addStatusListener((status) {
      //when status of controller changes
      if (status == AnimationStatus.completed) {
        setState(() {
          if (_swipeTyp == 1 && _cardShow != null) {
            if (widget.unlimitedUnswipe) {
              _lastCards.add(
                TermUnswipeCard(
                  widgetWrapper: _cardShow!,
                  horizontal: _horizontal,
                  vertical: _vertical,
                  swipedDirectionHorizontal: _swipedDirectionHorizontal,
                  swipedDirectionVertical: _swipedDirectionVertical,
                ),
              );
            } else {
              _lastCard = TermUnswipeCard(
                widgetWrapper: _cardShow!,
                horizontal: _horizontal,
                vertical: _vertical,
                swipedDirectionHorizontal: _swipedDirectionHorizontal,
                swipedDirectionVertical: _swipedDirectionVertical,
              );
            }
            _swipedDirectionHorizontal = 0;
            _swipedDirectionVertical = 0;
            _vertical = false;
            _horizontal = false;
            _modeCurrent = TermOutlineMode.none;
            widget.items.removeLast();

            int index = widget.items.isNotEmpty? widget.items.length : 0;
            widget.onSwipe(index, detectedDirection);
            if (widget.items.isEmpty) widget.onEnd();
          } else if (_swipeTyp == 2) {
            if (widget.unlimitedUnswipe) {
              _lastCards.removeLast();
            } else {
              _lastCard = null;
              _cardShow = null;
            }
            _isUnswiping = false;
          }
          _animationController.reset();
          _resetMode();
          _left = 0;
          _top = 0;
          _total = 0;
          _angle = 0;
          _scale = 0.9;
          _difference = 40;
          _swipeTyp = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (widget.items.isNotEmpty && _cardShow?.data != widget.items.last) {
          _cardShow = WidgetWrapper(
            widget: widget.itemBuilder(context, widget.items.last),
            data: widget.items.last,
          );
        }

        return Container(
          padding: widget.padding,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  if (widget.items.isNotEmpty && _cardShow != null) ...{
                    if (widget.placeHolder != null) ...{
                      _itemPlaceHolder(constraints),
                    },
                    _item(constraints, _cardShow!.widget),
                  },
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _itemPlaceHolder(BoxConstraints constraints) {
    return Positioned(
      top: _difference,
      left: 0,
      child: Container(
        color: Colors.transparent,
        child: Transform.scale(
          scale: _scale,
          child: Container(
            constraints: constraints,
            child: widget.placeHolder,
          ),
        ),
      ),
    );
  }

  Widget _item(BoxConstraints constraints, Widget widgetItem) {
    return Positioned(
      left: _left,
      top: _top,
      child: GestureDetector(
        child: Transform.rotate(
          angle: _angle,
          child: Container(
            constraints: constraints,
            child: widgetItem,
          ),
        ),
        onTap: () {
          if (widget.isDisabled) {
            widget.onTapDisabled();
          }
        },
        onPanStart: (tapInfo) {
          if (!widget.isDisabled) {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset position = renderBox.globalToLocal(tapInfo.globalPosition);

            if (position.dy < renderBox.size.height / 2) _tapOnTop = true;
          }
        },
        onPanUpdate: (tapInfo) {
          if (!widget.isDisabled) {
            setState(() {
              _left += tapInfo.delta.dx;
              _top += tapInfo.delta.dy;
              _total = _left + _top;
              _calculateAngle();
              _calculateScale();
              _calculateDifference();
              _calculateMode();
            });
          }
        },
        onPanEnd: (tapInfo) {
          if (!widget.isDisabled) {
            _tapOnTop = false;
            _onEndAnimation();
            _animationController.forward();
          }
        },
      ),
    );
  }

  void _calculateAngle() {
    if (_angle <= _maxAngle && _angle >= -_maxAngle) {
      (_tapOnTop)
          ? _angle = (_maxAngle / 100) * (_left / 10)
          : _angle = (_maxAngle / 100) * (_left / 10) * -1;
    }
  }

  void _calculateScale() {
    if (_scale <= 1.0 && _scale >= 0.9) {
      _scale =
          (_total > 0) ? 0.9 + (_total / 5000) : 0.9 + -1 * (_total / 5000);
    }
  }

  void _calculateDifference() {
    if (_difference >= 0 && _difference <= _difference) {
      _difference = (_total > 0) ? 40 - (_total / 10) : 40 + (_total / 10);
    }
  }

  void _calculateMode() {
    if (_left < -widget.threshold && _modeCurrent != TermOutlineMode.left) {
      _modeCurrent = TermOutlineMode.left;
      widget.onSwipeMode(_modeCurrent);
    } else if (_left > widget.threshold &&
        _modeCurrent != TermOutlineMode.right) {
      _modeCurrent = TermOutlineMode.right;
      widget.onSwipeMode(_modeCurrent);
    } else if ((_left >= -widget.threshold && _left <= widget.threshold) &&
        _modeCurrent != TermOutlineMode.none) {
      _modeCurrent = TermOutlineMode.none;
      widget.onSwipeMode(_modeCurrent);
    }
  }

  void _resetMode() {
    if (_modeCurrent != TermOutlineMode.none) {
      _modeCurrent = TermOutlineMode.none;
      widget.onSwipeMode(_modeCurrent);
    }
  }

  void _onEndAnimation() {
    if ((_left < -widget.threshold || _left > widget.threshold) &&
        widget.horizontalSwipeEnabled) {
      _swipeHorizontal(context);
    } else if ((_top < -widget.threshold || _top > widget.threshold) &&
        widget.verticalSwipeEnabled) {
      _swipeVertical(context);
    } else {
      _goBack(context);
    }
  }

  //moves the card away to the left or right
  void _swipeHorizontal(BuildContext context) {
    setState(() {
      _swipeTyp = 1;
      _leftAnimation = Tween<double>(
        begin: _left,
        end: (_left == 0)
            ? (widget.direction == TermSwiperDirection.right)
                ? MediaQuery.of(context).size.width
                : -MediaQuery.of(context).size.width
            : (_left > widget.threshold)
                ? MediaQuery.of(context).size.width
                : -MediaQuery.of(context).size.width,
      ).animate(_animationController);
      _topAnimation = Tween<double>(
        begin: _top,
        end: _top + _top,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: _scale,
        end: 1.0,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: _difference,
        end: 0,
      ).animate(_animationController);
    });
    if (_left > widget.threshold ||
        _left == 0 && widget.direction == TermSwiperDirection.right) {
      _swipedDirectionHorizontal = 1;
      detectedDirection = TermSwiperDirection.right;
    } else {
      _swipedDirectionHorizontal = -1;
      detectedDirection = TermSwiperDirection.left;
    }
    (_top <= 0) ? _swipedDirectionVertical = 1 : _swipedDirectionVertical = -1;
    _horizontal = true;
  }

  //moves the card away to the top or bottom
  void _swipeVertical(BuildContext context) {
    setState(() {
      _swipeTyp = 1;
      _leftAnimation = Tween<double>(
        begin: _left,
        end: _left + _left,
      ).animate(_animationController);
      _topAnimation = Tween<double>(
        begin: _top,
        end: (_top == 0)
            ? (widget.direction == TermSwiperDirection.bottom)
                ? MediaQuery.of(context).size.height
                : -MediaQuery.of(context).size.height
            : (_top > widget.threshold)
                ? MediaQuery.of(context).size.height
                : -MediaQuery.of(context).size.height,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: _scale,
        end: 1.0,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: _difference,
        end: 0,
      ).animate(_animationController);
    });
    if (_top > widget.threshold ||
        _top == 0 && widget.direction == TermSwiperDirection.bottom) {
      _swipedDirectionVertical = -1;
      detectedDirection = TermSwiperDirection.bottom;
    } else {
      _swipedDirectionVertical = 1;
      detectedDirection = TermSwiperDirection.top;
    }
    (_left >= 0)
        ? _swipedDirectionHorizontal = 1
        : _swipedDirectionHorizontal = -1;
    _vertical = true;
  }

  //moves the card back to starting position
  void _goBack(BuildContext context) {
    setState(() {
      _swipeTyp = 3;
      _leftAnimation = Tween<double>(
        begin: _left,
        end: 0,
      ).animate(_animationController);
      _topAnimation = Tween<double>(
        begin: _top,
        end: 0,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: _scale,
        end: 0.9,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: _difference,
        end: 40,
      ).animate(_animationController);
    });
  }

  //unswipe the card: brings back the last card that was swiped away
  void _unswipe(TermUnswipeCard card) {
    _isUnswiping = true;
    widget.items.add(card.widgetWrapper.data);
    widget.onUndoSwipe(card.widgetWrapper.data);
    _swipeTyp = 2;
    //unSwipe horizontal
    if (card.horizontal) {
      _unSwipeLeftAnimation = Tween<double>(
        begin: (card.swipedDirectionHorizontal == 1)
            ? MediaQuery.of(context).size.width
            : -MediaQuery.of(context).size.width,
        end: 0,
      ).animate(_animationController);
      _unSwipeTopAnimation = Tween<double>(
        begin: (card.swipedDirectionVertical == 1)
            ? -MediaQuery.of(context).size.height / 4
            : MediaQuery.of(context).size.height / 4,
        end: 0,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: _scale,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: 0,
        end: _difference,
      ).animate(_animationController);
    }
    //unSwipe vertical
    if (card.vertical) {
      _unSwipeLeftAnimation = Tween<double>(
        begin: (card.swipedDirectionHorizontal == 1)
            ? MediaQuery.of(context).size.width / 4
            : -MediaQuery.of(context).size.width / 4,
        end: 0,
      ).animate(_animationController);
      _unSwipeTopAnimation = Tween<double>(
        begin: (card.swipedDirectionVertical == 1)
            ? -MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height,
        end: 0,
      ).animate(_animationController);
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: _scale,
      ).animate(_animationController);
      _differenceAnimation = Tween<double>(
        begin: 0,
        end: _difference,
      ).animate(_animationController);
    }

    setState(
      () {
        // TODO: need to implement.
      },
    );
  }
}

//for null safety
void emptyFunction() {
  // TODO: need to implement.
}

void emptyFunctionIndex(int index, TermSwiperDirection direction) {
  // TODO: need to implement.
}

void emptyFunctionBool(bool unswiped) {
  // TODO: need to implement.
}

void emptyFunctionMode(TermOutlineMode mode) {
  // TODO: need to implement.
}

void emptyFunctionUndo(TermModel termUndo) {
  // TODO: need to implement.
}

//to call the swipe or unswipe function from outside of the appinio swiper
class AppinioSwiperController extends ChangeNotifier {
  TermSwiperState? state;

  //swipe the card by changing the status of the controller
  void swipe() {
    state = TermSwiperState.swipe;
    notifyListeners();
  }

  //swipe the card to the left side by changing the status of the controller
  void swipeLeft() {
    state = TermSwiperState.swipeLeft;
    notifyListeners();
  }

  //swipe the card to the right side by changing the status of the controller
  void swipeRight() {
    state = TermSwiperState.swipeRight;
    notifyListeners();
  }

  //calls unswipe the card by changing the status of the controller
  void unswipe() {
    state = TermSwiperState.unswipe;
    notifyListeners();
  }
}

class TermUnswipeCard {
  WidgetWrapper widgetWrapper;
  bool horizontal;
  bool vertical;
  int swipedDirectionHorizontal;
  int swipedDirectionVertical;

  TermUnswipeCard({
    required this.widgetWrapper,
    required this.horizontal,
    required this.vertical,
    required this.swipedDirectionHorizontal,
    required this.swipedDirectionVertical,
  });
}

class WidgetWrapper<T> {
  Widget widget;
  T data;

  WidgetWrapper({
    required this.widget,
    required this.data,
  });
}

enum TermSwiperState { swipe, swipeLeft, swipeRight, unswipe }

enum TermSwiperDirection { none, left, right, top, bottom }

enum TermOutlineMode { none, left, right }
