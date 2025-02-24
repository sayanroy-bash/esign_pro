import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_provider/res/colors.dart';

// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton(
    this.label,
    this.callback, {
    this.elevation = 0.0,
    super.key,
    this.height,
    this.iconHeight,
    this.width,
    this.iconWidth,
    this.radius,
    this.borderColor,
    this.padding,
    this.paddingFromRight,
    this.isIcon = false,
    this.isDisabled = false,
    this.color,
    this.iconColor,
    this.textStyle,
    this.isSecondaryBackground = false,
    this.isLoading = false,
    this.optionFeedIcon = false,
    this.leadingIcon = false,
    this.isCenterTextImage = false,
    this.isGradient = false,
    this.image,
    this.disabledColor,
    this.isOnlyIcon = false,
    this.spaceBetween,
    this.textColor,
    this.paddingEdgeInsets,
    this.loading,
  });

  final String label;
  final VoidCallback callback;
  final double? elevation;
  final double? height;
  final double? width;
  final double? iconWidth;
  final double? iconHeight;
  final double? radius;
  final double? padding;
  final double? paddingFromRight;
  final bool isDisabled;
  final bool isIcon;
  final bool isSecondaryBackground;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final bool isLoading;
  final bool optionFeedIcon;
  final String? image;
  final bool leadingIcon;
  final bool isCenterTextImage;
  final bool isGradient;
  final Color? disabledColor;
  final bool isOnlyIcon;
  final double? spaceBetween;
  final EdgeInsets? paddingEdgeInsets;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width != null) ? width : double.infinity,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 10),
          ),
          gradient: isGradient
              ? const LinearGradient(
                  colors: [AppColor.appBackgroundColor, Color(0xFFFF00FF)],
                  stops: [0.15, 0.68],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        child: MaterialButton(
          elevation: elevation,
          visualDensity: VisualDensity.compact,
          disabledColor: disabledColor ?? Colors.grey,
          padding: isLoading
              ? paddingEdgeInsets ?? EdgeInsets.symmetric(vertical: 4)
              : paddingEdgeInsets ?? (EdgeInsets.symmetric(vertical: (padding != null) ? padding ?? 0 : 20)),
          onPressed: isDisabled || isLoading
              ? null
              : () {
                  HapticFeedback.mediumImpact();
                  if (isRedundantClick(DateTime.now()) || isDisabled || isLoading) {
                    return;
                  }
                  callback();
                },
          color: isGradient
              ? Colors.transparent
              : isSecondaryBackground
                  ? color
                  : (isDisabled ? disabledColor ?? Theme.of(context).dividerColor : Theme.of(context).primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
            side: BorderSide(
              color: isSecondaryBackground ? (borderColor != null ? borderColor! : Colors.transparent) : Colors.transparent,
            ),
          ),
          child: Stack(
            children: [
              if (isLoading)
                loading ?? CircularProgressIndicator()
              else
                //optionFeedIcon
                //   ? _buildOptionFeedUI(context)
                //   :
                //leadingIcon
                // ? _leadingIconRow(context)
                //        :
                Padding(
                  padding: EdgeInsets.only(right: 6, left: 6, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isOnlyIcon)
                        Flexible(
                          child: FittedBox(
                            child: Text(
                              textStyle != null ? label : '',
                              style: textStyle ?? TextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? loginClickTime;

  bool isRedundantClick(DateTime currentTime) {
    if (loginClickTime == null) {
      loginClickTime = currentTime;
      return false;
    }
    if (currentTime.difference(loginClickTime ?? DateTime.now()).inSeconds < 1) {
      //set this difference time in seconds
      return true;
    }

    loginClickTime = currentTime;
    return false;
  }
}

DateTime? loginClickTime;

bool isRedundantClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime ?? DateTime.now()).inMilliseconds < 1000) {
    //set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}

void showLoader(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) {
      return Column(
        children: <Widget>[
          Expanded(
              flex: 6,
              child: SizedBox.expand(
                child: Center(
                    child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                )),
              )),
        ],
      );
    },
  );
}
