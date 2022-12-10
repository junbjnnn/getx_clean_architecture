import 'package:jbbase_app/base/presentation/presentation.dart';

import '../../controllers/change_language/change_language_controller.dart';
import 'widgets/widgets.dart';

class ChangeLanguage extends BaseGetView<ChangeLanguageController> {
  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: S.current.language,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 17),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.languages.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return ChangeLanguageItem(
                          onPressed: () => {controller.onSelectLanguage(index)},
                          language: controller.languages[index].language,
                          isSelect: controller.languages[index].isSelected.value,
                        );
                      }),
                      const Divider(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
