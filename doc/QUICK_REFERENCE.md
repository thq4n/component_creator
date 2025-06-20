# Quick Reference

A quick reference guide for the Component Creator tool with all essential commands, examples, and features.

## Table of Contents

- [Installation](#installation)
- [Basic Commands](#basic-commands)
- [Component Variants (v0.0.3+)](#component-variants-v003)
- [Generated Files](#generated-files)
- [Naming Conventions](#naming-conventions)
- [Troubleshooting](#troubleshooting)

## Installation

```bash
# Global installation
dart pub global activate component_creator

# From source
git clone https://github.com/your-username/component_creator.git
cd component_creator
dart pub get
dart pub global activate --source path .
```

## Basic Commands

### Interactive Mode
```bash
component_creator
# Enter component name when prompted
```

### Direct Mode
```bash
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### Verify Installation
```bash
component_creator --help
```

## Component Variants (v0.0.3+)

### Generated Enum with Default Variants
```dart
enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSButton component
}
```

### Component with Automatic Variant Parameter
```dart
class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  const DSButton({super.key, this.variant = DSButtonVariants.primary});
  
  @override
  State<DSButton> createState() => _DSButtonState();
}
```

### Usage Examples
```dart
// Use with specific variant
DSButton(variant: DSButtonVariants.primary)
DSButton(variant: DSButtonVariants.secondary)
DSButton(variant: DSButtonVariants.outline)
DSButton(variant: DSButtonVariants.ghost)

// Use default variant
DSButton() // Automatically uses DSButtonVariants.primary
```

### Adding Custom Variants
```dart
enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  danger,    // Add your custom variants
  success,
  warning,
}
```

## Generated Files

For component `Button`:

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

## Naming Conventions

| Input | Component Class | File Name | Theme Class | Theme Extension |
|-------|----------------|-----------|-------------|-----------------|
| `Button` | `DSButton` | `ds_button.dart` | `DSButtonTheme` | `DSButtonThemeExt` |
| `CustomCard` | `DSCustomCard` | `ds_custom_card.dart` | `DSCustomCardTheme` | `DSCustomCardThemeExt` |
| `MyAwesomeWidget` | `DSMyAwesomeWidget` | `ds_my_awesome_widget.dart` | `DSMyAwesomeWidgetTheme` | `DSMyAwesomeWidgetThemeExt` |

## Project Structure Requirements

```
your_flutter_project/
├── lib/
│   ├── components/           # Component widgets (auto-created)
│   ├── theme/
│   │   ├── components/       # Component themes (auto-created)
│   │   ├── base/
│   │   │   └── app_theme/
│   │   │       └── ds_app_theme.dart  # Required file
│   │   └── ds_theme.dart     # Main theme file (auto-created)
│   └── main.dart
```

## Required Files

### App Theme File
```dart
// lib/theme/base/app_theme/ds_app_theme.dart
import 'package:flutter/material.dart';

class DSAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      extensions: [
        // Component theme extensions will be added here with proper formatting
      ],
    );
  }
}
```

## Generated Code Examples

### Component Widget Template
```dart
import '../../theme/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:design_system_project/base/ds_base.dart';

class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  const DSButton({super.key, this.variant = DSButtonVariants.primary});

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

### Theme Extension Template (v0.0.3+)
```dart
part of '../../ds_theme.dart';

enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSButton component
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

### Theme Class Template
```dart
part of '../../ds_theme.dart';

class DSButtonTheme {
  // TODO: Define theme properties for DSButton component
}
```

## Customization Examples

### Adding Theme Properties
```dart
class DSButtonTheme {
  final Color backgroundColor = Colors.blue;
  final double borderRadius = 8.0;
  final EdgeInsets padding = EdgeInsets.all(16.0);
  final Color textColor = Colors.white;
}
```

### Implementing Component Logic
```dart
@override
Widget build(BuildContext context) {
  return Container(
    padding: componentTheme.padding,
    decoration: BoxDecoration(
      color: componentTheme.backgroundColor,
      borderRadius: BorderRadius.circular(componentTheme.borderRadius),
    ),
    child: Text(
      'Button',
      style: TextStyle(color: componentTheme.textColor),
    ),
  );
}
```

### Variant-Specific Styling
```dart
Widget _buildButton() {
  switch (widget.variant) {
    case DSButtonVariants.primary:
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: componentTheme.primaryColor,
        ),
        onPressed: () {},
        child: Text('Primary'),
      );
    case DSButtonVariants.secondary:
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: componentTheme.secondaryColor,
        ),
        onPressed: () {},
        child: Text('Secondary'),
      );
    case DSButtonVariants.outline:
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: componentTheme.outlineColor),
        ),
        onPressed: () {},
        child: Text('Outline'),
      );
    case DSButtonVariants.ghost:
      return TextButton(
        onPressed: () {},
        child: Text('Ghost'),
      );
  }
}
```

## Troubleshooting

### Common Error Messages

| Error Message | Solution |
|---------------|----------|
| "Tên component không được để trống" | Provide a component name |
| "File ds_app_theme.dart không tồn tại" | Create required app theme file |
| "Lỗi khi format code" | Install dart_style: `dart pub global activate dart_style` |
| "Lỗi khi tạo component" | Check file permissions and dependencies |

### Quick Fixes

```bash
# Create required app theme file
mkdir -p lib/theme/base/app_theme
touch lib/theme/base/app_theme/ds_app_theme.dart

# Install dart formatter
dart pub global activate dart_style

# Check dependencies
dart pub get
```

### Required Dependencies
```yaml
# pubspec.yaml
dependencies:
  design_system_project:
    path: ../design_system_project
```

## Version History

### Version 0.0.3 (Current)
- ✨ **Component Variants Support**: Added enum generation for component variants with default variants
- 🎨 **Enhanced Theme Extensions**: Better structure for theme extensions with variant definitions
- 📝 **Improved Code Organization**: Cleaner template structure
- ⚡ **Automatic Variant Parameters**: Components now include automatic variant parameters
- 🔧 **Fixed Extension Formatting**: Corrected extension formatting in app theme files

### Version 0.0.2
- 🎉 **Component Variants Support**: Added enum generation for component variants
- 🎨 **Enhanced Theme Extensions**: Better structure for theme extensions with variant definitions
- 📝 **Improved Code Organization**: Cleaner template structure

### Version 0.0.1
- 🎉 **Initial Release**: Basic component generation with design system integration
- 🚀 **Automated File Generation**: Complete file structure creation
- 🔧 **Theme Integration**: Automatic theme file updates
- 📁 **File Organization**: Proper directory structure

## Best Practices

### 1. Component Naming
- Use descriptive, PascalCase names
- Avoid abbreviations
- Be consistent with existing patterns

### 2. Theme Organization
- Group related properties together
- Use meaningful property names
- Document complex properties

### 3. Variant Usage
- Start with provided default variants
- Add custom variants as needed
- Keep variant names consistent
- Use automatic variant parameter

### 4. File Structure
- Keep generated files in designated directories
- Don't move files after generation
- Use tool's structure for consistency

### 5. Version Control
- Commit generated files
- Review code before committing
- Use tool consistently across team

## Quick Commands Reference

```bash
# Installation
dart pub global activate component_creator

# Create components
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget

# Interactive mode
component_creator

# Verify installation
component_creator --help

# Format code manually
dart format lib

# Check dependencies
dart pub get
```

## File Templates Summary

### Component Widget
- StatefulWidget with theme integration
- Automatic variant parameter (v0.0.3+)
- DSStateBase extension
- Theme extension access

### Theme Extension (v0.0.3+)
- Component variants enum with defaults
- ThemeExtension implementation
- copyWith and lerp methods
- Theme instance property

### Theme Class
- Basic theme properties structure
- TODO comments for customization
- Part directive for ds_theme.dart

### Integration Files
- ds_theme.dart: Part directives
- ds_app_theme.dart: Extensions array with proper formatting

---

*This quick reference covers all essential aspects of using the Component Creator tool with component variants support and automatic variant parameters.* 