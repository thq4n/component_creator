# Usage Guide

This guide provides step-by-step instructions for using the Component Creator tool to generate Flutter components with design system integration.

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Basic Usage](#basic-usage)
- [Advanced Usage](#advanced-usage)
- [Component Variants (v0.0.3+)](#component-variants-v003)
- [Generated Files](#generated-files)
- [Customization](#customization)
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
        // Component theme extensions will be added here with proper formatting
      ],
    );
  }
}
```

## Component Variants (v0.0.3+)

### Overview

Starting from version 0.0.3, the tool automatically generates component variants support with smart defaults. Each component now includes a variants enum with common variants pre-defined and an automatic variant parameter.

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
         theme.extension<DSButtonThemeExt>()!.dSButtonTheme;

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

## Generated Files

For each component, the tool generates the following files:

### 1. Component Widget

**Location**: `lib/components/ds_{component_name}/ds_{component_name}.dart`

**Content**: StatefulWidget with theme integration and automatic variant parameter

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

### 2. Theme Class

**Location**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.dart`

**Content**: Theme properties for the component

```dart
part of '../../ds_theme.dart';

class DSButtonTheme {
  // TODO: Define theme properties for DSButton component
}
```

### 3. Theme Extension (v0.0.3+)

**Location**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.ext.dart`

**Content**: Theme extension with variants enum and default variants

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

**Adds**: Theme extension to the extensions array with proper formatting

```dart
extensions: [
  DSButtonThemeExt(),
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

**Solution**: Check that the theme extension is added to the extensions array in `ds_app_theme.dart`. The tool now properly formats extensions.

#### 4. Import errors

**Solution**: Ensure all required dependencies are in your `pubspec.yaml`:

```yaml
dependencies:
  design_system_project:
    path: ../design_system_project
```

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
      theme.extension<DSButtonThemeExt>()!.dSButtonTheme;

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

This usage guide covers all aspects of using the Component Creator tool, from basic installation to advanced customization with component variants support and automatic variant parameters. 
This usage guide covers all aspects of using the Component Creator tool, from basic installation to advanced customization with component variants support. 