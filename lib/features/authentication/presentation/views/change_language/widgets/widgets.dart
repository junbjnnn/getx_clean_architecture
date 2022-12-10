import 'package:flutter/cupertino.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'widgets.g.dart';

@swidget
Widget changeLanguageItem({
  required String language,
  bool isSelect = false,
  Function()? onPressed,
}) {
  return CupertinoButton(
    pressedOpacity: 0.8,
    padding: EdgeInsets.zero,
    minSize: 34,
    alignment: Alignment.center,
    onPressed: onPressed,
    child: SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                language,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Offstage(
              offstage: !isSelect,
              child: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  CupertinoIcons.checkmark_alt,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
