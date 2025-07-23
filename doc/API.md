# API Documentation

This document provides detailed API documentation for the Component Creator tool.

## Table of Contents

- [ComponentCreator](#componentcreator)
- [Templates](#templates)
- [FileUtils](#fileutils)
- [StringUtils](#stringutils)

## ComponentCreator

The main orchestrator class that coordinates the component generation process.

### Constructor

```dart
ComponentCreator()
```

Creates a new instance of the ComponentCreator.

### Properties

```dart
final Directory componentsDir = Directory('lib/components')
```
The directory where component widgets are stored.

```dart
final Directory themeComponentsDir = Directory('lib/theme/components')
```
The directory where component theme files are stored.

```dart
final File dsThemeFile = File('lib/theme/ds_theme.dart')
```
The main theme file that gets updated with new component parts.

### Methods

#### run(List<String> args)

Main entry point for the component creation process with interactive variant choice.

**Parameters:**
- `args` - Command line arguments. The first argument should be the component name.

**Behavior:**
- If no arguments are provided, prompts the user for a component name
- Prompts the user to choose whether to create variants for the component
- Validates the component name is not empty
- Converts the name to appropriate naming conventions
- Calls all generation methods in sequence with variant choice
- Handles errors and provides informative error messages

**Interactive Flow:**
1. **Component Name Input**: User enters component name
2. **Variant Choice Prompt**: Tool asks "Bạn có muốn tạo variants không? (y/n):"
3. **Conditional Generation**: Based on user choice:
   - **Yes**: Generates component with variants enum and variant parameter
   - **No**: Generates component without variants (simpler structure)
4. **File Generation**: Creates all necessary files with appropriate structure

**Example:**
```dart
final creator = ComponentCreator();
creator.run(['Button']); // Creates a Button component with variant choice prompt
```

#### _createComponentWidget(String className, String snakeName, List<String> customVariants)

Creates the main component widget file with optional variant support.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `snakeName` - The snake_case file name (e.g., "ds_button")
- `customVariants` - List of custom variants to include (empty list for no variants)

**Creates:**
- Directory: `lib/components/ds_button/`
- File: `lib/components/ds_button/ds_button.dart`

**New in v0.0.6:**
- **Optional Variant Support**: Component can be generated with or without variants
- **Interactive Choice**: User can choose whether to create variants
- **Flexible Generation**: Template adapts based on variant choice

#### _createThemeComponent(String className, String snakeName, List<String> customVariants)

Creates theme-related files for the component with optional variant support.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `snakeName` - The snake_case file name (e.g., "ds_button")
- `customVariants` - List of custom variants to include (empty list for no variants)

**Creates:**
- Directory: `lib/theme/components/ds_button/`
- File: `lib/theme/components/ds_button/ds_button_theme.dart`
- File: `lib/theme/components/ds_button/ds_button_theme.ext.dart`

**New in v0.0.6:**
- **Conditional Variant Generation**: Theme extension includes variants enum only if variants are chosen
- **Flexible Template**: Template adapts based on variant choice

#### _updateDsThemeFile(String snakeName)

Updates the main theme file to include the new component's theme parts.

**Parameters:**
- `snakeName` - The snake_case file name (e.g., "ds_button")

**Updates:**
- Adds part directives to `lib/theme/ds_theme.dart`
- Creates the file if it doesn't exist

#### _updateDsAppThemeExtensions(String className)

Updates the app theme file to include the new component's theme extension with proper formatting and consistent naming.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")

**Updates:**
- Adds the component's theme extension to the extensions array in `lib/theme/base/app_theme/ds_app_theme.dart`
- **Fixed Formatting**: Properly formats extensions with correct comma placement
- **Consistent Naming**: Uses `${className}ThemeExtension()` for consistent naming

#### _formatCode()

Formats all generated code using the Dart formatter.

**Runs:**
- `dart format lib` command
- Provides feedback on success or failure

#### _toSnakeCaseWithPrefix(String input)

Converts a string to snake_case with a "ds_" prefix.

**Parameters:**
- `input` - The input string to convert

**Returns:**
- A string in snake_case format with "ds_" prefix

**Examples:**
```dart
_toSnakeCaseWithPrefix("Button") // Returns "ds_button"
_toSnakeCaseWithPrefix("CustomCard") // Returns "ds_custom_card"
```

## Templates

Static class containing all template strings for generating different file types with optional variant support.

### Methods

#### statefulWidget(String className, String snakeFileName, [List<String>? customVariants])

Generates the template for a StatefulWidget component with optional variant parameter and correct theme extension reference.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `snakeFileName` - The snake_case file name (e.g., "ds_button")
- `customVariants` - Optional list of custom variants (defaults to null for no variants)

**Returns:**
- A string containing the complete StatefulWidget template

**Template includes:**
- Proper imports for theme and Flutter
- StatefulWidget class definition with conditional variant parameter
- State class extending DSStateBase
- Theme integration setup with consistent naming and correct theme extension reference
- Basic build method structure

**New in v0.0.6:**
- **Optional Variant Support**: Component can be generated with or without variants
- **Conditional Template Generation**: Template adapts based on variant choice
- **Flexible Structure**: Simpler structure when variants are not chosen
- **Interactive Choice**: Supports user choice for variant creation

**Example Generated Component (with variants):**
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

**Example Generated Component (without variants):**
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

#### themeFileContent(String className)

Generates the template for a component theme file.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")

**Returns:**
- A string containing the theme class template

**Template includes:**
- Part directive for ds_theme.dart
- Theme class definition with TODO comment

#### themeExtensionFileContent(String className, [List<String>? customVariants])

Generates the template for a component theme extension file with optional component variants support and consistent naming.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `customVariants` - Optional list of custom variants (defaults to null for no variants)

**Returns:**
- A string containing the theme extension template with optional variants enum and consistent naming

**Template includes:**
- Part directive for ds_theme.dart
- **Conditional Component Variants Enum**: `${className}Variants` enum with custom variants (only if variants are provided)
- **Consistent Theme Extension Class**: `${className}ThemeExtension` class with consistent naming
- ThemeExtension class definition with proper naming
- Theme instance property with consistent variable naming using getter syntax
- copyWith and lerp method implementations with consistent naming

**New in v0.0.6:**
- **Optional Variant Support**: Theme extension can be generated with or without variants enum
- **Conditional Generation**: Variants enum is only included if variants are chosen
- **Flexible Template**: Template adapts based on variant choice
- **Getter Syntax**: Theme instance now uses getter syntax for better performance

**Example Generated Theme Extension (with variants):**
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

**Example Generated Theme Extension (without variants):**
```dart
part of '../../ds_theme.dart';

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

#### baseDsThemeFileContent()

Generates the base content for the main theme file.

**Returns:**
- A string containing the base ds_theme.dart file content

**Content includes:**
- Required imports
- Base theme component parts
- Theme extension parts
- Component Theme comment section

## FileUtils

Utility class for file and directory operations.

### Methods

#### createDirIfNotExist(Directory dir)

Creates a directory if it doesn't already exist.

**Parameters:**
- `dir` - The directory to create

**Behavior:**
- Checks if directory exists
- Creates directory recursively if it doesn't exist

#### fileExists(String path)

Checks if a file exists at the given path.

**Parameters:**
- `path` - The file path to check

**Returns:**
- `true` if the file exists, `false` otherwise

#### writeFile(String path, String content)

Writes content to a file, creating it if it doesn't exist.

**Parameters:**
- `path` - The file path to write to
- `content` - The content to write

**Behavior:**
- Creates the file if it doesn't exist
- Overwrites the file if it already exists

#### formatCode()

Formats code using the Dart formatter.

**Runs:**
- `dart format lib` command
- Prints success or error messages

## StringUtils

Extension methods for String class providing case conversion utilities.

### Extension Methods

#### snakeCase

Converts a string to snake_case format.

**Returns:**
- A string in snake_case format

**Examples:**
```dart
"helloWorld".snakeCase // Returns "hello_world"
"MyAwesomeClass".snakeCase // Returns "my_awesome_class"
"hello world".snakeCase // Returns "hello_world"
```

#### camelCase

Converts a string to camelCase format.

**Returns:**
- A string in camelCase format

**Examples:**
```dart
"hello_world".camelCase // Returns "helloWorld"
"my_awesome_class".camelCase // Returns "myAwesomeClass"
"hello-world".camelCase // Returns "helloWorld"
```

#### pascalCase

Converts a string to PascalCase format.

**Returns:**
- A string in PascalCase format

**Examples:**
```dart
"hello_world".pascalCase // Returns "HelloWorld"
"helloWorld".pascalCase // Returns "HelloWorld"
"my-awesome-class".pascalCase // Returns "MyAwesomeClass"
```

#### kebabCase

Converts a string to kebab-case format.

**Returns:**
- A string in kebab-case format

**Examples:**
```dart
"helloWorld".kebabCase // Returns "hello-world"
"my_awesome_class".kebabCase // Returns "my-awesome-class"
"HelloWorld".kebabCase // Returns "hello-world"
```

## Error Handling

The tool provides comprehensive error handling with informative messages:

### Common Error Messages

- **"Tên component không được để trống"** - Component name cannot be empty
- **"File ds_app_theme.dart không tồn tại"** - Required theme file doesn't exist
- **"Lỗi khi format code"** - Error occurred during code formatting
- **"Lỗi khi tạo component"** - General error during component creation

### Error Recovery

- The tool gracefully handles missing directories by creating them
- Existing files are not overwritten (tool reports they already exist)
- Format errors don't stop the generation process
- Detailed stack traces are provided for debugging

## Usage Examples

### Basic Component Creation

```dart
import 'package:component_creator/tool/component_creator.dart';

void main() {
  final creator = ComponentCreator();
  creator.run(['MyButton']); // Will prompt for variant choice
}
```

### Custom File Operations

```dart
import 'package:component_creator/tool/file_utils.dart';

// Create directory
FileUtils.createDirIfNotExist(Directory('lib/custom'));

// Check if file exists
if (!FileUtils.fileExists('lib/custom/file.dart')) {
  FileUtils.writeFile('lib/custom/file.dart', '// Custom content');
}
```

### String Manipulation

```dart
import 'package:component_creator/utils/string_utils.dart';

String componentName = "MyAwesomeButton";
String fileName = componentName.snakeCase; // "my_awesome_button"
String className = componentName.pascalCase; // "MyAwesomeButton"
String kebabName = componentName.kebabCase; // "my-awesome-button"
```

### Interactive Component Variants Usage (v0.0.6+)

```dart
// Generated enum in theme extension (only if variants were chosen)
enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
}

// Usage in component with optional variant parameter
class DSButton extends StatefulWidget {
  final DSButtonVariants? variant; // Optional if variants were chosen
  
  const DSButton({
    super.key,
    this.variant = DSButtonVariants.primary, // Only if variants were chosen
  });
  
  // ... rest of implementation
}

// Usage in state class with consistent theme extension naming
class _DSButtonState extends DSStateBase<DSButton> {
  late DSButtonTheme componentTheme = theme
      .extension<DSButtonThemeExtension>()!
      .dSButtonTheme; // Fixed reference
  
  // ... rest of implementation
}

// Usage examples (with variants)
DSButton(variant: DSButtonVariants.primary)
DSButton(variant: DSButtonVariants.secondary)
DSButton() // Uses default primary variant

// Usage examples (without variants)
DSButton() // Simple component without variants
DSButton(key: Key('my-button'))

// App theme integration with consistent naming
class DSAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      extensions: [
        DSButtonThemeExtension(), // Consistent naming
        // ... other extensions
      ],
    );
  }
}
```

### Interactive Flow (v0.0.6+)

The tool now provides an interactive flow for component creation:

1. **Component Name Input**: User enters component name
2. **Variant Choice Prompt**: Tool asks "Bạn có muốn tạo variants không? (y/n):"
3. **Conditional Generation**: Based on user choice:
   - **Yes**: Generates component with variants enum and variant parameter
   - **No**: Generates component without variants (simpler structure)
4. **File Generation**: Creates all necessary files with appropriate structure

### New Features in v0.0.6

#### Interactive Variant Choice
- **User Control**: Users can choose whether to create variants for their components
- **Flexible Generation**: Components are generated with or without variants based on user choice
- **Smart Defaults**: When variants are chosen, default variants (primary, secondary, outline, ghost) are automatically included
- **Simplified Components**: Create simple components without unnecessary complexity

#### Template Flexibility
- **Conditional Generation**: Templates adapt based on variant choice
- **Optional Variant Support**: Components can be generated with or without variants
- **Better Code Organization**: Cleaner template structure with conditional sections
- **Enhanced User Experience**: More granular control over component generation process

#### Technical Improvements
- **Interactive Prompts**: Added user prompts for variant creation choice
- **Template Updates**: Updated `statefulWidget()` and `themeExtensionFileContent()` methods to support optional variants
- **Method Signatures**: Enhanced method signatures to accept optional custom variants parameter
- **Conditional Logic**: Added conditional logic for variant field and parameter generation
- **Improved Code Structure**: Better organization of template generation with conditional sections

### Breaking Changes in v0.0.4

#### Theme Extension Class Names
- **Before**: `${className}ThemeExt`
- **After**: `${className}ThemeExtension`

#### Instance References
- **Before**: `${className}Extension()`
- **After**: `${className}ThemeExtension()`

#### Migration Guide
If you have existing components generated with previous versions:
1. Update any manual references to theme extension classes
2. Update app theme file extension references
3. Regenerate components for consistency

### Bug Fixes in v0.0.5

#### StatefulWidget Template Fix
- **Before (v0.0.4 and earlier)**: Template used `${className}ThemeExt` in theme extension reference
- **After (v0.0.5+)**: Template now uses `${className}ThemeExtension` for consistency

#### Template Consistency
- **Fixed Reference**: StatefulWidget template now correctly references theme extensions
- **Test Updates**: Updated test cases to verify correct template generation
- **Consistency**: All templates now use the same naming pattern

### Naming Conventions Summary

| Component | Class Name | Theme Extension | Instance Reference |
|-----------|------------|-----------------|-------------------|
| Button | DSButton | DSButtonThemeExtension | DSButtonThemeExtension() |
| CustomCard | DSCustomCard | DSCustomCardThemeExtension | DSCustomCardThemeExtension() |
| MyWidget | DSMyWidget | DSMyWidgetThemeExtension | DSMyWidgetThemeExtension() | 