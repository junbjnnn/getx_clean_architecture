import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:jbbase_app/base/presentation/base_controller.dart';

export 'package:flutter/material.dart';
export 'package:flutter_form_builder/flutter_form_builder.dart';
export 'package:get/get_navigation/get_navigation.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:get/get_utils/src/extensions/context_extensions.dart';
export 'package:jbbase_app/base/presentation/widgets/common.dart';
export 'package:jbbase_app/l10n/generated/l10n.dart';
export 'package:jbbase_app/utils/config/app_text_style.dart';
export 'package:jbbase_app/utils/extension/form_builder.dart';
export 'package:jbbase_app/utils/gen/assets.gen.dart';
export 'package:jbbase_app/utils/gen/colors.gen.dart';

abstract class BaseGetView<W extends BaseController> extends GetView<W> {
  @protected
  Widget myBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    controller.initDialog(context);

    return myBuild(context);
  }
}
