# Quick Reference Guide

A fast reference for common Component Creator commands, examples, and troubleshooting.

## 🚀 Quick Commands

### Installation
```bash
# Install globally
dart pub global activate component_creator

# Install from source
git clone <repo-url>
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

### Testing
```bash
# Run tests
dart test

# Run with coverage
dart test --coverage=coverage
```

## 📝 Common Examples

### Create Basic Components
```bash
component_creator Button
component_creator Card
component_creator Input
component_creator Avatar
component_creator Modal
```

### Create Complex Components
```bash
component_creator "Custom Button"
component_creator "Data Table"
component_creator "User Profile Card"
component_creator "Search Input"
component_creator "Notification Badge"
```

### Batch Creation
```bash
# Create multiple components
for component in Button Card Input Avatar; do
  component_creator $component
done
```

## 🔧 Generated File Structure

For component "Button":
```
lib/
├── components/
│   └── ds_button/
│       └── ds_button.dart              # Main widget
└── theme/
    ├── ds_theme.dart                   # Updated with parts
    ├── base/app_theme/
    │   └── ds_app_theme.dart           # Updated with extensions
    └── components/
        └── ds_button/
            ├── ds_button_theme.dart    # Theme class
            └── ds_button_theme.ext.dart # Theme extension
```

## 📋 Naming Conventions

| Input | Component Class | File Name | Theme Class | Theme Extension |
|-------|----------------|-----------|-------------|-----------------|
| `Button` | `DSButton` | `ds_button.dart` | `DSButtonTheme` | `DSButtonThemeExt` |
| `CustomCard` | `DSCustomCard` | `ds_custom_card.dart` | `DSCustomCardTheme` | `DSCustomCardThemeExt` |
| `MyWidget` | `DSMyWidget` | `ds_my_widget.dart` | `DSMyWidgetTheme` | `DSMyWidgetThemeExt` |

## 🛠️ String Utilities

### Case Conversion
```dart
import 'package:component_creator/utils/string_utils.dart';

// Convert to different cases
'helloWorld'.snakeCase      // 'hello_world'
'hello_world'.camelCase     // 'helloWorld'
'hello_world'.pascalCase    // 'HelloWorld'
'helloWorld'.kebabCase      // 'hello-world'
```

### Examples
```dart
'MyAwesomeComponent'.snakeCase   // 'my_awesome_component'
'my_awesome_component'.camelCase // 'myAwesomeComponent'
'my_awesome_component'.pascalCase // 'MyAwesomeComponent'
'MyAwesomeComponent'.kebabCase   // 'my-awesome-component'
```

## 📄 Template Examples

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

### Theme Class Template
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

## 🐛 Common Issues & Solutions

### Issue: "File ds_app_theme.dart không tồn tại"
**Solution:**
```bash
# Create required directory and file
mkdir -p lib/theme/base/app_theme
touch lib/theme/base/app_theme/ds_app_theme.dart
```

**Basic ds_app_theme.dart content:**
```dart
import 'package:flutter/material.dart';

class DSAppTheme {
  final List<ThemeExtension> extensions;
  
  const DSAppTheme({
    this.extensions = const [],
  });
}
```

### Issue: "Lỗi khi format code"
**Solution:**
```bash
# Check Dart installation
which dart

# Try manual formatting
dart format lib

# Install Dart if needed
# Follow Dart installation guide
```

### Issue: "Tên component không được để trống"
**Solution:**
```bash
# Provide component name
component_creator Button

# Or use interactive mode
component_creator
# Then enter: Button
```

### Issue: Generated files don't compile
**Solution:**
1. Check `pubspec.yaml` dependencies
2. Run `flutter pub get`
3. Verify import paths
4. Check design system package configuration

## 🔍 Debug Commands

### Verbose Output
```bash
# Add debug prints to component_creator.dart
print('Debug: Creating component: $className');
print('Debug: Snake case name: $snakeName');
```

### Check File Structure
```bash
# Verify generated files
ls -la lib/components/
ls -la lib/theme/components/
cat lib/theme/ds_theme.dart
```

### Test String Utilities
```dart
// Test case conversion
print('Button'.snakeCase);        // ds_button
print('CustomCard'.snakeCase);    // ds_custom_card
print('MyWidget'.snakeCase);      // ds_my_widget
```

## 📚 File Locations

### Source Files
```
component_creator/
├── bin/component_creator.dart          # CLI entry point
├── lib/tool/component_creator.dart     # Main logic
├── lib/tool/templates.dart             # Templates
├── lib/tool/file_utils.dart            # File utilities
└── lib/utils/string_utils.dart         # String utilities
```

### Generated Files (in your Flutter project)
```
your_project/
├── lib/components/                     # Component widgets
├── lib/theme/ds_theme.dart             # Main theme file
├── lib/theme/base/app_theme/           # App theme
└── lib/theme/components/               # Component themes
```

## 🎯 Best Practices

### Component Naming
- Use **PascalCase** (e.g., `Button`, `CustomCard`)
- Avoid special characters and spaces
- Use descriptive, meaningful names
- Keep names concise but clear

### File Organization
- Don't manually modify generated structure
- Use the tool for all component creation
- Keep components in designated directories
- Maintain consistent naming patterns

### Theme Integration
- Define theme properties in generated theme class
- Use `copyWith` and `lerp` methods properly
- Follow design system guidelines
- Test theme changes thoroughly

### Code Quality
- Add proper documentation to generated code
- Follow Flutter best practices
- Test components before using in production
- Keep generated code up to date

## 🔗 Useful Commands

### Development
```bash
# Install dependencies
dart pub get

# Run tests
dart test

# Format code
dart format .

# Analyze code
dart analyze
```

### Project Management
```bash
# Check version
dart pub deps

# Update dependencies
dart pub upgrade

# Clean build
dart pub cache clean
```

### Git Integration
```bash
# Add generated files
git add lib/components/ lib/theme/

# Commit changes
git commit -m "feat: add Button component"

# Check status
git status
```

## 📞 Getting Help

### Documentation
- **[Main README](../README.md)** - Project overview
- **[Usage Guide](USAGE_GUIDE.md)** - Detailed instructions
- **[API Documentation](API.md)** - Complete reference
- **[Contributing Guide](CONTRIBUTING.md)** - How to contribute

### Community
- **GitHub Issues** - Report bugs and request features
- **GitHub Discussions** - Ask questions and share ideas
- **Pull Requests** - Contribute code and documentation

### Quick Links
- [Installation Guide](../README.md#installation)
- [Usage Examples](USAGE_GUIDE.md#examples)
- [Troubleshooting](USAGE_GUIDE.md#troubleshooting)
- [API Reference](API.md)
- [Contributing Guidelines](CONTRIBUTING.md)

---

*This quick reference guide provides fast access to common tasks. For detailed information, see the full documentation.* 