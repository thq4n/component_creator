# Component Creator

A powerful CLI tool for automatically generating Flutter components with integrated design system theming. This tool streamlines the process of creating new Flutter widgets by generating all necessary files including the component widget, theme files, and proper integration with your design system.

## 🚀 Features

- **Automated Component Generation**: Create complete Flutter components with a single command
- **Design System Integration**: Automatically generates theme files and integrates with your design system
- **File Structure Management**: Creates organized directory structures for components and themes
- **Code Formatting**: Automatically formats generated code using Dart formatter
- **Smart Naming Conventions**: Converts component names to proper naming conventions (PascalCase, snake_case, camelCase)
- **Theme Extension Support**: Generates theme extensions for easy theming integration
- **Error Handling**: Comprehensive error handling with informative messages

## 📋 Prerequisites

- Dart SDK >= 3.7.2
- Flutter SDK
- A Flutter project with design system structure

## 🛠️ Installation

### From Source

1. Clone the repository:
```bash
git clone <repository-url>
cd component_creator
```

2. Install dependencies:
```bash
dart pub get
```

3. Make the tool executable:
```bash
dart pub global activate --source path .
```

### Global Installation

```bash
dart pub global activate component_creator
```

## 🎯 Usage

### Basic Usage

```bash
# Interactive mode - tool will prompt for component name
component_creator

# Direct mode - provide component name as argument
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### What Gets Generated

When you run the tool with a component name (e.g., `Button`), it creates:

1. **Component Widget**: `lib/components/ds_button/ds_button.dart`
2. **Theme File**: `lib/theme/components/ds_button/ds_button_theme.dart`
3. **Theme Extension**: `lib/theme/components/ds_button/ds_button_theme.ext.dart`
4. **Theme Integration**: Updates `lib/theme/ds_theme.dart` with part directives
5. **App Theme Integration**: Updates `lib/theme/base/app_theme/ds_app_theme.dart` with extensions

### Generated File Structure

```
lib/
├── components/
│   └── ds_button/
│       └── ds_button.dart
└── theme/
    ├── ds_theme.dart (updated)
    ├── base/
    │   └── app_theme/
    │       └── ds_app_theme.dart (updated)
    └── components/
        └── ds_button/
            ├── ds_button_theme.dart
            └── ds_button_theme.ext.dart
```

## 🏗️ Architecture

### Core Components

- **`ComponentCreator`**: Main orchestrator class that coordinates the component generation process
- **`Templates`**: Contains all template strings for generating different file types
- **`FileUtils`**: Utility class for file and directory operations
- **`StringUtils`**: Extension methods for string manipulation and case conversion

### File Generation Process

1. **Input Processing**: Validates and processes the component name
2. **Directory Creation**: Creates necessary directories if they don't exist
3. **File Generation**: Generates component widget, theme files, and extensions
4. **Integration**: Updates existing theme files to include new components
5. **Code Formatting**: Formats all generated code using Dart formatter

### Naming Conventions

The tool automatically converts component names to appropriate naming conventions:

- **Component Class**: `DS{ComponentName}` (e.g., `DSButton`)
- **File Names**: `ds_{component_name}` (e.g., `ds_button.dart`)
- **Theme Class**: `{ComponentName}Theme` (e.g., `ButtonTheme`)
- **Theme Extension**: `{ComponentName}ThemeExt` (e.g., `ButtonThemeExt`)

## 📁 Project Structure

```
component_creator/
├── bin/
│   └── component_creator.dart          # CLI entry point
├── lib/
│   ├── tool/
│   │   ├── component_creator.dart      # Main component creator logic
│   │   ├── templates.dart              # Template definitions
│   │   └── file_utils.dart             # File utility functions
│   └── utils/
│       └── string_utils.dart           # String manipulation utilities
├── test/
│   └── component_creator_test.dart     # Test files
├── example/                            # Example Flutter project
└── pubspec.yaml                        # Package configuration
```

## 🔧 Configuration

### Design System Structure

The tool expects your Flutter project to have the following structure:

```
lib/
├── components/                         # Component widgets
├── theme/
│   ├── ds_theme.dart                   # Main theme file
│   ├── base/
│   │   └── app_theme/
│   │       └── ds_app_theme.dart       # App theme configuration
│   └── components/                     # Component themes
└── constants/
    └── constants.dart                  # Design system constants
```

### Required Dependencies

Your Flutter project should include these dependencies for the generated components:

```yaml
dependencies:
  flutter:
    sdk: flutter
  design_system_project: ^1.0.0  # Your design system package
```

## 🧪 Testing

Run the test suite:

```bash
dart test
```

## 📝 Generated Code Examples

### Component Widget Template

```dart
import '../../theme/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:design_system_project/base/ds_base.dart';

class DSButton extends StatefulWidget {
  const DSButton({super.key});

  @override
  State<DSButton> createState() => _DSButtonState();
}

class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExt>()!.dSButtonTheme;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Theme File Template

```dart
part of '../../ds_theme.dart';

class DSButtonTheme {
  // TODO: Define theme properties for DSButton component
}
```

### Theme Extension Template

```dart
part of '../../ds_theme.dart';

class DSButtonThemeExt extends ThemeExtension<DSButtonThemeExt> {
  final DSButtonTheme dSButtonTheme = DSButtonTheme();

  @override
  ThemeExtension<DSButtonThemeExt> copyWith() {
    return DSButtonThemeExt();
  }

  @override
  ThemeExtension<DSButtonThemeExt> lerp(
    covariant ThemeExtension<DSButtonThemeExt>? other,
    double t,
  ) {
    return DSButtonThemeExt();
  }
}
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Troubleshooting

### Common Issues

1. **"File ds_app_theme.dart không tồn tại"**
   - Ensure your project has the correct design system structure
   - Create the missing file or adjust the path in the tool

2. **"Lỗi khi format code"**
   - Make sure Dart SDK is properly installed
   - Check that `dart format` command works in your terminal

3. **"Tên component không được để trống"**
   - Provide a valid component name as an argument
   - Or enter a name when prompted in interactive mode

### Getting Help

If you encounter any issues:

1. Check the error messages for specific guidance
2. Verify your project structure matches the expected design system layout
3. Ensure all required dependencies are installed
4. Open an issue on GitHub with detailed error information

## 🔄 Version History

- **v0.0.1**: Initial release with basic component generation functionality
