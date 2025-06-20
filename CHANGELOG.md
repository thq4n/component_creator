# Changelog

All notable changes to the Component Creator project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Add support for StatelessWidget components
- Add configuration file for customizing templates
- Add support for different naming conventions
- Add interactive component creation wizard

## [0.0.2] - 2025-06-20

### Added
- **Component Variants Support**: Added enum generation for component variants in theme extensions
- **Enhanced Theme Extensions**: Each component now includes a `${className}Variants` enum for defining component variants (primary, secondary, etc.)
- **Improved Template Structure**: Better organization of theme extension templates with variant support

### Features
- **Component Variants**: Automatically generates enum for component variants in theme extensions
- **Enhanced Theme Integration**: Better structure for theme extensions with variant definitions
- **Improved Code Organization**: Cleaner template structure for theme extensions

### Technical Details
- **New Template Feature**: Theme extensions now include `${className}Variants` enum
- **Enhanced Templates**: Updated `themeExtensionFileContent()` method to include variant enum
- **Better Code Structure**: Improved organization of generated theme extension code

### Generated Files
For each component, the tool now generates:
1. **Component Widget**: `lib/components/ds_{component_name}/ds_{component_name}.dart`
2. **Theme Class**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.dart`
3. **Theme Extension**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.ext.dart` (now with variants enum)
4. **Theme Integration**: Updates `lib/theme/ds_theme.dart` with part directives
5. **App Theme Integration**: Updates `lib/theme/base/app_theme/ds_app_theme.dart` with extensions

### Example Generated Theme Extension
```dart
part of '../../ds_theme.dart';

enum DSButtonVariants {
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

### Usage Examples
```bash
# Interactive mode
component_creator

# Direct mode
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### Breaking Changes
- None

### Known Issues
- Limited to StatefulWidget components only
- No support for custom template customization
- Error messages are in Vietnamese only
- No validation for component name format

### Future Enhancements
- Support for StatelessWidget components
- Custom template configuration
- Internationalization for error messages
- Component name validation and suggestions
- Interactive component creation wizard
- Integration with popular IDEs

## [0.0.1] - 2025-06-20

### Added
- Initial release of Component Creator CLI tool
- Automated Flutter component generation with design system integration
- Support for StatefulWidget component creation
- Automatic theme file generation (theme class and theme extension)
- Integration with design system theme structure
- Automatic code formatting using Dart formatter
- Smart naming convention conversion (PascalCase, snake_case, camelCase)
- File structure management and directory creation
- Error handling with informative Vietnamese error messages
- Support for both interactive and command-line modes

### Features
- **Component Widget Generation**: Creates StatefulWidget components with proper imports and theme integration
- **Theme Integration**: Automatically generates theme classes and extensions
- **File Organization**: Creates organized directory structure for components and themes
- **Design System Integration**: Updates main theme files with new component parts
- **Code Formatting**: Automatically formats generated code using Dart formatter
- **Naming Conventions**: Converts component names to appropriate naming conventions
- **Error Handling**: Comprehensive error handling with helpful error messages

### Technical Details
- **Entry Point**: `bin/component_creator.dart` - CLI entry point
- **Main Logic**: `lib/tool/component_creator.dart` - Core component creation logic
- **Templates**: `lib/tool/templates.dart` - Template definitions for generated files
- **File Utils**: `lib/tool/file_utils.dart` - File and directory utility functions
- **String Utils**: `lib/utils/string_utils.dart` - String manipulation and case conversion utilities

### Generated Files
For each component, the tool generates:
1. **Component Widget**: `lib/components/ds_{component_name}/ds_{component_name}.dart`
2. **Theme Class**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.dart`
3. **Theme Extension**: `lib/theme/components/ds_{component_name}/ds_{component_name}_theme.ext.dart`
4. **Theme Integration**: Updates `lib/theme/ds_theme.dart` with part directives
5. **App Theme Integration**: Updates `lib/theme/base/app_theme/ds_app_theme.dart` with extensions

### Usage Examples
```bash
# Interactive mode
component_creator

# Direct mode
component_creator Button
component_creator "Custom Card"
component_creator MyAwesomeWidget
```

### Dependencies
- Dart SDK >= 3.7.2
- Flutter SDK
- design_system_project package (for generated components)

### Project Structure
```
component_creator/
├── bin/
│   └── component_creator.dart          # CLI entry point
├── lib/
│   ├── tool/
│   │   ├── component_creator.dart      # Main component creator logic
│   │   ├── templates.dart              # Template definitions
│   │   └── file_utils.dart             # File utility functions
│   └── utils/
│       └── string_utils.dart           # String manipulation utilities
├── test/
│   └── component_creator_test.dart     # Test files
├── example/                            # Example Flutter project
├── doc/                               # Documentation
└── pubspec.yaml                        # Package configuration
```

### Installation
```bash
# From source
git clone <repository-url>
cd component_creator
dart pub get
dart pub global activate --source path .

# Global installation
dart pub global activate component_creator
```

### Documentation
- **README.md**: Comprehensive project overview and usage instructions
- **doc/API.md**: Detailed API documentation for all classes and methods
- **doc/USAGE_GUIDE.md**: Step-by-step usage guide with examples
- **doc/CONTRIBUTING.md**: Guidelines for contributors

### Testing
- Basic test structure in place
- Unit tests for core functionality
- Integration tests for file operations

### Known Issues
- Limited to StatefulWidget components only
- No support for custom template customization
- Error messages are in Vietnamese only
- No validation for component name format

### Future Enhancements
- Support for StatelessWidget components
- Custom template configuration
- Internationalization for error messages
- Component name validation and suggestions
- Support for component variants
- Interactive component creation wizard
- Integration with popular IDEs

---

## Version History

### Version 0.0.2
- **Release Date**: 2025-06-20
- **Status**: Latest release
- **Features**: Component variants support, enhanced theme extensions
- **Target**: Flutter developers using design systems with variant support

### Version 0.0.1
- **Release Date**: 2025-06-20
- **Status**: Previous release
- **Features**: Basic component generation with design system integration
- **Target**: Flutter developers using design systems

### Version Planning
- **0.1.0**: Add StatelessWidget support and custom templates
- **0.2.0**: Add configuration file and internationalization
- **0.3.0**: Add interactive wizard and IDE integration
- **1.0.0**: Stable release with comprehensive feature set

---

## Contributing

See [CONTRIBUTING.md](doc/CONTRIBUTING.md) for details on how to contribute to this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Release Notes

### Version 0.0.2 Release Notes

**What's New:**
- 🎉 Component variants support
- 🚀 Enhanced theme extensions with enum generation
- 🎨 Better template structure for theme extensions
- 📝 Improved code organization

**Getting Started:**
1. Install the tool: `dart pub global activate component_creator`
2. Create your first component: `component_creator Button`
3. Customize the generated variants enum
4. Use in your Flutter project

**Breaking Changes:**
- None

**New Features:**
- Component variants enum generation
- Enhanced theme extension templates
- Better code organization

**Next Steps:**
- Add StatelessWidget support
- Implement custom templates
- Add internationalization
- Create interactive wizard

### Version 0.0.1 Release Notes

**What's New:**
- 🎉 Initial release of Component Creator
- 🚀 Automated Flutter component generation
- 🎨 Design system integration
- 📁 Organized file structure
- 🔧 Automatic code formatting

**Getting Started:**
1. Install the tool: `dart pub global activate component_creator`
2. Create your first component: `component_creator Button`
3. Customize the generated code
4. Use in your Flutter project

**Breaking Changes:**
- None (initial release)

**Known Limitations:**
- Only supports StatefulWidget components
- Error messages in Vietnamese
- No custom template support

**Next Steps:**
- Add StatelessWidget support
- Implement custom templates
- Add internationalization
- Create interactive wizard

---

*This changelog follows the [Keep a Changelog](https://keepachangelog.com/) format and [Semantic Versioning](https://semver.org/) principles.*
