import 'package:ticket_module/ui/widgets/textformfield/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:ticket_module/ui/shared/colors.dart';

class TextFormFieldItem extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? errorLabel;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final double? minHeight;
  final String? initialText;
  final bool? enable;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final double? textSize;
  final double? hintSize;
  final Widget? preFixe;
  final Widget? sufFixe;
  final EdgeInsetsGeometry? padding;
  final bool? hasLabel;
  final bool? filled;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final VoidCallback? sufFxeOnTap;
  final bool? hasBorder;
  final TextAlign? textAlign;
  final double? radius;
  final bool? hasSuffix;

  const TextFormFieldItem({
    Key? key,
    this.textController,
    this.onChanged,
    this.minHeight,
    this.initialText,
    this.enable = true,
    this.maxLines = 1,
    this.minLines = 1,
    this.errorLabel = '',
    this.textSize = 16,
    this.preFixe,
    this.padding,
    this.labelText = '',
    this.hintSize = 16,
    this.sufFixe,
    this.hasLabel = true,
    this.filled = false,
    this.backgroundColor = transparent,
    this.onTap,
    this.sufFxeOnTap,
    this.hasBorder = true,
    this.maxLength,
    this.hintText = '',
    this.textAlign = TextAlign.left,
    this.radius,
    this.hasSuffix = true,
  }) : super(key: key);

  @override
  State<TextFormFieldItem> createState() => _TextFormFieldItemState();
}

class _TextFormFieldItemState extends State<TextFormFieldItem> {
  Color? borderColorValue;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: _textFormField(width),
    );
  }

  Widget _textFormField(double width) {
    return TextFormFieldWidget(
      labelText: widget.labelText,
      hintText: widget.hintText,
      initialText: widget.initialText,
      enable: widget.enable,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      textSize: widget.textSize,
      hintSize: widget.hintSize,
      preFix: widget.preFixe,
      sufFix: widget.sufFixe,
      hasLabel: widget.hasLabel,
      controller: widget.textController,
      filled: widget.filled,
      backgroundColor: widget.backgroundColor,
      onTap: widget.onTap,
      sufFxeOnTap: widget.sufFxeOnTap,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      hasBorder: widget.hasBorder,
      textAlign: widget.textAlign,
      radius: widget.radius,
      hasSuffix: widget.hasSuffix,
    );
  }
}
