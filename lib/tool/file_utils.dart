import 'dart:io';

class FileUtils {
  /// Tạo thư mục nếu chưa tồn tại
  static void createDirIfNotExist(Directory dir) {
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  /// Kiểm tra file có tồn tại hay không
  static bool fileExists(String path) {
    return File(path).existsSync();
  }

  /// Ghi chuỗi vào file (tạo mới hoặc ghi đè)
  static void writeFile(String path, String content) {
    File(path).writeAsStringSync(content);
  }

  /// Format code
  static void formatCode() {
    final result = Process.runSync('dart', ['format', 'lib']);
    if (result.exitCode == 0) {
      print('Format code thành công.');
    } else {
      print('Format code lỗi: ${result.stderr}');
    }
  }
}
