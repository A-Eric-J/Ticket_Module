import 'package:flutter/material.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/shared/text_style.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

/// [TextFormFieldWidget] is a custom widget of TextFormField widget that is using in this app

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? preFix;
  final Widget? sufFix;
  final void Function(String)? onChanged;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? initialText;
  final bool? enable;
  final Color? textColor;
  final double? hintSize;
  final double? textSize;
  final bool? hasLabel;
  final bool? filled;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final VoidCallback? sufFxeOnTap;
  final bool? hasBorder;
  final TextAlign? textAlign;
  final double? radius;
  final bool? hasSuffix;
  final EdgeInsets? contentPadding;

  const TextFormFieldWidget({
    Key? key,
    this.controller,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.initialText,
    this.enable = true,
    this.textColor = black,
    this.textSize = 14,
    this.preFix,
    this.labelText = '',
    this.hintSize,
    this.sufFix,
    this.hasLabel,
    this.filled,
    this.backgroundColor,
    this.onTap,
    this.minLines,
    this.sufFxeOnTap,
    this.hasBorder = true,
    this.hintText = '',
    this.textAlign = TextAlign.left,
    this.radius,
    this.hasSuffix = true,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  bool visibilityRemoveIconAsSuffix = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      highlightColor: transparent,
      splashColor: transparent,
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.hasLabel!)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                    text: widget.labelText ?? '',
                    size: 12,
                    color: midGreyColor),
                SizedBox(
                  height: width * 0.0133,
                ),
              ],
            ),
          TextFormField(
            controller: widget.controller,
            obscureText: false,
            initialValue: widget.initialText,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            cursorHeight: widget.textSize,
            maxLength: widget.maxLength,
            enabled: widget.enable,
            textAlign: widget.textAlign!,
            keyboardType: keyboardType(),
            textAlignVertical: TextAlignVertical.center,
            textInputAction: textInputAction(),
            style: robotoNormalStyle(widget.textSize!, widget.textColor!),
            decoration: InputDecoration(
                fillColor: widget.backgroundColor,
                filled: widget.filled,
                counterText: '',
                contentPadding: widget.contentPadding ??
                    EdgeInsets.symmetric(
                        horizontal: width * 0.0533, vertical: width * 0.0266),
                border: InputBorder.none,
                focusedErrorBorder: outlineInputBorder(width),
                focusedBorder: outlineInputBorder(width),
                disabledBorder: outlineInputBorder(width),
                enabledBorder: outlineInputBorder(width),
                hintText: widget.hintText ?? '',
                hintStyle: robotoNormalStyle(14, greyColor),
                suffixIcon: _suffix(),
                prefixIcon: widget.preFix),
            cursorColor: focusedTextFiledColor,
            onChanged: (value) {
              setState(() {
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }

                /// for visible remove icon as suffix
                if (value.isNotEmpty && widget.controller != null) {
                  visibilityRemoveIconAsSuffix = true;
                } else {
                  visibilityRemoveIconAsSuffix = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  InputBorder outlineInputBorder(double width) {
    if (widget.hasBorder!) {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? width * 0.008),
          borderSide: const BorderSide(color: greyColor, width: 2));
    } else {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
          borderSide: const BorderSide(color: transparent, width: 0));
    }
  }

  Widget? _suffix() {
    if (widget.hasSuffix!) {
      if (widget.sufFix != null) {
        return widget.sufFix!;
      } else {
        return Visibility(
            visible: visibilityRemoveIconAsSuffix,
            child: RemoveIcon(
              onTap: () {
                setState(() {
                  if (widget.sufFxeOnTap != null) {
                    widget.sufFxeOnTap!();
                  }
                  if (widget.controller != null) {
                    widget.controller!.clear();
                    visibilityRemoveIconAsSuffix = false;
                    widget.onChanged!('');
                  }
                });
              },
            ));
      }
    } else {
      return null;
    }
  }

  TextInputAction textInputAction() {
    return TextInputAction.done;
  }

  TextInputType keyboardType() {
    return TextInputType.text;
  }
}
