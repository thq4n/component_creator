import 'package:component_creator/utils/string_utils.dart';

class Templates {
  /// Template StatefulWidget component
  static String statefulWidget(String className, String snakeFileName) {
    return '''
import '../../theme/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:design_system_project/base/ds_base.dart';

class $className extends StatefulWidget {
  const $className({super.key});

  @override
  State<$className> createState() => _${className}State();
}

class _${className}State extends DSStateBase<$className> {
  late ${className}Theme componentTheme =
      theme.extension<${className}ThemeExt>()!.${className.camelCase}Theme;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
''';
  }

  /// Template theme class
  static String themeClass(String className) {
    return '''
class ${className}Theme {
  // TODO: Define theme properties for $className component
}
''';
  }

  static String themeFileContent(String className) {
    return '''
part of '../../ds_theme.dart';

class ${className}Theme {
  // TODO: Define theme properties for $className component
}
''';
  }

  static String themeExtensionFileContent(String className) {
    return '''
part of '../../ds_theme.dart';

class ${className}ThemeExt extends ThemeExtension<${className}ThemeExt> {
  final ${className}Theme ${className.camelCase}Theme = ${className}Theme();

  @override
  ThemeExtension<${className}ThemeExt> copyWith() {
    return ${className}ThemeExt();
  }

  @override
  ThemeExtension<${className}ThemeExt> lerp(
    covariant ThemeExtension<${className}ThemeExt>? other,
    double t,
  ) {
    return ${className}ThemeExt();
  }
}
''';
  }

  /// Nội dung mặc định cho file lib/theme/ds_theme.dart
  static String baseDsThemeFileContent() => '''
import 'package:flutter/material.dart';

// Core imports
import '../constants/constants.dart';
import '../design_system_core/ds_color/ds_colors_core.dart';
import '../gen/fonts.gen.dart';

// Base theme components
part 'base/app_theme/ds_app_theme.dart';
part 'base/color_scheme/ds_color_scheme.dart';
part 'base/typography/ds_text_theme.dart';

// Theme extensions
part 'extensions/typography/ds_text_theme.ext.dart';
part 'extensions/color/ds_color_theme.ext.dart';

// Component Theme
''';
}
