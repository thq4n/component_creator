# Usage Guide

This guide provides detailed instructions on how to use the Component Creator tool effectively.

## Table of Contents

- [Getting Started](#getting-started)
- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Examples](#examples)

## Getting Started

### Prerequisites

Before using the Component Creator tool, ensure you have:

1. **Dart SDK** (>= 3.7.2) installed
2. **Flutter SDK** installed
3. A **Flutter project** with design system structure
4. The tool installed (see [Installation](../README.md#installation))

### Project Structure Requirements

Your Flutter project should have the following structure:

```
your_flutter_project/
├── lib/
│   ├── components/                     # Component widgets (will be created)
│   ├── theme/
│   │   ├── ds_theme.dart               # Main theme file (will be created/updated)
│   │   ├── base/
│   │   │   └── app_theme/
│   │   │       └── ds_app_theme.dart   # App theme configuration
│   │   └── components/                 # Component themes (will be created)
│   └── constants/
│       └── constants.dart              # Design system constants
├── pubspec.yaml
└── ...
```

### Required Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  design_system_project: ^1.0.0  # Your design system package
```

## Basic Usage

### Interactive Mode

Run the tool without arguments to enter interactive mode:

```bash
component_creator
```

The tool will prompt you for a component name:

```
Vui lòng nhập tên component: Button
```

### Direct Mode

Provide the component name as a command line argument:

```bash
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### What Happens When You Run the Tool

1. **Input Validation**: The tool validates the component name
2. **Name Conversion**: Converts the name to appropriate naming conventions
3. **Directory Creation**: Creates necessary directories
4. **File Generation**: Generates all required files
5. **Theme Integration**: Updates theme files
6. **Code Formatting**: Formats all generated code

### Output

After running the tool, you'll see output like this:

```
Tạo file component widget: lib/components/ds_button/ds_button.dart
Tạo file theme: lib/theme/components/ds_button/ds_button_theme.dart
Tạo file theme extension: lib/theme/components/ds_button/ds_button_theme.ext.dart
Cập nhật file lib/theme/ds_theme.dart với các part mới
Đã thêm DSButtonExtension() vào extensions trong ds_app_theme.dart
Đã format code trong thư mục lib.
```

## Advanced Usage

### Naming Conventions

The tool automatically handles naming conventions:

| Input | Component Class | File Name | Theme Class | Theme Extension |
|-------|----------------|-----------|-------------|-----------------|
| `Button` | `DSButton` | `ds_button.dart` | `DSButtonTheme` | `DSButtonThemeExt` |
| `CustomCard` | `DSCustomCard` | `ds_custom_card.dart` | `DSCustomCardTheme` | `DSCustomCardThemeExt` |
| `MyAwesomeWidget` | `DSMyAwesomeWidget` | `ds_my_awesome_widget.dart` | `DSMyAwesomeWidgetTheme` | `DSMyAwesomeWidgetThemeExt` |

### Generated File Structure

For a component named "Button", the tool creates:

```
lib/
├── components/
│   └── ds_button/
│       └── ds_button.dart              # Main component widget
└── theme/
    ├── ds_theme.dart                   # Updated with new parts
    ├── base/
    │   └── app_theme/
    │       └── ds_app_theme.dart       # Updated with extensions
    └── components/
        └── ds_button/
            ├── ds_button_theme.dart    # Theme class
            └── ds_button_theme.ext.dart # Theme extension
```

### Customizing Generated Code

After generation, you can customize the generated files:

#### Component Widget (`ds_button.dart`)

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
    // Customize your component here
    return Container();
  }
}
```

#### Theme File (`ds_button_theme.dart`)

```dart
part of '../../ds_theme.dart';

class DSButtonTheme {
  // Define your theme properties here
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  
  const DSButtonTheme({
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
  });
}
```

#### Theme Extension (`ds_button_theme.ext.dart`)

```dart
part of '../../ds_theme.dart';

class DSButtonThemeExt extends ThemeExtension<DSButtonThemeExt> {
  final DSButtonTheme dSButtonTheme = const DSButtonTheme();

  @override
  ThemeExtension<DSButtonThemeExt> copyWith({
    DSButtonTheme? dSButtonTheme,
  }) {
    return DSButtonThemeExt(
      dSButtonTheme: dSButtonTheme ?? this.dSButtonTheme,
    );
  }

  @override
  ThemeExtension<DSButtonThemeExt> lerp(
    covariant ThemeExtension<DSButtonThemeExt>? other,
    double t,
  ) {
    if (other is! DSButtonThemeExt) return this;
    return DSButtonThemeExt(
      dSButtonTheme: DSButtonTheme(
        backgroundColor: Color.lerp(
          this.dSButtonTheme.backgroundColor,
          other.dSButtonTheme.backgroundColor,
          t,
        )!,
        textColor: Color.lerp(
          this.dSButtonTheme.textColor,
          other.dSButtonTheme.textColor,
          t,
        )!,
        borderRadius: lerpDouble(
          this.dSButtonTheme.borderRadius,
          other.dSButtonTheme.borderRadius,
          t,
        )!,
      ),
    );
  }
}
```

## Best Practices

### Component Naming

- Use **PascalCase** for component names (e.g., `Button`, `CustomCard`)
- Avoid special characters and spaces
- Use descriptive names that clearly indicate the component's purpose
- Keep names concise but meaningful

### File Organization

- Keep generated files in their designated directories
- Don't manually modify the generated file structure
- Use the tool for all component creation to maintain consistency

### Theme Integration

- Always define theme properties in the generated theme class
- Use the `copyWith` and `lerp` methods for theme customization
- Follow your design system's color and spacing guidelines

### Code Customization

- Start with the generated template and customize as needed
- Maintain the basic structure for consistency
- Add proper documentation and comments
- Follow Flutter best practices for widget implementation

### Error Handling

- Check error messages carefully for specific guidance
- Verify your project structure matches requirements
- Ensure all dependencies are properly installed
- Test generated components before using in production

## Troubleshooting

### Common Issues and Solutions

#### 1. "File ds_app_theme.dart không tồn tại"

**Problem**: The required theme file doesn't exist.

**Solution**:
```bash
# Create the required directory structure
mkdir -p lib/theme/base/app_theme

# Create the ds_app_theme.dart file
touch lib/theme/base/app_theme/ds_app_theme.dart
```

**Basic ds_app_theme.dart content**:
```dart
import 'package:flutter/material.dart';

class DSAppTheme {
  final List<ThemeExtension> extensions;
  
  const DSAppTheme({
    this.extensions = const [],
  });
}
```

#### 2. "Lỗi khi format code"

**Problem**: Dart formatter is not working properly.

**Solution**:
```bash
# Check if dart is in your PATH
which dart

# Try formatting manually
dart format lib

# Install dart if needed
# Follow Dart installation guide for your platform
```

#### 3. "Tên component không được để trống"

**Problem**: No component name provided.

**Solution**:
```bash
# Provide a component name
component_creator Button

# Or use interactive mode and enter a name when prompted
component_creator
# Then enter: Button
```

#### 4. Generated files don't compile

**Problem**: Missing dependencies or incorrect imports.

**Solution**:
1. Check your `pubspec.yaml` for required dependencies
2. Run `flutter pub get` to install dependencies
3. Verify import paths in generated files
4. Check that your design system package is properly configured

### Debug Mode

For detailed debugging information, you can modify the tool to add more verbose logging:

```dart
// In component_creator.dart, add debug prints
print('Debug: Creating component with name: $className');
print('Debug: Snake case name: $snakeName');
```

## Examples

### Example 1: Creating a Simple Button Component

```bash
component_creator Button
```

**Generated Component**:
```dart
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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: componentTheme.backgroundColor,
        foregroundColor: componentTheme.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(componentTheme.borderRadius),
        ),
      ),
      onPressed: () {},
      child: const Text('Button'),
    );
  }
}
```

### Example 2: Creating a Card Component

```bash
component_creator Card
```

**Customized Theme**:
```dart
class DSCardTheme {
  final Color backgroundColor;
  final double elevation;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  
  const DSCardTheme({
    this.backgroundColor = Colors.white,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
  });
}
```

### Example 3: Creating a Custom Widget

```bash
component_creator "Custom Avatar"
```

**Generated Structure**:
```
lib/
├── components/
│   └── ds_custom_avatar/
│       └── ds_custom_avatar.dart
└── theme/
    └── components/
        └── ds_custom_avatar/
            ├── ds_custom_avatar_theme.dart
            └── ds_custom_avatar_theme.ext.dart
```

### Integration with Existing Projects

To integrate the tool with an existing Flutter project:

1. **Install the tool**:
```bash
dart pub global activate component_creator
```

2. **Verify project structure**:
```bash
ls lib/theme/base/app_theme/
```

3. **Create your first component**:
```bash
component_creator MyFirstComponent
```

4. **Customize the generated code**:
   - Add properties to the theme class
   - Implement the widget's build method
   - Add proper documentation

5. **Test the component**:
```dart
// In your app
DSMyFirstComponent()
```

### Batch Component Creation

For creating multiple components at once, you can create a simple script:

```bash
#!/bin/bash
# create_components.sh

components=("Button" "Card" "Avatar" "Input" "Modal")

for component in "${components[@]}"; do
  echo "Creating component: $component"
  component_creator "$component"
done
```

Run the script:
```bash
chmod +x create_components.sh
./create_components.sh
```

This comprehensive usage guide should help you effectively use the Component Creator tool in your Flutter projects. 