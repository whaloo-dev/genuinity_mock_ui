import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';
import 'package:whaloo_genuinity/widgets/widget_with_overlay.dart';

class Selector<T extends Object> extends StatefulWidget {
  final void Function(T selected) onSelected;
  final List<T> options;
  final Widget? fieldLabel;
  final Widget? prefixIcon;
  final String? fieldErrorText;
  final T? value;
  final Widget? Function(T option)? optionLeadingBuilder;
  final Widget Function(T option)? optionTitleBuilder;
  final Widget? Function(T option)? optionSubtitleBuilder;
  final String Function(T option)? optionToString;

  const Selector({
    Key? key,
    required this.onSelected,
    required this.options,
    this.fieldLabel,
    this.prefixIcon,
    this.value,
    this.fieldErrorText,
    this.optionLeadingBuilder,
    this.optionTitleBuilder,
    this.optionSubtitleBuilder,
    this.optionToString,
  }) : super(key: key);

  @override
  State<Selector<T>> createState() => _SelectorState<T>();
}

class _SelectorState<T extends Object> extends State<Selector<T>> {
  bool _showOverlay = false;
  final key = GlobalKey<WidgetWithOverlayState>();
  final textController = TextEditingController();
  final focusNode = FocusNode();

  _showOptions() {
    setState(() {
      _showOverlay = true;
      key.currentState!.updateOverlay();
    });
  }

  _hideOptions() {
    setState(() {
      _showOverlay = false;
      key.currentState!.updateOverlay();
    });
  }

  bool _shouldShow() {
    return _showOverlay;
  }

  @override
  Widget build(BuildContext context) {
    textController.text = widget.value != null
        ? widget.optionToString != null
            ? widget.optionToString!(widget.value!)
            : widget.value!.toString()
        : "";
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
        _showOptions();
      }
    });
    return WidgetWithOverlay(
      key: key,
      shouldShowOverlay: _shouldShow,
      child: TextField(
        readOnly: true,
        controller: textController,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          label: widget.fieldLabel,
          errorText: widget.fieldErrorText,
          suffixIcon: _showOverlay
              ? IconButton(
                  icon: const Icon(Icons.arrow_drop_up_rounded),
                  splashRadius: kSplashRadius,
                  onPressed: () {
                    _hideOptions();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.arrow_drop_down_rounded),
                  onPressed: () {
                    _showOptions();
                  },
                ),
        ),
      ),
      overlay: Card(
        child: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final optionString = widget.optionToString != null
                ? widget.optionToString!(widget.options[index])
                : widget.options[index].toString();
            return ListTile(
              selected: option == widget.value,
              onTap: () {
                widget.onSelected(option);
                textController.text = optionString;
                _hideOptions();
              },
              leading: widget.optionLeadingBuilder != null
                  ? widget.optionLeadingBuilder!(option)
                  : null,
              title: widget.optionTitleBuilder != null
                  ? widget.optionTitleBuilder!(option)
                  : Text(optionString, softWrap: true),
              subtitle: widget.optionSubtitleBuilder != null
                  ? widget.optionSubtitleBuilder!(option)
                  : null,
            );
          },
        ),
      ),
      onClickOutside: () {
        _hideOptions();
      },
      maxOverlayHeight: kOptionsMaxHeight,
    );
  }
}
