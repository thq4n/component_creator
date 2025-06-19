extension StringUtils on String {
  /// Chuyển đổi chuỗi sang định dạng snake_case.
  /// Ví dụ: "helloWorld" -> "hello_world", "MyAwesomeClass" -> "my_awesome_class"
  String get snakeCase {
    if (isEmpty) return this;

    // Chuyển PascalCase/camelCase sang snake_case (thêm _ trước chữ hoa)
    String result = replaceAllMapped(
      RegExp(r'(?<=[a-z])([A-Z])'),
      (match) => '_${match.group(1)!.toLowerCase()}',
    );

    // Xử lý các trường hợp khác như dấu cách, gạch ngang thành gạch dưới
    result = result.replaceAll(RegExp(r'[ -]'), '_');

    // Chuyển toàn bộ thành chữ thường và loại bỏ nhiều dấu gạch dưới liên tiếp
    return result.toLowerCase().replaceAll(RegExp(r'_+'), '_');
  }

  /// Chuyển đổi chuỗi sang định dạng camelCase.
  /// Ví dụ: "hello_world" -> "helloWorld", "MyAwesomeClass" -> "myAwesomeClass"
  String get camelCase {
    if (isEmpty) return this;

    // Chuyển đổi từ snake_case/kebab-case
    String result = replaceAllMapped(
      RegExp(r'[_-](.)'),
      (match) => match.group(1)!.toUpperCase(),
    );

    // Chuyển chữ cái đầu tiên thành thường nếu không phải là số/ký tự đặc biệt
    if (result.isNotEmpty &&
        result[0].toUpperCase() == result[0] &&
        !RegExp(r'[0-9]').hasMatch(result[0])) {
      return result[0].toLowerCase() + result.substring(1);
    }
    return result;
  }

  /// Chuyển đổi chuỗi sang định dạng PascalCase.
  /// Ví dụ: "hello_world" -> "HelloWorld", "helloWorld" -> "HelloWorld"
  String get pascalCase {
    if (isEmpty) return this;

    // Chuyển đổi từ snake_case/kebab-case sang camelCase trước
    String tempCamel = replaceAllMapped(
      RegExp(r'[_-](.)'),
      (match) => match.group(1)!.toUpperCase(),
    );

    // Chuyển chữ cái đầu tiên thành hoa
    return tempCamel[0].toUpperCase() + tempCamel.substring(1);
  }

  /// Chuyển đổi chuỗi sang định dạng kebab-case.
  /// Ví dụ: "helloWorld" -> "hello-world", "my_awesome_class" -> "my-awesome-class"
  String get kebabCase {
    if (isEmpty) return this;

    // Chuyển PascalCase/camelCase sang kebab-case (thêm - trước chữ hoa)
    String result = replaceAllMapped(
      RegExp(r'(?<=[a-z])([A-Z])'),
      (match) => '-${match.group(1)!.toLowerCase()}',
    );

    // Xử lý các trường hợp khác như dấu cách, gạch dưới thành gạch ngang
    result = result.replaceAll(RegExp(r'[_ ]'), '-');

    // Chuyển toàn bộ thành chữ thường và loại bỏ nhiều dấu gạch ngang liên tiếp
    return result.toLowerCase().replaceAll(RegExp(r'-+'), '-');
  }
}
