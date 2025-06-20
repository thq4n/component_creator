import 'dart:io';

import 'file_utils.dart';
import 'templates.dart';

class ComponentCreator {
  final Directory componentsDir = Directory('lib/components');
  final Directory themeComponentsDir = Directory('lib/theme/components');
  final File dsThemeFile = File('lib/theme/ds_theme.dart');

  void run(List<String> args) {
    String? componentName;

    if (args.isNotEmpty) {
      componentName = args[0];
    } else {
      stdout.write('Vui lòng nhập tên component: ');
      componentName = stdin.readLineSync();
      if (componentName == null || componentName.trim().isEmpty) {
        print('Tên component không được để trống.');
        exit(1);
      }
    }

    final rawName = componentName.trim();
    final className = 'DS$rawName';
    final snakeName = _toSnakeCaseWithPrefix(rawName);

    try {
      _createComponentWidget(className, snakeName);
      _createThemeComponent(className, snakeName);
      _updateDsThemeFile(snakeName);
      _updateDsAppThemeExtensions(className);
      _formatCode();
    } catch (e, st) {
      print('Lỗi khi tạo component: $e');
      print(st);
      exit(1);
    }
  }

  void _createComponentWidget(String className, String snakeName) {
    final componentDir = Directory('${componentsDir.path}/$snakeName');
    FileUtils.createDirIfNotExist(componentDir);

    final componentFilePath = '${componentDir.path}/$snakeName.dart';
    if (!FileUtils.fileExists(componentFilePath)) {
      FileUtils.writeFile(
        componentFilePath,
        Templates.statefulWidget(className, snakeName),
      );
      print('Tạo file component widget: $componentFilePath');
    } else {
      print('File component widget đã tồn tại: $componentFilePath');
    }
  }

  void _createThemeComponent(String className, String snakeName) {
    final themeComponentDir = Directory(
      '${themeComponentsDir.path}/$snakeName',
    );
    FileUtils.createDirIfNotExist(themeComponentDir);

    final themeFilePath = '${themeComponentDir.path}/${snakeName}_theme.dart';
    if (!FileUtils.fileExists(themeFilePath)) {
      FileUtils.writeFile(themeFilePath, Templates.themeFileContent(className));
      print('Tạo file theme: $themeFilePath');
    } else {
      print('File theme đã tồn tại: $themeFilePath');
    }

    final themeExtFilePath =
        '${themeComponentDir.path}/${snakeName}_theme.ext.dart';
    if (!FileUtils.fileExists(themeExtFilePath)) {
      FileUtils.writeFile(
        themeExtFilePath,
        Templates.themeExtensionFileContent(className),
      );
      print('Tạo file theme extension: $themeExtFilePath');
    } else {
      print('File theme extension đã tồn tại: $themeExtFilePath');
    }
  }

  void _formatCode() {
    final result = Process.runSync('dart', ['format', 'lib']);
    if (result.exitCode == 0) {
      print('Đã format code trong thư mục lib.');
    } else {
      print('Lỗi khi format code:');
      print(result.stderr);
    }
  }

  String _toSnakeCaseWithPrefix(String input) {
    final buffer = StringBuffer('ds_');
    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      if (char.toUpperCase() == char && i != 0) {
        buffer.write('_');
      }
      buffer.write(char.toLowerCase());
    }
    return buffer.toString();
  }

  void _updateDsThemeFile(String snakeName) {
    final File themeFile = File('lib/theme/ds_theme.dart');

    if (!themeFile.existsSync()) {
      themeFile.createSync(recursive: true);
      themeFile.writeAsStringSync(Templates.baseDsThemeFileContent());
      print('Tạo mới file lib/theme/ds_theme.dart với header mặc định');
    }

    final lines = themeFile.readAsLinesSync();

    final partTheme = "part 'components/$snakeName/${snakeName}_theme.dart';";
    final partExt = "part 'components/$snakeName/${snakeName}_theme.ext.dart';";

    // Tìm comment // Component Theme
    int commentIndex = lines.indexWhere(
      (line) => line.trim() == '// Component Theme',
    );

    if (commentIndex == -1) {
      // Thêm comment lên đầu file (trước phần part)
      lines.insert(0, '// Component Theme');
      commentIndex = 0;
    }

    // Chèn part sau comment
    int insertIndex = commentIndex + 1;

    bool changed = false;

    if (!lines.contains(partTheme)) {
      lines.insert(insertIndex, partTheme);
      insertIndex++;
      changed = true;
    }
    if (!lines.contains(partExt)) {
      lines.insert(insertIndex, partExt);
      changed = true;
    }

    if (changed) {
      themeFile.writeAsStringSync(lines.join('\n'));
      print('Cập nhật file lib/theme/ds_theme.dart với các part mới');
    } else {
      print('File lib/theme/ds_theme.dart đã có đầy đủ part');
    }
  }

  void _updateDsAppThemeExtensions(String className) {
    final File dsAppThemeFile = File(
      'lib/theme/base/app_theme/ds_app_theme.dart',
    );

    if (!dsAppThemeFile.existsSync()) {
      print(
        'File ds_app_theme.dart không tồn tại, không thể cập nhật extensions.',
      );
      return;
    }

    final content = dsAppThemeFile.readAsStringSync();

    // Pattern tìm phần extensions: [ ... ]
    final extensionsPattern = RegExp(
      r'extensions\s*:\s*\[(.*?)\]',
      dotAll: true,
    );

    final match = extensionsPattern.firstMatch(content);
    if (match == null) {
      print('Không tìm thấy phần extensions trong ds_app_theme.dart');
      return;
    }

    final extensionsContent = match.group(1)!;

    // Tạo tên instance extension mới, ví dụ DSMyComponentThemeExtension -> DSMyComponentThemeExtension()
    final extInstanceName = '${className}ThemeExtension()';

    // Kiểm tra xem đã có chưa
    if (extensionsContent.contains(extInstanceName)) {
      print('$extInstanceName đã tồn tại trong extensions');
      return;
    }

    // Chèn thêm instance mới vào cuối mảng extensions
    final updatedExtensions =
        extensionsContent.trim().isEmpty
            ? '  $extInstanceName'
            : '$extensionsContent $extInstanceName,';

    // Thay thế đoạn cũ với đoạn mới
    final updatedContent = content.replaceRange(
      match.start,
      match.end,
      'extensions: [\n$updatedExtensions\n]',
    );

    // Ghi lại file
    dsAppThemeFile.writeAsStringSync(updatedContent);

    print('Đã thêm $extInstanceName vào extensions trong ds_app_theme.dart');
  }
}
