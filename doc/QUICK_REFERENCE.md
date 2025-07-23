# Quick Reference

A quick reference guide for the Component Creator tool with all essential commands, examples, and features.

## Table of Contents

- [Installation](#installation)
- [Basic Commands](#basic-commands)
- [Interactive Component Variants (v0.0.6+)](#interactive-component-variants-v006)
- [Generated Files](#generated-files)
- [Naming Conventions](#naming-conventions)
- [Breaking Changes (v0.0.4)](#breaking-changes-v004)
- [Bug Fixes (v0.0.5)](#bug-fixes-v005)
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
# Choose whether to create variants (y/n)
```

### Direct Mode
```bash
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
# Will prompt for variant choice
```

### Verify Installation
```bash
component_creator --help
```

## Interactive Component Variants (v0.0.6+)

### Interactive Flow
```bash
component_creator
# Enter component name: Button
# Bạn có muốn tạo variants không? (y/n): y
```

### Generated Component (with variants chosen)
```dart
class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  const DSButton({
    super.key,
    this.variant = DSButtonVariants.primary,
  });
  
  @override
  State<DSButton> createState() => _DSButtonState();
}

enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
}

class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  DSButtonTheme get dSButtonTheme => DSButtonTheme(
        // TODO: Configure theme properties for DSButton component
      );
  // ... implementation
}
```

### Generated Component (without variants chosen)
```dart
class DSButton extends StatefulWidget {
  const DSButton({
    super.key,
  });
  
  @override
  State<DSButton> createState() => _DSButtonState();
}

class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  DSButtonTheme get dSButtonTheme => DSButtonTheme(
        // TODO: Configure theme properties for DSButton component
      );
  // ... implementation
}
```

### Usage Examples
```dart
// With variants (if chosen)
DSButton(variant: DSButtonVariants.primary)
DSButton(variant: DSButtonVariants.secondary)
DSButton() // Uses default primary variant

// Without variants (if not chosen)
DSButton()
DSButton(key: Key('my-button'))
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
            └── ds_button_theme.ext.dart # Theme extension with optional variants
```

## Naming Conventions

| Input | Component Class | File Name | Theme Class | Theme Extension |
|-------|----------------|-----------|-------------|-----------------|
| `Button` | `DSButton` | `ds_button.dart` | `DSButtonTheme` | `DSButtonThemeExtension` |
| `CustomCard` | `DSCustomCard` | `ds_custom_card.dart` | `DSCustomCardTheme` | `DSCustomCardThemeExtension` |
| `MyAwesomeWidget` | `DSMyAwesomeWidget` | `ds_my_awesome_widget.dart` | `DSMyAwesomeWidgetTheme` | `DSMyAwesomeWidgetThemeExtension` |

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
        // Component theme extensions will be added here with consistent naming
      ],
    );
  }
}
```

## Generated Code Examples

### Component Widget Template (with variants)
```dart
import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';

class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  const DSButton({
    super.key,
    this.variant = DSButtonVariants.primary,
  });

  @override
  State<DSButton> createState() => _DSButtonState();
}

class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme = theme
      .extension<DSButtonThemeExtension>()!
      .dSButtonTheme;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Component Widget Template (without variants)
```dart
import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../theme/ds_theme.dart';

class DSButton extends StatefulWidget {
  const DSButton({
    super.key,
  });

  @override
  State<DSButton> createState() => _DSButtonState();
}

class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme = theme
      .extension<DSButtonThemeExtension>()!
      .dSButtonTheme;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Theme Extension Template (v0.0.6+)
```dart
part of '../../ds_theme.dart';

enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
}

class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  DSButtonTheme get dSButtonTheme => DSButtonTheme(
        // TODO: Configure theme properties for DSButton component
      );

  @override
  ThemeExtension<DSButtonThemeExtension> copyWith() {
    return DSButtonThemeExtension();
  }

  @override
  ThemeExtension<DSButtonThemeExtension> lerp(
    covariant ThemeExtension<DSButtonThemeExtension>? other,
    double t,
  ) {
    return DSButtonThemeExtension();
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

### Variant-Specific Styling (if variants chosen)
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

## Breaking Changes (v0.0.4)

### Theme Extension Class Names
- **Before**: `${className}ThemeExt`
- **After**: `${className}ThemeExtension`

### Instance References
- **Before**: `${className}Extension()`
- **After**: `${className}ThemeExtension()`

### Migration Guide
If you have existing components generated with previous versions:

1. **Update manual references:**
   ```dart
   // Change from
   theme.extension<DSButtonThemeExt>()
   // To
   theme.extension<DSButtonThemeExtension>()
   ```

2. **Update app theme file:**
   ```dart
   // Change from
   DSButtonExtension(),
   // To
   DSButtonThemeExtension(),
   ```

3. **Regenerate components:**
   ```bash
   rm -rf lib/components/ds_button
   rm -rf lib/theme/components/ds_button
   component_creator Button
   ```

## Bug Fixes (v0.0.5)

### StatefulWidget Template Fix
- **Issue**: Template used `${className}ThemeExt` instead of `${className}ThemeExtension`
- **Fix**: Updated template to use correct theme extension reference
- **Impact**: Generated components now have correct theme extension references

### Template Consistency
- **Fixed**: All templates now use consistent theme extension naming
- **Improved**: Test coverage for correct template generation
- **Enhanced**: Generated code consistency across all components

### Before vs After
```dart
// Before (v0.0.4 and earlier)
theme.extension<DSButtonThemeExt>()!.dSButtonTheme; // Incorrect

// After (v0.0.5+)
theme.extension<DSButtonThemeExtension>()!.dSButtonTheme; // Fixed
```

## Troubleshooting

### Common Error Messages

| Error Message | Solution |
|---------------|----------|
| "Tên component không được để trống" | Provide a component name |
| "File ds_app_theme.dart không tồn tại" | Create required app theme file |
| "Lỗi khi format code" | Install dart_style: `dart pub global activate dart_style` |
| "Lỗi khi tạo component" | Check file permissions and dependencies |
| Naming inconsistency errors | Follow migration guide for v0.0.4 |
| Theme extension reference errors | Regenerate components with v0.0.5+ |
| Variant-related errors | Ensure you're not using variant parameters when variants weren't chosen |

### Quick Fixes

```bash
# Create required app theme file
mkdir -p lib/theme/base/app_theme
touch lib/theme/base/app_theme/ds_app_theme.dart

# Install dart formatter
dart pub global activate dart_style

# Check dependencies
dart pub get

# Migrate from v0.0.3 or earlier
rm -rf lib/components/ds_button
rm -rf lib/theme/components/ds_button
component_creator Button

# Fix template references (v0.0.4 and earlier)
rm -rf lib/components/ds_button
rm -rf lib/theme/components/ds_button
component_creator Button
```

### Required Dependencies
```yaml
# pubspec.yaml
dependencies:
  design_system_project:
    path: ../design_system_project
```

## Version History

### Version 0.0.6 (Current)
- 🎯 **Interactive Component Variants Creation**: Added user choice for creating component variants
- 🔧 **Flexible Variant Generation**: Components can now be created with or without variants
- 🎨 **Enhanced User Experience**: Interactive prompts for better component customization
- 📝 **Improved Template Flexibility**: Templates now support optional variant generation
- 🚀 **Better Code Organization**: Cleaner template structure with conditional variant support

### Version 0.0.5
- 🐛 **StatefulWidget Template Bug Fix**: Fixed incorrect theme extension reference in StatefulWidget template
- 🔧 **Template Consistency**: Updated StatefulWidget template to use consistent theme extension naming
- ✅ **Test Coverage**: Updated test cases to reflect the corrected template naming

### Version 0.0.4
- 🎯 **Theme Extension Naming Consistency**: Refactored theme extension class and instance naming for better consistency
- 📝 **Improved Class Names**: Changed theme extension class from `${className}ThemeExt` to `${className}ThemeExtension`
- 🔧 **Enhanced Instance Names**: Updated instance names from `${className}Extension()` to `${className}ThemeExtension()`
- 🎨 **Better Variable Names**: Improved variable naming consistency in theme extensions

### Version 0.0.3
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
- Choose variants only when your component needs different styles
- Start with provided default variants if variants are chosen
- Add custom variants as needed
- Keep variant names consistent
- Use automatic variant parameter when variants are chosen

### 4. File Structure
- Keep generated files in designated directories
- Don't move files after generation
- Use tool's structure for consistency

### 5. Version Control
- Commit generated files
- Review code before committing
- Use tool consistently across team

### 6. Migration Strategy
- When upgrading to v0.0.4+, follow the migration guide
- When upgrading to v0.0.5+, regenerate components for correct template references
- When upgrading to v0.0.6+, take advantage of the new interactive variant choice
- Test components after migration
- Update any custom code that references old naming

### 7. Template Consistency
- Use the latest version of the tool for consistent template generation
- Regenerate components when upgrading to get the latest template fixes
- Verify theme extension references in generated components

### 8. Interactive Variant Choice
- Choose variants only when your component needs different styles
- Use the interactive choice to create simpler components when variants aren't needed
- Take advantage of the flexible generation options

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

# Migration from v0.0.3 or earlier
rm -rf lib/components/ds_button
rm -rf lib/theme/components/ds_button
component_creator Button

# Fix template references (v0.0.4 and earlier)
rm -rf lib/components/ds_button
rm -rf lib/theme/components/ds_button
component_creator Button
```

## File Templates Summary

### Component Widget
- StatefulWidget with theme integration
- Optional variant parameter (v0.0.6+)
- DSStateBase extension
- Theme extension access with consistent naming and correct references

### Theme Extension (v0.0.6+)
- Optional component variants enum
- ThemeExtension implementation with consistent naming
- copyWith and lerp methods
- Theme instance property using getter syntax

### Theme Class
- Basic theme properties structure
- TODO comments for customization
- Part directive for ds_theme.dart

### Integration Files
- ds_theme.dart: Part directives
- ds_app_theme.dart: Extensions array with consistent naming

## Naming Conventions Summary

| Component | Class Name | Theme Extension | Instance Reference |
|-----------|------------|-----------------|-------------------|
| Button | DSButton | DSButtonThemeExtension | DSButtonThemeExtension() |
| CustomCard | DSCustomCard | DSCustomCardThemeExtension | DSCustomCardThemeExtension() |
| MyWidget | DSMyWidget | DSMyWidgetThemeExtension | DSMyWidgetThemeExtension() |

---

*This quick reference covers all essential aspects of using the Component Creator tool with interactive component variants support, flexible generation options, consistent naming conventions, and the latest bug fixes for template consistency.* 