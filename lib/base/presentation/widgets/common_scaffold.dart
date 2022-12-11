import 'package:flutter/material.dart';
import 'package:jbbase_app/utils/extension/view_utils.dart';

class CommonScaffoldStyles {
  const CommonScaffoldStyles._();

  static CommonScaffoldStyle defaultStyle() => const CommonScaffoldStyle();

  static CommonScaffoldStyle primaryStyle() => const CommonScaffoldStyle(
        // backgroundColor: AppColors.current.primaryColor,
        hideKeyboardWhenTouchOutside: false,
      );

  static CommonScaffoldStyle hideKeyBoardStyle() => defaultStyle().copyWith(hideKeyboardWhenTouchOutside: true);
}

class CommonScaffold extends StatelessWidget {
  CommonScaffold({
    required this.body,
    CommonScaffoldStyle? style,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    Key? key,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside,
  })  : style = (style ?? CommonScaffoldStyles.defaultStyle()).copyWith(
          backgroundColor: backgroundColor,
          hideKeyboardWhenTouchOutside: hideKeyboardWhenTouchOutside,
        ),
        super(key: key);

  final CommonScaffoldStyle style;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool? hideKeyboardWhenTouchOutside;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: style.backgroundColor,
      body: body,
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
    );

    return style.hideKeyboardWhenTouchOutside
        ? GestureDetector(
            onTap: () => ViewUtils.hideKeyboard(context),
            child: scaffold,
          )
        : scaffold;
  }
}

class CommonScaffoldStyle {
  const CommonScaffoldStyle({
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
  });

  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;

  CommonScaffoldStyle merge(CommonScaffoldStyle otherStyle) {
    return copyWith(
      backgroundColor: otherStyle.backgroundColor,
      hideKeyboardWhenTouchOutside: otherStyle.hideKeyboardWhenTouchOutside,
    );
  }

  CommonScaffoldStyle copyWith({
    Color? backgroundColor,
    bool? hideKeyboardWhenTouchOutside,
  }) {
    return CommonScaffoldStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hideKeyboardWhenTouchOutside: hideKeyboardWhenTouchOutside ?? this.hideKeyboardWhenTouchOutside,
    );
  }
}
