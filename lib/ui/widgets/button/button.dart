import 'package:flutter/material.dart';
import 'package:ticket_module/enums/view_state.dart';
import 'package:ticket_module/generated/l10n.dart';
import 'package:ticket_module/ui/shared/colors.dart';
import 'package:ticket_module/ui/widgets/button/icon_button.dart';
import 'package:ticket_module/ui/widgets/text/text_view.dart';

/// [RectAngleButton] is a custom button that we are using in your app
class RectAngleButton extends StatelessWidget {
  final String nameOfButton;
  final Color? color;
  final Color? borderColor;
  final Color? shadowColor;
  final double? height;
  final double? width;
  final double? radius;
  final VoidCallback? onTap;
  final ViewState state;
  final Color? textColor;
  final double? textSize;
  final EdgeInsetsGeometry? insidePadding;

  const RectAngleButton({
    Key? key,
    required this.nameOfButton,
    this.color,
    this.height,
    this.width,
    required this.onTap,
    required this.state,
    this.radius,
    this.borderColor,
    this.shadowColor,
    this.textColor,
    this.textSize,
    this.insidePadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          height: height,
          width: this.width,
          decoration: BoxDecoration(
            color: color ?? brandMainColor,
            borderRadius: BorderRadius.circular(radius ?? width * 0.032),
            border: Border.all(color: borderColor ?? Colors.transparent),
            boxShadow: [
              BoxShadow(
                color: shadowColor ?? Colors.transparent,
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: insidePadding ?? EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: nameOfButton,
                  color: textColor ?? white,
                  size: textSize ?? 15,
                ),
                if (state == ViewState.busy)
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.03),
                    child: SizedBox(
                      height: width * 0.05,
                      width: width * 0.05,
                      child: const CircularProgressIndicator(
                        color: white,
                      ),
                    ),
                  )
              ],
            ),
          )),
    );
  }
}

class TryAgainButton extends StatelessWidget {
  final VoidCallback? onTap;

  const TryAgainButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(width * 0.0213),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const ReplayIcon(
                isFill: false,
                color: brandMainColor,
              ),
              SizedBox(
                width: width * 0.0186,
              ),
              TextView(
                text: S.of(context).tryAgainText,
                size: 12,
                color: primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [CustomRadioButton] for choosing department and priority for the list
class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final Color color;

  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.color = brandMainColor,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        height: width * 0.05,
        width: width * 0.05,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: value == groupValue ? color : outerCheckBoxColor,
              style: BorderStyle.solid,
            )),
        child: Center(
          child: Container(
            height: width * 0.033,
            width: width * 0.033,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == groupValue ? color : Colors.transparent),
          ),
        ),
      ),
    );
  }
}
