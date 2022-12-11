import 'package:flutter/cupertino.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import '../presentation.dart';

part 'common.g.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({
    ShapeBorder? shape,
    Color? shadowColor = Colors.black26,
    String? title,
    double? titleSpacing,
    List<Widget>? actions,
    Widget? leading = const CommonBackButton(),
    double? elevation = 3,
    bool centerTitle = true,
    Key? key,
  }) : super(
          key: key,
          shape: shape,
          centerTitle: centerTitle,
          title: title == null
              ? null
              : Text(
                  title,
                  style: Get.context?.theme.textTheme.titleMedium,
                ),
          titleSpacing: titleSpacing,
          titleTextStyle: Get.context?.theme.textTheme.titleLarge,
          backgroundColor: Get.context?.theme.appBarTheme.backgroundColor,
          elevation: elevation,
          leading: leading,
          actions: actions,
          shadowColor: shadowColor,
        );
}

@swidget
Widget commonButton({
  required Widget child,
  double? width,
  double height = 44,
  Function()? onPressed,
  Color fillColor = Colors.transparent,
  Color borderColor = Colors.transparent,
  double borderWidth = 1,
  BorderRadiusGeometry? borderRadius,
  BaseState? state,
}) {
  return SizedBox(
    width: width,
    height: height,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            side: BorderSide(
              width: borderWidth,
              color: borderColor,
            ),
          ),
        ),
        child: state != null
            ? state.widget(
                onLoading: Center(
                  child: CupertinoActivityIndicator(color: Get.context?.theme.indicatorColor),
                ),
                onEmpty: child,
              )
            : child,
      ),
    ),
  );
}

@swidget
Widget commonBottomError({required String text}) {
  return text.isEmpty
      ? const SizedBox.shrink()
      : Container(
          padding: const EdgeInsets.all(11),
          color: ColorName.redFf3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info,
                color: Colors.white,
                size: 13,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                ),
              ),
            ],
          ),
        );
}

@swidget
Widget commonBottomButton({
  required String text,
  bool isDisable = false,
  double pressedOpacity = 0.4,
  Function()? onPressed,
  BaseState? state,
}) {
  final isSafeArea = MediaQuery.of(Get.context!).viewPadding.bottom > 0;
  final double bottomPadding = isSafeArea ? 14 : 0;
  final textWidget = Padding(
    padding: EdgeInsets.only(bottom: bottomPadding),
    child: Text(
      text,
      style: TextStyle(
        color: Get.context?.theme.colorScheme.onPrimaryContainer,
      ),
    ),
  );

  return SizedBox(
    height: isSafeArea ? 80 : 66,
    child: CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      pressedOpacity: pressedOpacity,
      child: Container(
        alignment: Alignment.center,
        color: isDisable ? Get.context?.theme.disabledColor : Get.context?.theme.focusColor,
        child: state != null
            ? state.widget(
                onEmpty: textWidget,
                onLoading: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottomPadding),
                    child: CupertinoActivityIndicator(color: Get.context?.theme.indicatorColor),
                  ),
                ),
              )
            : textWidget,
      ),
    ),
  );
}

@swidget
Widget commonBackButton({void Function()? onPressed}) {
  return CupertinoButton(
    onPressed: () {
      if (onPressed != null) {
        onPressed.call();
      } else {
        Get.back();
      }
    },
    child: Icon(
      CupertinoIcons.back,
      color: Get.context?.theme.colorScheme.onBackground,
    ),
  );
}

@swidget
Widget commonCloseButton({void Function()? onPressed}) {
  return CupertinoButton(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 6),
    onPressed: () {
      if (onPressed != null) {
        onPressed.call();
      } else {
        Get.back();
      }
    },
    child: const Icon(CupertinoIcons.xmark),
  );
}

@swidget
Widget customItemCommonButton({
  void Function()? onPressed,
  required String title,
  bool withSeparator = false,
  bool hasSeparator = false,
}) {
  return Column(
    children: [
      CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Column(
          children: [
            const SizedBox(height: 29.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0),
          ],
        ),
      ),
      if (hasSeparator)
        Container(
          width: Get.width,
          height: 1,
          color: ColorName.grayBdb.withOpacity(0.25),
        ),
    ],
  );
}

@swidget
Widget commonButtonProfile({
  void Function()? onPressed,
  required String title,
  required String detail,
  bool? arrow = false,
}) {
  return Column(children: [
    const SizedBox(height: 9),
    CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  detail,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    ),
    Container(
      width: Get.width - 32,
      height: 1,
      color: ColorName.grayBdb.withOpacity(0.25),
    ),
  ]);
}

@swidget
Widget commonTextField(
  BuildContext textFieldContext, {
  GlobalKey<FormBuilderState>? formKey,
  required FormFieldType type,
  bool obscureText = false,
  bool isEnable = true,
  int? maxLines = 1,
  String? initialValue,
  TextEditingController? controller,
  TextInputAction? textInputAction = TextInputAction.next,
  void Function()? onTap,
  void Function(String?)? onChanged,
  void Function(String?)? onSubmitted,
  Widget? suffixIcon,
  void Function()? onPressedSuffixIcon,
}) {
  final ctl = controller ?? TextEditingController();

  return Theme(
    data: textFieldContext.theme.copyWith(
      primaryColor: ColorName.redFf3,
    ),
    child: SizedBox(
      height: 96,
      child: Focus(
        child: Builder(
          builder: (BuildContext context) {
            // final FocusNode focusNode = Focus.of(context);
            // final bool hasFocus = focusNode.hasFocus;

            return FormBuilderTextField(
              scrollPadding: const EdgeInsets.all(36.0),
              maxLines: maxLines,
              initialValue: initialValue,
              name: type.name,
              keyboardType: type.keyboardType,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: textInputAction,
              obscureText: obscureText,
              cursorColor: ColorName.blue007,
              cursorWidth: 1.5,
              controller: ctl,
              enabled: isEnable,
              decoration: InputDecoration(
                errorMaxLines: 2,
                isDense: true,
                labelText: type.labelText,
                labelStyle: Get.context?.textTheme.labelMedium,
                alignLabelWithHint: true,
                filled: true,
                hintText: type.hintText,
                hintStyle: Get.context?.textTheme.labelLarge,
                errorStyle: Get.context?.textTheme.labelSmall,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.gray838, width: 0.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.blue007, width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.redFf3, width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.redFf3, width: 1),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: ColorName.gray838, width: 0.5),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                suffixIcon: suffixIcon == null
                    ? null
                    : CupertinoButton(
                        minSize: 0,
                        padding: const EdgeInsets.only(right: 8),
                        onPressed: onPressedSuffixIcon,
                        child: suffixIcon,
                      ),
              ),
              validator: type.validator(),
              onTap: formKey?.formBuilderState == null || type.validator() == null
                  ? null
                  : () {
                      final text = ctl.text;
                      final field = type.field(formKey!.formBuilderState!);
                      if (type.validator() != null) {
                        field.validate();
                        field.reset();
                        ctl.value = ctl.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                        );
                      }
                      onTap?.call();
                    },
              onChanged: formKey?.formBuilderState == null || type.validator() == null
                  ? null
                  : (v) {
                      final text = ctl.text;
                      final field = type.field(formKey!.formBuilderState!);
                      if (type.validator() != null && field.hasError) {
                        field.validate();
                        field.reset();
                        ctl.value = ctl.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                        );
                      }
                      onChanged?.call(v);
                    },
              onSubmitted: onSubmitted ??
                  (_) {
                    FocusScope.of(context).nextFocus();
                  },
            );
          },
        ),
      ),
    ),
  );
}

@swidget
Widget loadingWidget() {
  return Center(
    child: CupertinoActivityIndicator(color: Get.context?.theme.indicatorColor),
  );
}

// Error dialog
@swidget
Widget errorDialog({
  Widget? title,
  Widget? content,
  void Function()? onPressed,
}) {
  return CupertinoAlertDialog(
    title: title,
    content: content,
    actions: [
      TextButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed.call();
          }
        },
        child: Text(S.current.yes),
      ),
    ],
  );
}

@swidget
Widget retryErrorWidget({
  String? errorMessage,
  required void Function() onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 64,
        ),
        Text(
          S.current.error,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          errorMessage ?? S.current.common_error_message,
          textAlign: TextAlign.center,
        ),
        CupertinoButton(
          onPressed: onPressed,
          child: Text(
            S.current.try_again,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    ),
  );
}
