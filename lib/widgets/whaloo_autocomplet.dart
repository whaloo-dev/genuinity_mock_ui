import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class WhalooAutoComplete<T extends Object> extends StatefulWidget {
  final Widget? label;
  final String? errorText;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final AutocompleteOptionsBuilder<T> optionsBuilder;
  final AutocompleteOnSelected<T>? onSelected;
  final Widget Function(BuildContext context, T option)? optionWidgetBuilder;
  final double? optionsHeight;

  const WhalooAutoComplete({
    Key? key,
    this.label,
    this.errorText,
    this.focusNode,
    this.textEditingController,
    required this.optionsBuilder,
    this.onSelected,
    this.optionWidgetBuilder,
    this.optionsHeight = 200,
  }) : super(key: key);

  @override
  State<WhalooAutoComplete<T>> createState() => _WhalooAutoCompleteState<T>();
}

//TODO add item number indicator for each option
// TODO finish
class _WhalooAutoCompleteState<T extends Object>
    extends State<WhalooAutoComplete<T>> {
  Widget _fieldViewBuilder(
      context, textEditingController, FocusNode focusNode, onFieldSubmitted) {
    focusNode.addListener(() {
      setState(() {});
    });
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        label: widget.label,
        errorText: widget.errorText,
        suffixIcon: _clearFieldWidget(() {
          setState(() {
            textEditingController.clear();
          });
        }),
      ),
      onChanged: (newValue) {
        setState(() {});
      },
    );
  }

  Widget _clearFieldWidget(void Function() handler) {
    return IconButton(
      splashRadius: kSplashRadius,
      icon: Icon(!widget.focusNode!.hasFocus
          ? Icons.arrow_drop_down_outlined
          : Icons.arrow_drop_up_outlined),
      onPressed: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RawAutocomplete<T>(
        focusNode: widget.focusNode,
        fieldViewBuilder: _fieldViewBuilder,
        onSelected: (newValue) {
          setState(() {});
          if (widget.onSelected != null) {
            widget.onSelected!(newValue);
          }
        },
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              height: widget.optionsHeight,
              width: constraints.biggest.width,
              child: Card(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  shrinkWrap: false,
                  itemBuilder: (BuildContext context, int index) {
                    final option = options.elementAt(index);
                    return ListTile(
                      onTap: () => onSelected(option),
                      title: widget.optionWidgetBuilder != null
                          ? widget.optionWidgetBuilder!(context, option)
                          : Text(option.toString()),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        optionsBuilder: widget.optionsBuilder,
        textEditingController: widget.textEditingController,
      ),
    );
  }
}
