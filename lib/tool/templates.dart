import 'package:component_creator/utils/string_utils.dart';

class Templates {
  /// Template StatefulWidget component
  static String statefulWidget(
    String className,
    String snakeFileName, [
    List<String>? customVariants,
  ]) {
    final hasVariants = customVariants?.isNotEmpty ?? false;

    final variantField =
        hasVariants
            ? '''
  final ${className}Variants variant;
'''
            : '';

    final variantParameter =
        hasVariants
            ? '''
    this.variant = ${className}Variants.primary,
'''
            : '';

    return '''import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';

class $className extends StatefulWidget {
$variantField
  const $className({
    super.key,$variantParameter
  });

  @override
  State<$className> createState() => _${className}State();
}

class _${className}State extends DSStateBase<$className> {
  late ${className}Theme componentTheme = theme
      .extension<${className}ThemeExtension>()!
      .${className.camelCase}Theme;

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

  static String themeExtensionFileContent(
    String className, [
    List<String>? customVariants,
  ]) {
    final variants = customVariants ?? [];
    final hasVariants = variants.isNotEmpty;
    final variantsString =
        hasVariants ? variants.map((v) => '  $v,').join('\n') : '';

    final enumSection =
        hasVariants
            ? '''
enum ${className}Variants {
$variantsString
}

'''
            : '';

    return '''
part of '../../ds_theme.dart';

$enumSection
class ${className}ThemeExtension extends ThemeExtension<${className}ThemeExtension> {
  ${className}Theme get ${className.camelCase}Theme => ${className}Theme(
        // TODO: Configure theme properties for $className component
      );

  @override
  ThemeExtension<${className}ThemeExtension> copyWith() {
    return ${className}ThemeExtension();
  }

  @override
  ThemeExtension<${className}ThemeExtension> lerp(
    covariant ThemeExtension<${className}ThemeExtension>? other,
    double t,
  ) {
    return ${className}ThemeExtension();
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
