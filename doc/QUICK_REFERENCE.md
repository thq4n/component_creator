# Quick Reference Guide

A quick reference for the Component Creator tool with common commands, examples, and troubleshooting tips.

## 🚀 Quick Commands

### Installation
```bash
# Global installation
dart pub global activate component_creator

# From source
git clone https://github.com/your-username/component_creator.git
cd component_creator
dart pub get
dart pub global activate --source path .
```

### Basic Usage
```bash
# Interactive mode
component_creator

# Direct mode
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### Verification
```bash
# Check if tool is installed
component_creator --help

# Test with a simple component
component_creator Test
```

## 📁 Generated File Structure

For a component named "Button":

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
            └── ds_button_theme.ext.dart # Theme extension with variants
```

## 🎨 Component Variants (v0.0.2+)

### Generated Enum
```dart
// Automatically generated in theme extension
enum DSButtonVariants {
  // TODO: Define variants for DSButton component
}
```

### Usage in Component
```dart
class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  
  const DSButton({
    super.key,
    this.variant = DSButtonVariants.primary,
  });
  
  // ... implementation
}
```

### Common Variants
```dart
enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  danger,
  success,
  warning,
}
```

## 📝 Naming Conventions

| Input | Component Class | File Name | Theme Class | Theme Extension |
|-------|----------------|-----------|-------------|-----------------|
| `Button` | `DSButton` | `ds_button.dart` | `DSButtonTheme` | `DSButtonThemeExt` |
| `CustomCard` | `DSCustomCard` | `ds_custom_card.dart` | `DSCustomCardTheme` | `DSCustomCardThemeExt` |
| `MyAwesomeWidget` | `DSMyAwesomeWidget` | `ds_my_awesome_widget.dart` | `DSMyAwesomeWidgetTheme` | `DSMyAwesomeWidgetThemeExt` |

## 🔧 Common Customizations

### Theme Properties
```dart
class DSButtonTheme {
  final Color primaryColor = Colors.blue;
  final Color secondaryColor = Colors.grey;
  final double borderRadius = 8.0;
  final EdgeInsets padding = EdgeInsets.all(16.0);
}
```

### Component Implementation
```dart
@override
Widget build(BuildContext context) {
  return Container(
    padding: componentTheme.padding,
    decoration: BoxDecoration(
      color: componentTheme.backgroundColor,
      borderRadius: BorderRadius.circular(componentTheme.borderRadius),
    ),
    child: child,
  );
}
```

### Variant Styling
```dart
ButtonStyle _getButtonStyle() {
  switch (widget.variant) {
    case DSButtonVariants.primary:
      return ElevatedButton.styleFrom(
        backgroundColor: componentTheme.primaryColor,
      );
    case DSButtonVariants.secondary:
      return ElevatedButton.styleFrom(
        backgroundColor: componentTheme.secondaryColor,
      );
    case DSButtonVariants.outline:
      return OutlinedButton.styleFrom(
        side: BorderSide(color: componentTheme.outlineColor),
      );
  }
}
```

## 🐛 Troubleshooting

### Common Error Messages

| Error Message | Solution |
|---------------|----------|
| `File ds_app_theme.dart không tồn tại` | Create `lib/theme/base/app_theme/ds_app_theme.dart` |
| `Lỗi khi format code` | Run `dart pub global activate dart_style` |
| `Tên component không được để trống` | Provide a component name as argument |
| Import errors | Add `design_system_project` dependency to `pubspec.yaml` |

### Quick Fixes

#### Missing App Theme File
```bash
mkdir -p lib/theme/base/app_theme
touch lib/theme/base/app_theme/ds_app_theme.dart
```

Add content:
```dart
import 'package:flutter/material.dart';

class DSAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      extensions: [],
    );
  }
}
```

#### Missing Dependencies
```yaml
# pubspec.yaml
dependencies:
  design_system_project:
    path: ../design_system_project
```

#### Code Formatting Issues
```bash
dart pub global activate dart_style
dart format lib
```

## 📋 Project Requirements

### Required Files
- `lib/theme/base/app_theme/ds_app_theme.dart` (must exist)
- `lib/theme/ds_theme.dart` (created automatically)

### Required Dependencies
- Dart SDK >= 3.7.2
- Flutter SDK
- `design_system_project` package

### Project Structure
```
your_flutter_project/
├── lib/
│   ├── components/           # Created automatically
│   ├── theme/
│   │   ├── components/       # Created automatically
│   │   ├── base/
│   │   │   └── app_theme/
│   │   │       └── ds_app_theme.dart  # Required
│   │   └── ds_theme.dart     # Created automatically
│   └── main.dart
```

## 🎯 Examples

### Basic Button Component
```bash
component_creator Button
```

Generated component:
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
    return Container();
  }
}
```

### Component with Variants
```dart
class DSButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final DSButtonVariants variant;
  
  const DSButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = DSButtonVariants.primary,
  });

  @override
  State<DSButton> createState() => _DSButtonState();
}
```

### Theme Extension with Variants
```dart
part of '../../ds_theme.dart';

enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
}

class DSButtonTheme {
  final Color primaryColor = Colors.blue;
  final Color secondaryColor = Colors.grey;
  final Color outlineColor = Colors.blue;
  final Color dangerColor = Colors.red;
}

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

## 🔄 Version History

### v0.0.2 (Current)
- ✨ Component variants support
- 🎨 Enhanced theme extensions
- 📝 Improved code organization

### v0.0.1
- 🎉 Initial release
- 🚀 Basic component generation
- 🔧 Theme integration

## 📚 Additional Resources

- **[Usage Guide](USAGE_GUIDE.md)**: Detailed step-by-step instructions
- **[API Documentation](API.md)**: Complete API reference
- **[Contributing Guide](CONTRIBUTING.md)**: How to contribute
- **[Publishing Guide](PUBLISHING.md)**: How to publish updates

## 🆘 Getting Help

- Check error messages for specific guidance
- Verify project structure matches requirements
- Ensure all dependencies are installed
- Open an issue on GitHub with detailed information

---

**Quick Tips:**
- Use descriptive component names
- Keep generated files in their designated directories
- Customize theme properties after generation
- Define variants based on your design system needs
- Test components before using in production 