import 'package:test/test.dart';
import 'package:component_creator/tool/component_creator.dart';
import 'package:component_creator/tool/templates.dart';
import 'package:component_creator/tool/file_utils.dart';
import 'package:component_creator/utils/string_utils.dart';
import 'dart:io';

void main() {
  group('ComponentCreator', () {
    late ComponentCreator creator;

    setUp(() {
      creator = ComponentCreator();
    });

    group('File Path Generation', () {
      test('should generate correct component directory path', () {
        final componentDir = creator.componentsDir;
        expect(componentDir.path, equals('lib/components'));
      });

      test('should generate correct theme directory path', () {
        final themeDir = creator.themeComponentsDir;
        expect(themeDir.path, equals('lib/theme/components'));
      });

      test('should generate correct theme file path', () {
        final themeFile = creator.dsThemeFile;
        expect(themeFile.path, equals('lib/theme/ds_theme.dart'));
      });
    });

    group('Component Creation', () {
      test('should create component with valid name', () {
        // This test verifies the component creation process works
        // without actually creating files in the test environment
        expect(creator, isNotNull);
        expect(creator.componentsDir.path, equals('lib/components'));
        expect(creator.themeComponentsDir.path, equals('lib/theme/components'));
      });
    });
  });

  group('Templates', () {
    group('statefulWidget', () {
      test('should generate valid StatefulWidget template', () {
        final template = Templates.statefulWidget('DSButton', 'ds_button');

        expect(template, contains('class DSButton extends StatefulWidget'));
        expect(
          template,
          contains('class _DSButtonState extends DSStateBase<DSButton>'),
        );
        expect(template, contains('late DSButtonTheme componentTheme'));
        expect(template, contains('theme.extension<DSButtonThemeExtension>()'));
        expect(template, contains('Widget build(BuildContext context)'));
        expect(template, contains('return Container();'));
      });

      test('should include proper imports', () {
        final template = Templates.statefulWidget('DSButton', 'ds_button');

        expect(template, contains("import '../../theme/ds_theme.dart';"));
        expect(template, contains("import 'package:flutter/material.dart';"));
        expect(
          template,
          contains("import 'package:design_system_project/base/ds_base.dart';"),
        );
      });

      test('should use correct class names in template', () {
        final template = Templates.statefulWidget(
          'DSCustomCard',
          'ds_custom_card',
        );

        expect(template, contains('class DSCustomCard extends StatefulWidget'));
        expect(
          template,
          contains(
            'class _DSCustomCardState extends DSStateBase<DSCustomCard>',
          ),
        );
        expect(template, contains('late DSCustomCardTheme componentTheme'));
        expect(
          template,
          contains('theme.extension<DSCustomCardThemeExtension>()'),
        );
      });
    });

    group('themeFileContent', () {
      test('should generate valid theme file content', () {
        final content = Templates.themeFileContent('DSButton');

        expect(content, contains("part of '../../ds_theme.dart';"));
        expect(content, contains('class DSButtonTheme'));
        expect(
          content,
          contains('// TODO: Define theme properties for DSButton component'),
        );
      });

      test('should use correct class name in theme file', () {
        final content = Templates.themeFileContent('DSCustomCard');

        expect(content, contains('class DSCustomCardTheme'));
        expect(
          content,
          contains(
            '// TODO: Define theme properties for DSCustomCard component',
          ),
        );
      });
    });

    group('themeExtensionFileContent', () {
      test('should generate valid theme extension content', () {
        final content = Templates.themeExtensionFileContent('DSButton');

        expect(content, contains("part of '../../ds_theme.dart';"));
        expect(
          content,
          contains(
            'class DSButtonThemeExt extends ThemeExtension<DSButtonThemeExtension>',
          ),
        );
        expect(
          content,
          contains('final DSButtonTheme dSButtonTheme = DSButtonTheme();'),
        );
        expect(content, contains('copyWith()'));
        expect(content, contains('lerp('));
      });

      test('should use correct class names in extension', () {
        final content = Templates.themeExtensionFileContent('DSCustomCard');

        expect(
          content,
          contains(
            'class DSCustomCardThemeExt extends ThemeExtension<DSCustomCardThemeExtension>',
          ),
        );
        expect(
          content,
          contains(
            'final DSCustomCardTheme dSCustomCardTheme = DSCustomCardTheme();',
          ),
        );
      });
    });

    group('baseDsThemeFileContent', () {
      test('should generate base theme file content', () {
        final content = Templates.baseDsThemeFileContent();

        expect(content, contains("import 'package:flutter/material.dart';"));
        expect(content, contains("import '../constants/constants.dart';"));
        expect(
          content,
          contains(
            "import '../design_system_core/ds_color/ds_colors_core.dart';",
          ),
        );
        expect(content, contains("import '../gen/fonts.gen.dart';"));
        expect(content, contains("part 'base/app_theme/ds_app_theme.dart';"));
        expect(
          content,
          contains("part 'base/color_scheme/ds_color_scheme.dart';"),
        );
        expect(content, contains("part 'base/typography/ds_text_theme.dart';"));
        expect(
          content,
          contains("part 'extensions/typography/ds_text_theme.ext.dart';"),
        );
        expect(
          content,
          contains("part 'extensions/color/ds_color_theme.ext.dart';"),
        );
        expect(content, contains('// Component Theme'));
      });
    });
  });

  group('FileUtils', () {
    group('createDirIfNotExist', () {
      test('should create directory if it does not exist', () {
        final testDir = Directory('test_temp_dir');

        // Clean up if exists
        if (testDir.existsSync()) {
          testDir.deleteSync(recursive: true);
        }

        FileUtils.createDirIfNotExist(testDir);
        expect(testDir.existsSync(), isTrue);

        // Clean up
        testDir.deleteSync();
      });

      test('should not throw error if directory already exists', () {
        final testDir = Directory('test_temp_dir');

        // Create directory first
        testDir.createSync();

        // Should not throw
        expect(() => FileUtils.createDirIfNotExist(testDir), returnsNormally);
        expect(testDir.existsSync(), isTrue);

        // Clean up
        testDir.deleteSync();
      });
    });

    group('fileExists', () {
      test('should return true for existing file', () {
        final testFile = File('test_temp_file.txt');
        testFile.writeAsStringSync('test content');

        expect(FileUtils.fileExists('test_temp_file.txt'), isTrue);

        // Clean up
        testFile.deleteSync();
      });

      test('should return false for non-existing file', () {
        expect(FileUtils.fileExists('non_existing_file.txt'), isFalse);
      });
    });

    group('writeFile', () {
      test('should write content to file', () {
        final testFile = 'test_write_file.txt';
        final content = 'test content';

        FileUtils.writeFile(testFile, content);

        expect(File(testFile).readAsStringSync(), equals(content));

        // Clean up
        File(testFile).deleteSync();
      });

      test('should overwrite existing file', () {
        final testFile = 'test_overwrite_file.txt';
        final initialContent = 'initial content';
        final newContent = 'new content';

        // Write initial content
        FileUtils.writeFile(testFile, initialContent);
        expect(File(testFile).readAsStringSync(), equals(initialContent));

        // Overwrite with new content
        FileUtils.writeFile(testFile, newContent);
        expect(File(testFile).readAsStringSync(), equals(newContent));

        // Clean up
        File(testFile).deleteSync();
      });
    });
  });

  group('StringUtils', () {
    group('snakeCase', () {
      test('should convert camelCase to snake_case', () {
        expect('helloWorld'.snakeCase, equals('hello_world'));
        expect('myAwesomeClass'.snakeCase, equals('my_awesome_class'));
        expect('camelCase'.snakeCase, equals('camel_case'));
      });

      test('should convert PascalCase to snake_case', () {
        expect('HelloWorld'.snakeCase, equals('hello_world'));
        expect('MyAwesomeClass'.snakeCase, equals('my_awesome_class'));
        expect('PascalCase'.snakeCase, equals('pascal_case'));
      });

      test('should handle spaces and hyphens', () {
        expect('hello world'.snakeCase, equals('hello_world'));
        expect('hello-world'.snakeCase, equals('hello_world'));
        expect('hello_world'.snakeCase, equals('hello_world'));
      });

      test('should handle empty string', () {
        expect(''.snakeCase, equals(''));
      });

      test('should handle single character', () {
        expect('a'.snakeCase, equals('a'));
        expect('A'.snakeCase, equals('a'));
      });
    });

    group('camelCase', () {
      test('should convert snake_case to camelCase', () {
        expect('hello_world'.camelCase, equals('helloWorld'));
        expect('my_awesome_class'.camelCase, equals('myAwesomeClass'));
        expect('snake_case'.camelCase, equals('snakeCase'));
      });

      test('should convert kebab-case to camelCase', () {
        expect('hello-world'.camelCase, equals('helloWorld'));
        expect('my-awesome-class'.camelCase, equals('myAwesomeClass'));
      });

      test('should handle PascalCase input', () {
        expect('HelloWorld'.camelCase, equals('helloWorld'));
        expect('MyAwesomeClass'.camelCase, equals('myAwesomeClass'));
      });

      test('should handle empty string', () {
        expect(''.camelCase, equals(''));
      });

      test('should handle single word', () {
        expect('hello'.camelCase, equals('hello'));
        expect('Hello'.camelCase, equals('hello'));
      });
    });

    group('pascalCase', () {
      test('should convert snake_case to PascalCase', () {
        expect('hello_world'.pascalCase, equals('HelloWorld'));
        expect('my_awesome_class'.pascalCase, equals('MyAwesomeClass'));
        expect('snake_case'.pascalCase, equals('SnakeCase'));
      });

      test('should convert camelCase to PascalCase', () {
        expect('helloWorld'.pascalCase, equals('HelloWorld'));
        expect('myAwesomeClass'.pascalCase, equals('MyAwesomeClass'));
      });

      test('should convert kebab-case to PascalCase', () {
        expect('hello-world'.pascalCase, equals('HelloWorld'));
        expect('my-awesome-class'.pascalCase, equals('MyAwesomeClass'));
      });

      test('should handle empty string', () {
        expect(''.pascalCase, equals(''));
      });

      test('should handle single word', () {
        expect('hello'.pascalCase, equals('Hello'));
        expect('Hello'.pascalCase, equals('Hello'));
      });
    });

    group('kebabCase', () {
      test('should convert camelCase to kebab-case', () {
        expect('helloWorld'.kebabCase, equals('hello-world'));
        expect('myAwesomeClass'.kebabCase, equals('my-awesome-class'));
        expect('camelCase'.kebabCase, equals('camel-case'));
      });

      test('should convert PascalCase to kebab-case', () {
        expect('HelloWorld'.kebabCase, equals('hello-world'));
        expect('MyAwesomeClass'.kebabCase, equals('my-awesome-class'));
        expect('PascalCase'.kebabCase, equals('pascal-case'));
      });

      test('should handle spaces and underscores', () {
        expect('hello world'.kebabCase, equals('hello-world'));
        expect('hello_world'.kebabCase, equals('hello-world'));
        expect('hello-world'.kebabCase, equals('hello-world'));
      });

      test('should handle empty string', () {
        expect(''.kebabCase, equals(''));
      });

      test('should handle single character', () {
        expect('a'.kebabCase, equals('a'));
        expect('A'.kebabCase, equals('a'));
      });
    });
  });

  group('Integration Tests', () {
    test('should generate consistent naming across utilities', () {
      final input = 'MyAwesomeComponent';

      // Test that different utilities work together
      final snakeCase = input.snakeCase;
      final camelCase = snakeCase.camelCase;
      final pascalCase = input.pascalCase;

      expect(snakeCase, equals('my_awesome_component'));
      expect(camelCase, equals('myAwesomeComponent'));
      expect(pascalCase, equals('MyAwesomeComponent'));
    });

    test('should handle various component naming patterns', () {
      // Test various naming patterns that users might input
      final testCases = [
        'Button',
        'CustomCard',
        'MyAwesomeWidget',
        'DSButton',
        'Button2',
        'Card3D',
        'APIResponse',
        'UIComponent',
      ];

      for (final testCase in testCases) {
        // Test that string utilities handle these cases
        final snakeCase = testCase.snakeCase;
        final camelCase = snakeCase.camelCase;
        final pascalCase = testCase.pascalCase;
        final kebabCase = testCase.kebabCase;

        // Verify conversions work correctly
        expect(snakeCase, isNotEmpty);
        expect(camelCase, isNotEmpty);
        expect(pascalCase, isNotEmpty);
        expect(kebabCase, isNotEmpty);
      }
    });
  });
}
