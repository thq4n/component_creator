# Usage Guide

This guide provides step-by-step instructions for using the Component Creator tool to generate Flutter components with design system integration.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [Component Variants (v0.0.5+)](#component-variants-v005)
- [Generated Files](#generated-files)
- [Customization](#customization)
- [Breaking Changes (v0.0.4)](#breaking-changes-v004)
- [Bug Fixes (v0.0.5)](#bug-fixes-v005)
- [Troubleshooting](#troubleshooting)

## Installation

### Prerequisites

- Dart SDK >= 3.7.2
- Flutter SDK
- Git (for version control)

### Install the Tool

#### Option 1: Global Installation (Recommended)

```bash
dart pub global activate component_creator
```

#### Option 2: From Source

```bash
git clone https://github.com/your-username/component_creator.git
cd component_creator
dart pub get
dart pub global activate --source path .
```

### Verify Installation

```bash
component_creator --help
# or
component_creator
```

You should see the interactive prompt asking for a component name.

## Quick Start

1. **Navigate to your Flutter project:**
   ```bash
   cd your_flutter_project
   ```

2. **Create your first component:**
   ```bash
   component_creator Button
   ```

3. **Check the generated files:**
   ```bash
   ls lib/components/ds_button/
   ls lib/theme/components/ds_button/
   ```

4. **Use the generated component with variants:**
   ```dart
   DSButton(variant: DSButtonVariants.primary)
   DSButton(variant: DSButtonVariants.secondary)
   DSButton() // Uses default primary variant
   ```

## Basic Usage

### Interactive Mode

Run the tool without arguments to enter interactive mode:

```bash
component_creator
```

You'll be prompted to enter the component name:
```
Nhập tên component: Button
```

### Direct Mode

Provide the component name as an argument:

```bash
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### Naming Conventions

The tool automatically handles naming conventions:

- **Input**: `Button` → **Generated**: `DSButton` (class), `ds_button` (files)
- **Input**: `CustomCard` → **Generated**: `DSCustomCard` (class), `ds_custom_card` (files)
- **Input**: `my_widget` → **Generated**: `DSMyWidget` (class), `ds_my_widget` (files)

## Advanced Usage

### Project Structure Requirements

The tool expects a specific project structure:

```
your_flutter_project/
├── lib/
│   ├── components/           # Component widgets (created automatically)
│   ├── theme/
│   │   ├── components/       # Component themes (created automatically)
│   │   ├── base/
│   │   │   └── app_theme/
│   │   │       └── ds_app_theme.dart  # Required file
│   │   └── ds_theme.dart     # Main theme file (created if missing)
│   └── main.dart
```

### Required Files

The tool requires these files to exist:

1. **`lib/theme/base/app_theme/ds_app_theme.dart`** - App theme file
2. **`lib/theme/ds_theme.dart`** - Main theme file (created automatically if missing)

### Example Required App Theme File

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

## Component Variants (v0.0.5+)

### Overview

Starting from version 0.0.5, the tool automatically generates component variants support with smart defaults and consistent naming. Each component now includes a variants enum with common variants pre-defined, an automatic variant parameter, consistent theme extension naming, and correct template references.

### Generated Variants Enum

For each component, the tool generates a `${className}Variants` enum in the theme extension file with default variants:

```dart
// Generated in lib/theme/components/ds_button/ds_button_theme.ext.dart
enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSButton component
}
```

### Automatic Variant Parameter

Components now automatically include a variant parameter with a default value:

```dart
// Generated component with automatic variant parameter
class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  const DSButton({super.key, this.variant = DSButtonVariants.primary});
  
  @override
  State<DSButton> createState() => _DSButtonState();
}
```

### Consistent Theme Extension Naming

Theme extension classes now follow consistent naming conventions:

```dart
// Generated theme extension with consistent naming
class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  final DSButtonTheme dSButtonTheme = DSButtonTheme();
  
  // ... implementation
}
```

### Correct Template References (v0.0.5+)

The StatefulWidget template now correctly references theme extensions:

```dart
// Generated component with correct theme extension reference
class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExtension>()!.dSButtonTheme; // Fixed reference

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### Using Component Variants

1. **Use the pre-defined variants:**
   ```dart
   // The enum already includes common variants
   enum DSButtonVariants {
     primary,
     secondary,
     outline,
     ghost,
     // TODO: Define variants for DSButton component
   }
   ```

2. **Use the component with variants:**
   ```dart
   // Use with specific variant
   DSButton(variant: DSButtonVariants.primary)
   DSButton(variant: DSButtonVariants.secondary)
   DSButton(variant: DSButtonVariants.outline)
   DSButton(variant: DSButtonVariants.ghost)
   
   // Use default variant
   DSButton() // Automatically uses DSButtonVariants.primary
   ```

3. **Implement variant-specific styling:**
   ```dart
   class _DSButtonState extends DSStateBase<DSButton> {
     late DSButtonTheme componentTheme =
         theme.extension<DSButtonThemeExtension>()!.dSButtonTheme;

     @override
     Widget build(BuildContext context) {
       return ElevatedButton(
         style: _getButtonStyle(),
         onPressed: () {},
         child: Text('Button'),
       );
     }
     
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
         case DSButtonVariants.ghost:
           return TextButton.styleFrom();
       }
     }
   }
   ```

4. **Add custom variants to the enum:**
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

5. **Update your theme class:**
   ```dart
   class DSButtonTheme {
     final Color primaryColor = Colors.blue;
     final Color secondaryColor = Colors.grey;
     final Color outlineColor = Colors.blue;
     final Color dangerColor = Colors.red;
     final Color successColor = Colors.green;
     final Color warningColor = Colors.orange;
   }
   ```

### Benefits of Component Variants

- **Consistent Design**: All variants follow the same design system
- **Type Safety**: Compile-time checking for variant values
- **Easy Maintenance**: Centralized variant definitions
- **Flexible Styling**: Easy to add new variants or modify existing ones
- **Better UX**: Consistent component behavior across variants
- **Smart Defaults**: Components come with common variants pre-defined
- **Automatic Integration**: Variant parameter automatically included in generated components
- **Consistent Naming**: Theme extension classes follow clear naming conventions
- **Template Consistency**: All templates use consistent theme extension references

## Generated Files

For each component, the tool generates the following files:

### 1. Component Widget

**Location**: `lib/components/ds_{component_name}/ds_{component_name}.dart`

**Content**: StatefulWidget with theme integration, automatic variant parameter, consistent naming, and correct theme extension reference

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
      theme.extension<DSButtonThemeExtension>()!.dSButtonTheme;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

### 2. Theme Class

**Location**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.dart`

**Content**: Theme properties for the component

```dart
part of '../../ds_theme.dart';

class DSButtonTheme {
  // TODO: Define theme properties for DSButton component
}
```

### 3. Theme Extension (v0.0.5+)

**Location**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.ext.dart`

**Content**: Theme extension with variants enum, default variants, and consistent naming

```dart
part of '../../ds_theme.dart';

enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  // TODO: Define variants for DSButton component
}

class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  final DSButtonTheme dSButtonTheme = DSButtonTheme();

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

### 4. Theme Integration

**Updates**: `lib/theme/ds_theme.dart`

**Adds**: Part directives for the new component

```dart
// Component Theme
part 'components/ds_button/ds_button_theme.dart';
part 'components/ds_button/ds_button_theme.ext.dart';
```

### 5. App Theme Integration

**Updates**: `lib/theme/base/app_theme/ds_app_theme.dart`

**Adds**: Theme extension to the extensions array with proper formatting and consistent naming

```dart
extensions: [
  DSButtonThemeExtension(), // Consistent naming
  // ... other extensions
],
```

## Customization

### Modifying Generated Code

After generation, you can customize the code:

1. **Add properties to the theme class:**
   ```dart
   class DSButtonTheme {
     final Color backgroundColor = Colors.blue;
     final double borderRadius = 8.0;
     final EdgeInsets padding = EdgeInsets.all(16.0);
   }
   ```

2. **Implement the component logic:**
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

3. **Add custom variants to the enum:**
   ```dart
   enum DSButtonVariants {
     primary,
     secondary,
     outline,
     ghost,
     danger,    // Your custom variants
     success,
   }
   ```

4. **Implement variant-specific styling:**
   ```dart
   Widget _buildButton() {
     switch (widget.variant) {
       case DSButtonVariants.primary:
         return ElevatedButton(/* primary styling */);
       case DSButtonVariants.secondary:
         return ElevatedButton(/* secondary styling */);
       case DSButtonVariants.outline:
         return OutlinedButton(/* outline styling */);
       case DSButtonVariants.ghost:
         return TextButton(/* ghost styling */);
       case DSButtonVariants.danger:
         return ElevatedButton(/* danger styling */);
       case DSButtonVariants.success:
         return ElevatedButton(/* success styling */);
     }
   }
   ```

### Template Customization

To customize the generated templates, you can modify the `Templates` class in `lib/tool/templates.dart`.

## Breaking Changes (v0.0.4)

### Theme Extension Class Names

**Before (v0.0.3 and earlier):**
```dart
class DSButtonThemeExt extends ThemeExtension<DSButtonThemeExt> {
  // ... implementation
}
```

**After (v0.0.4+):**
```dart
class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  // ... implementation
}
```

### Instance References

**Before (v0.0.3 and earlier):**
```dart
// In app theme file
extensions: [
  DSButtonExtension(), // Old naming
],
```

**After (v0.0.4+):**
```dart
// In app theme file
extensions: [
  DSButtonThemeExtension(), // New consistent naming
],
```

### Component Usage

**Before (v0.0.3 and earlier):**
```dart
class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExt>()!.dSButtonTheme; // Old naming
}
```

**After (v0.0.4+):**
```dart
class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExtension>()!.dSButtonTheme; // New naming
}
```

### Migration Guide

If you have existing components generated with previous versions:

1. **Update manual references to theme extension classes:**
   ```dart
   // Change from
   theme.extension<DSButtonThemeExt>()
   // To
   theme.extension<DSButtonThemeExtension>()
   ```

2. **Update app theme file extension references:**
   ```dart
   // Change from
   DSButtonExtension(),
   // To
   DSButtonThemeExtension(),
   ```

3. **Regenerate components for consistency:**
   ```bash
   # Delete old generated files
   rm -rf lib/components/ds_button
   rm -rf lib/theme/components/ds_button
   
   # Regenerate with new naming
   component_creator Button
   ```

### Benefits of the New Naming

- **Consistency**: All theme extension classes follow the same pattern
- **Clarity**: Names are more descriptive and self-explanatory
- **Maintainability**: Easier to understand and maintain
- **Future-proof**: Better foundation for future enhancements

## Bug Fixes (v0.0.5)

### StatefulWidget Template Fix

**Issue**: The StatefulWidget template was using the old theme extension naming convention.

**Before (v0.0.4 and earlier):**
```dart
class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExt>()!.dSButtonTheme; // Incorrect reference
}
```

**After (v0.0.5+):**
```dart
class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExtension>()!.dSButtonTheme; // Fixed reference
}
```

### Template Consistency

**Fixed Issues:**
- **Theme Extension Reference**: StatefulWidget template now correctly references theme extensions
- **Generated Code Consistency**: All generated components use consistent theme extension naming
- **Template Alignment**: StatefulWidget template matches theme extension naming conventions

**Technical Improvements:**
- **Template Update**: Updated `statefulWidget()` method in `Templates` class to use correct theme extension reference
- **Test Updates**: Updated test cases in `component_creator_test.dart` to verify correct template generation
- **Consistency Fix**: Ensured StatefulWidget template matches theme extension naming pattern

### Impact

- **No Breaking Changes**: This is a bug fix that doesn't introduce breaking changes
- **Improved Consistency**: All templates now use the same naming pattern
- **Better Generated Code**: Generated components now have correct theme extension references
- **Enhanced Test Coverage**: Test cases now verify correct template generation

## Troubleshooting

### Common Issues

#### 1. "File ds_app_theme.dart không tồn tại"

**Solution**: Create the required app theme file:

```bash
mkdir -p lib/theme/base/app_theme
touch lib/theme/base/app_theme/ds_app_theme.dart
```

Add basic content:
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

#### 2. "Lỗi khi format code"

**Solution**: Ensure Dart formatter is available:

```bash
dart pub global activate dart_style
```

#### 3. Component not appearing in theme

**Solution**: Check that the theme extension is added to the extensions array in `ds_app_theme.dart`. The tool now properly formats extensions with consistent naming.

#### 4. Import errors

**Solution**: Ensure all required dependencies are in your `pubspec.yaml`:

```yaml
dependencies:
  design_system_project:
    path: ../design_system_project
```

#### 5. Naming inconsistency errors

**Solution**: If you're upgrading from v0.0.3 or earlier, follow the migration guide above to update your existing components.

#### 6. Theme extension reference errors (v0.0.4 and earlier)

**Solution**: If you have components generated with v0.0.4 or earlier, regenerate them with v0.0.5+ to get the correct theme extension references.

### Debug Mode

For detailed debugging, you can modify the tool to add more verbose logging:

```dart
// In component_creator.dart
print('Creating component: $className');
print('File path: ${file.path}');
```

### Getting Help

- Check the [API Documentation](API.md) for detailed method descriptions
- Review the [README.md](../README.md) for project overview
- Open an issue on GitHub for bugs or feature requests

## Best Practices

### 1. Naming Conventions

- Use descriptive, PascalCase names for components
- Avoid abbreviations unless they're widely understood
- Be consistent with your existing naming patterns

### 2. Theme Organization

- Group related theme properties together
- Use meaningful property names
- Document complex theme properties

### 3. Component Variants

- Start with the provided default variants (primary, secondary, outline, ghost)
- Add custom variants as needed for your design system
- Keep variant names consistent across components
- Use the automatic variant parameter for consistency

### 4. File Structure

- Keep generated files in their designated directories
- Don't move files after generation (breaks imports)
- Use the tool's structure for consistency

### 5. Version Control

- Commit generated files to version control
- Review generated code before committing
- Use the tool consistently across your team

### 6. Migration Strategy

- When upgrading to v0.0.4+, follow the migration guide
- When upgrading to v0.0.5+, regenerate components for correct template references
- Test components after migration
- Update any custom code that references old naming

### 7. Template Consistency

- Use the latest version of the tool for consistent template generation
- Regenerate components when upgrading to get the latest template fixes
- Verify theme extension references in generated components

## Examples

### Complete Button Component

```dart
// lib/components/ds_button/ds_button.dart
import '../../theme/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:design_system_project/base/ds_base.dart';

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

class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme =
      theme.extension<DSButtonThemeExtension>()!.dSButtonTheme;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _getButtonStyle(),
      onPressed: widget.onPressed,
      child: Text(widget.text),
    );
  }
  
  ButtonStyle _getButtonStyle() {
    switch (widget.variant) {
      case DSButtonVariants.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: componentTheme.primaryColor,
          foregroundColor: componentTheme.primaryTextColor,
        );
      case DSButtonVariants.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: componentTheme.secondaryColor,
          foregroundColor: componentTheme.secondaryTextColor,
        );
      case DSButtonVariants.outline:
        return OutlinedButton.styleFrom(
          side: BorderSide(color: componentTheme.outlineColor),
        );
      case DSButtonVariants.ghost:
        return TextButton.styleFrom();
    }
  }
}
```

### Complete Theme Extension

```dart
// lib/theme/components/ds_button/ds_button_theme.ext.dart
part of '../../ds_theme.dart';

enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
  danger,    // Custom variant
  success,   // Custom variant
}

class DSButtonTheme {
  final Color primaryColor = Colors.blue;
  final Color primaryTextColor = Colors.white;
  final Color secondaryColor = Colors.grey;
  final Color secondaryTextColor = Colors.black;
  final Color outlineColor = Colors.blue;
  final Color dangerColor = Colors.red;
  final Color successColor = Colors.green;
}

class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  final DSButtonTheme dSButtonTheme = DSButtonTheme();

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

This usage guide covers all aspects of using the Component Creator tool, from basic installation to advanced customization with component variants support, automatic variant parameters, consistent naming conventions, and the latest bug fixes for template consistency. 