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

Main entry point for the component creation process.

**Parameters:**
- `args` - Command line arguments. The first argument should be the component name.

**Behavior:**
- If no arguments are provided, prompts the user for a component name
- Validates the component name is not empty
- Converts the name to appropriate naming conventions
- Calls all generation methods in sequence
- Handles errors and provides informative error messages

**Example:**
```dart
final creator = ComponentCreator();
creator.run(['Button']); // Creates a Button component
```

#### _createComponentWidget(String className, String snakeName)

Creates the main component widget file.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `snakeName` - The snake_case file name (e.g., "ds_button")

**Creates:**
- Directory: `lib/components/ds_button/`
- File: `lib/components/ds_button/ds_button.dart`

#### _createThemeComponent(String className, String snakeName)

Creates theme-related files for the component.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `snakeName` - The snake_case file name (e.g., "ds_button")

**Creates:**
- Directory: `lib/theme/components/ds_button/`
- File: `lib/theme/components/ds_button/ds_button_theme.dart`
- File: `lib/theme/components/ds_button/ds_button_theme.ext.dart`

#### _updateDsThemeFile(String snakeName)

Updates the main theme file to include the new component's theme parts.

**Parameters:**
- `snakeName` - The snake_case file name (e.g., "ds_button")

**Updates:**
- Adds part "../docs"directives to `lib/theme/ds_theme.dart`
- Creates the file if it doesn't exist

#### _updateDsAppThemeExtensions(String className)

Updates the app theme file to include the new component's theme extension.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")

**Updates:**
- Adds the component's theme extension to the extensions array in `lib/theme/base/app_theme/ds_app_theme.dart`

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

Static class containing all template strings for generating different file types.

### Methods

#### statefulWidget(String className, String snakeFileName)

Generates the template for a StatefulWidget component.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")
- `snakeFileName` - The snake_case file name (e.g., "ds_button")

**Returns:**
- A string containing the complete StatefulWidget template

**Template includes:**
- Proper imports for theme and Flutter
- StatefulWidget class definition
- State class extending DSStateBase
- Theme integration setup
- Basic build method structure

#### themeFileContent(String className)

Generates the template for a component theme file.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")

**Returns:**
- A string containing the theme class template

**Template includes:**
- Part directive for ds_theme.dart
- Theme class definition with TODO comment

#### themeExtensionFileContent(String className)

Generates the template for a component theme extension file.

**Parameters:**
- `className` - The PascalCase class name (e.g., "DSButton")

**Returns:**
- A string containing the theme extension template

**Template includes:**
- Part directive for ds_theme.dart
- ThemeExtension class definition
- Theme instance property
- copyWith and lerp method implementations

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
"MyAwesomeClass".camelCase // Returns "myAwesomeClass"
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
  creator.run(['MyButton']);
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