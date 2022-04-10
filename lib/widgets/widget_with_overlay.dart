import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';

class WidgetWithOverlay extends StatefulWidget {
  final bool Function() shouldShowOverlay;
  final void Function()? onClickOutside;
  final Widget child;
  final Widget overlay;
  final double? maxOverlayHeight;
  final Color? outsideColor;

  const WidgetWithOverlay({
    Key? key,
    required this.shouldShowOverlay,
    this.onClickOutside,
    required this.child,
    required this.overlay,
    this.maxOverlayHeight,
    this.outsideColor,
  }) : super(key: key);

  @override
  State<WidgetWithOverlay> createState() => WidgetWithOverlayState();
}

class WidgetWithOverlayState extends State<WidgetWithOverlay> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  BoxConstraints? _constraints;

  void updateOverlay() {
    if (widget.shouldShowOverlay()) {
      _overlayEntry?.remove();
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return _barrier(CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: _constraints!.biggest.width,
                  height: widget.maxOverlayHeight ?? 200,
                  child: widget.overlay,
                ),
              ),
            ),
          ));
        },
      );
      Overlay.of(context, rootOverlay: true)!.insert(_overlayEntry!);
    } else if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  Widget _barrier(Widget child) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onClickOutside,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Obx(() => Container(
              color: widget.outsideColor ??
                  menuController.theme().colorScheme.shadow.withOpacity(0.2),
              child: child,
            )),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _constraints = constraints;
        return CompositedTransformTarget(
          link: _layerLink,
          child: widget.child,
        );
      },
    );
  }
}
