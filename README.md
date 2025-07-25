# Component Creator

[![Pub Version](https://img.shields.io/pub/v/component_creator)](https://pub.dev/packages/component_creator)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Dart Version](https://img.shields.io/badge/dart-3.7.2+-blue.svg)](https://dart.dev/)

A powerful CLI tool for automatically generating Flutter components with integrated design system theming. Streamlines the process of creating new Flutter widgets by generating all necessary files including the component widget, theme files, and proper integration with your design system.

## ✨ Features

- 🚀 **Automated Component Generation**: Create Flutter components with a single command
- 🎨 **Design System Integration**: Automatic theme file generation and integration
- 🔧 **Interactive Component Variants**: Choose whether to create variants for your components
- 📁 **Organized File Structure**: Creates proper directory structure for components and themes
- 🎯 **Smart Naming Conventions**: Automatic conversion between PascalCase, snake_case, and camelCase
- 🔄 **Code Formatting**: Automatic code formatting using Dart formatter
- 💡 **Interactive Mode**: User-friendly interactive component creation with variant choice
- 🛡️ **Error Handling**: Comprehensive error handling with helpful messages
- 📚 **Comprehensive Documentation**: Detailed guides and API documentation
- ⚡ **Smart Defaults**: Components come with automatic variant parameters and default variants when chosen
- 🎯 **Consistent Naming**: Theme extension classes follow consistent naming conventions
- ✅ **Template Consistency**: All templates use consistent theme extension references
- 🔄 **Flexible Generation**: Generate components with or without variants based on user choice

## 🚀 Quick Start

### Installation

```bash
dart pub global activate component_creator
```

### Create Your First Component

```bash
# Interactive mode with variant choice
component_creator

# Direct mode (will prompt for variants)
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### Interactive Flow

1. **Enter component name** when prompted
2. **Choose whether to create variants** (y/n)
3. **Get your generated component** with or without variants

### What Gets Generated

For a component named "Button" with variants chosen:

```
lib/
├── components/
│   └── ds_button/
│       └── ds_button.dart              # Main component widget (with variant parameter)
└── theme/
    ├── ds_theme.dart                   # Updated with new parts
    ├── base/
    │   └── app_theme/
    │       └── ds_app_theme.dart       # Updated with properly formatted extensions
    └── components/
        └── ds_button/
            ├── ds_button_theme.dart    # Theme class
            └── ds_button_theme.ext.dart # Theme extension with variants enum
```

## 🎨 Interactive Component Variants (v0.0.6+)

Starting from version 0.0.6, the tool now offers **interactive component variants creation** with flexible generation options:

### Interactive Variant Choice

When you run the tool, you'll be prompted to choose whether to create variants:

```bash
component_creator
# Enter component name: Button
# Bạn có muốn tạo variants không? (y/n): y
```

### Generated Component (with variants chosen)

```dart
// Generated component with automatic variant parameter
class DSButton extends StatefulWidget {
  final DSButtonVariants variant;
  const DSButton({
    super.key,
    this.variant = DSButtonVariants.primary,
  });
  
  // ... implementation
}

// Generated enum with default variants
enum DSButtonVariants {
  primary,
  secondary,
  outline,
  ghost,
}

// Generated theme extension with consistent naming
class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  DSButtonTheme get dSButtonTheme => DSButtonTheme(
        // TODO: Configure theme properties for DSButton component
      );
  // ... implementation
}
```

### Generated Component (without variants chosen)

```dart
// Generated component without variant parameter (simpler structure)
class DSButton extends StatefulWidget {
  const DSButton({
    super.key,
  });
  
  // ... implementation
}

// Generated theme extension without variants enum
class DSButtonThemeExtension extends ThemeExtension<DSButtonThemeExtension> {
  DSButtonTheme get dSButtonTheme => DSButtonTheme(
        // TODO: Configure theme properties for DSButton component
      );
  // ... implementation
}
```

### Benefits of Interactive Variants

- **User Choice**: Decide whether your component needs variants
- **Flexible Generation**: Generate components with or without variants
- **Simplified Components**: Create simple components without unnecessary complexity
- **Smart Defaults**: When variants are chosen, common variants are automatically included
- **Better UX**: More granular control over component generation process
- **Consistent Naming**: Theme extension classes follow clear naming conventions
- **Template Consistency**: All templates use consistent theme extension references

## 📖 Documentation

- **[Usage Guide](doc/USAGE_GUIDE.md)**: Step-by-step instructions and examples
- **[API Documentation](doc/API.md)**: Detailed API reference
- **[Contributing Guide](doc/CONTRIBUTING.md)**: How to contribute to the project
- **[Quick Reference](doc/QUICK_REFERENCE.md)**: Quick commands and examples
- **[Publishing Guide](doc/PUBLISHING.md)**: How to publish updates

## 🛠️ Installation

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

## 📋 Requirements

### Project Structure

Your Flutter project should have this structure:

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

Create the required app theme file:

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

## 🎯 Usage Examples

### Basic Component Creation

```bash
# Create a button component with interactive variant choice
component_creator Button

# Create a card component
component_creator Card

# Create a custom widget
component_creator "Custom Avatar"
```

### Interactive Mode

```bash
component_creator
# Enter component name when prompted
# Choose whether to create variants (y/n)
```

### Using Generated Components

#### With Variants
```dart
// Use with specific variant
DSButton(variant: DSButtonVariants.primary)
DSButton(variant: DSButtonVariants.secondary)
DSButton(variant: DSButtonVariants.outline)
DSButton(variant: DSButtonVariants.ghost)

// Use default variant
DSButton() // Automatically uses DSButtonVariants.primary
```

#### Without Variants
```dart
// Simple component without variants
DSButton()
DSButton(key: Key('my-button'))
```

### Generated Component Example

```dart
// lib/components/ds_button/ds_button.dart
import '../../theme/ds_theme.dart';
import 'package:flutter/material.dart';
import 'package:design_system_project/base/ds_base.dart';

class DSButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final DSButtonVariants variant; // Only if variants were chosen
  
  const DSButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = DSButtonVariants.primary, // Only if variants were chosen
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
    // Only if variants were chosen
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

### Generated Theme Extension

```dart
// lib/theme/components/ds_button/ds_button_theme.ext.dart
part of '../../ds_theme.dart';

// Only if variants were chosen
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

## 🔧 Configuration

### Naming Conventions

The tool automatically handles naming conventions:

| Input | Component Class | File Name | Theme Class | Theme Extension |
|-------|----------------|-----------|-------------|-----------------|
| `Button` | `DSButton` | `ds_button.dart` | `DSButtonTheme` | `DSButtonThemeExtension` |
| `CustomCard` | `DSCustomCard` | `ds_custom_card.dart` | `DSCustomCardTheme` | `DSCustomCardThemeExtension` |
| `MyAwesomeWidget` | `DSMyAwesomeWidget` | `ds_my_awesome_widget.dart` | `DSMyAwesomeWidgetTheme` | `DSMyAwesomeWidgetThemeExtension` |

### Customization

After generation, you can customize:

1. **Theme Properties**: Add colors, sizes, and other design tokens
2. **Component Logic**: Implement the widget's build method
3. **Component Variants**: Modify or add variants in the generated enum (if variants were chosen)
4. **Styling**: Add variant-specific styling logic (if variants were chosen)

## 🐛 Troubleshooting

### Common Issues

#### 1. "File ds_app_theme.dart không tồn tại"

Create the required app theme file:

```bash
mkdir -p lib/theme/base/app_theme
touch lib/theme/base/app_theme/ds_app_theme.dart
```

#### 2. "Lỗi khi format code"

Ensure Dart formatter is available:

```bash
dart pub global activate dart_style
```

#### 3. Import errors

Add required dependencies to `pubspec.yaml`:

```yaml
dependencies:
  design_system_project:
    path: ../design_system_project
```

### Getting Help

- Check the [Usage Guide](doc/USAGE_GUIDE.md) for detailed instructions
- Review the [API Documentation](doc/API.md) for technical details
- Open an issue on GitHub for bugs or feature requests

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](doc/CONTRIBUTING.md) for details.

### Development Setup

```bash
git clone https://github.com/your-username/component_creator.git
cd component_creator
dart pub get
dart pub global activate --source path .
```

### Running Tests

```bash
dart test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🗺️ Roadmap

### Version 0.1.0 (Planned)
- [ ] Support for StatelessWidget components
- [ ] Custom template configuration
- [ ] Interactive component creation wizard

### Version 0.2.0 (Planned)
- [ ] Configuration file support
- [ ] Internationalization for error messages
- [ ] Component name validation and suggestions

### Version 0.3.0 (Planned)
- [ ] IDE integration
- [ ] Batch component creation
- [ ] Advanced template customization

### Version 1.0.0 (Planned)
- [ ] Stable release with comprehensive feature set
- [ ] Performance optimizations
- [ ] Extensive documentation and examples

## 📊 Version History

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

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Dart team for the powerful language
- The Flutter community for inspiration and feedback

---

**Made with ❤️ for the Flutter community**

For questions, issues, or contributions, please visit our [GitHub repository](https://github.com/your-username/component_creator).
