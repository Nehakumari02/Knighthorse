import 'package:flutter/material.dart';

import '../../../../../../base/utils/basic_import.dart';
import '../../../../../../base/widgets/added/card_type_widget.dart';
import 'language_drop_down.dart';

class LanguageChangeWidget extends StatelessWidget {
  const LanguageChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardTypeWidget(
      title: Strings.languageChange,
      description: '',
      icon: Icons.g_translate,
      onTap: () {},
      child: ChangeLanguageWidget(),
    );
  }
}
