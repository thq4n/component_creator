# Contributing to Component Creator

Thank you for your interest in contributing to the Component Creator project! This document provides guidelines and information for contributors.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Code Style and Standards](#code-style-and-standards)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Issue Reporting](#issue-reporting)
- [Feature Requests](#feature-requests)

## Getting Started

### Prerequisites

Before contributing, ensure you have:

- **Dart SDK** (>= 3.7.2)
- **Flutter SDK**
- **Git**
- A code editor (VS Code, IntelliJ IDEA, etc.)

### Fork and Clone

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/component_creator.git
   cd component_creator
   ```
3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/component_creator.git
   ```

## Development Setup

### Install Dependencies

```bash
dart pub get
```

### Make the Tool Executable

```bash
dart pub global activate --source path .
```

### Verify Installation

```bash
component_creator --help
# or
dart run bin/component_creator.dart --help
```

### Project Structure

```
component_creator/
├── bin/
│   └── component_creator.dart          # CLI entry point
├── lib/
│   ├── tool/
│   │   ├── component_creator.dart      # Main logic
│   │   ├── templates.dart              # Template definitions
│   │   └── file_utils.dart             # File utilities
│   └── utils/
│       └── string_utils.dart           # String utilities
├── test/
│   └── component_creator_test.dart     # Tests
├── example/                            # Example Flutter project
├── docs/                              # Documentation
└── pubspec.yaml                       # Package configuration
```

## Code Style and Standards

### Dart Code Style

Follow the official Dart style guide:

- Use **2 spaces** for indentation
- Use **snake_case** for variables, functions, and file names
- Use **PascalCase** for classes and enums
- Use **camelCase** for method names
- Add **trailing commas** for multi-line collections
- Use **const constructors** when possible
- Add **documentation comments** for public APIs

### Documentation Standards

- Add **dartdoc comments** for all public APIs
- Include **examples** in documentation
- Use **markdown formatting** in comments
- Document **parameters**, **return values**, and **exceptions**

### Example Documentation

```dart
/// Creates a new Flutter component with integrated theming.
///
/// This method generates all necessary files for a Flutter component
/// including the widget, theme files, and proper integration with
/// the design system.
///
/// Example:
/// ```dart
/// final creator = ComponentCreator();
/// creator.run(['Button']); // Creates a Button component
/// ```
///
/// [args] - Command line arguments. The first argument should be the component name.
///
/// Throws [ArgumentError] if the component name is empty.
void run(List<String> args) {
  // Implementation...
}
```

### Error Handling

- Use **descriptive error messages**
- Include **context information** in errors
- Provide **suggestions** for fixing issues
- Use **proper exception types**

```dart
if (componentName == null || componentName.trim().isEmpty) {
  throw ArgumentError('Component name cannot be empty. Please provide a valid name.');
}
```

### Logging

- Use **consistent logging messages**
- Include **progress information**
- Provide **helpful feedback** to users
- Use **appropriate log levels**

```dart
print('Creating component widget: $componentFilePath');
print('Updating theme file with new parts...');
print('Successfully created component: $className');
```

## Testing

### Running Tests

```bash
# Run all tests
dart test

# Run tests with coverage
dart test --coverage=coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html
```

### Writing Tests

Create comprehensive tests for all functionality:

```dart
import 'package:test/test.dart';
import 'package:component_creator/tool/component_creator.dart';

void main() {
  group('ComponentCreator', () {
    test('should create component with valid name', () {
      final creator = ComponentCreator();
      // Test implementation
    });

    test('should throw error with empty name', () {
      final creator = ComponentCreator();
      expect(() => creator.run(['']), throwsArgumentError);
    });
  });
}
```

### Test Structure

- **Unit tests** for individual methods
- **Integration tests** for file operations
- **Template tests** for generated code
- **Error handling tests** for edge cases

### Test Coverage

Aim for **90%+ test coverage**:
- Test all public methods
- Test error conditions
- Test edge cases
- Test file operations

## Submitting Changes

### Creating a Branch

```bash
# Create a new branch for your feature
git checkout -b feature/your-feature-name

# Or for bug fixes
git checkout -b fix/your-bug-description
```

### Making Changes

1. **Make your changes** following the code style guidelines
2. **Add tests** for new functionality
3. **Update documentation** if needed
4. **Run tests** to ensure everything works

### Committing Changes

Use **conventional commit messages**:

```bash
# Feature
git commit -m "feat: add support for custom theme templates"

# Bug fix
git commit -m "fix: handle empty component names gracefully"

# Documentation
git commit -m "docs: update API documentation"

# Test
git commit -m "test: add tests for theme generation"

# Refactor
git commit -m "refactor: improve error handling in file utils"
```

### Commit Message Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/tool changes

### Pushing Changes

```bash
# Push your branch to your fork
git push origin feature/your-feature-name
```

### Creating a Pull Request

1. **Go to your fork** on GitHub
2. **Click "New Pull Request"**
3. **Select your branch** as the source
4. **Fill out the PR template**:

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Test addition
- [ ] Refactoring

## Testing
- [ ] Tests pass locally
- [ ] Added tests for new functionality
- [ ] Updated existing tests

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] No breaking changes
```

## Issue Reporting

### Before Reporting

1. **Check existing issues** for duplicates
2. **Search documentation** for solutions
3. **Try the latest version** of the tool
4. **Reproduce the issue** consistently

### Issue Template

```markdown
## Bug Description
Clear description of the bug

## Steps to Reproduce
1. Run command: `component_creator Button`
2. Expected: Component created successfully
3. Actual: Error message appears

## Environment
- OS: macOS 12.0
- Dart version: 3.7.2
- Flutter version: 3.16.0
- Component Creator version: 0.0.1

## Error Message
```
Error: File ds_app_theme.dart không tồn tại
```

## Additional Context
Any additional information that might help
```

## Feature Requests

### Before Requesting

1. **Check if the feature already exists**
2. **Consider if it fits the project scope**
3. **Think about implementation complexity**
4. **Consider backward compatibility**

### Feature Request Template

```markdown
## Feature Description
Clear description of the requested feature

## Use Case
Why this feature is needed and how it would be used

## Proposed Implementation
Optional: Suggestions for how to implement

## Alternatives Considered
Other approaches that were considered

## Additional Context
Any other relevant information
```

## Code Review Process

### Review Checklist

When reviewing code, check for:

- [ ] **Functionality**: Does the code work as intended?
- [ ] **Style**: Does it follow Dart style guidelines?
- [ ] **Documentation**: Is the code well-documented?
- [ ] **Tests**: Are there adequate tests?
- [ ] **Performance**: Is the code efficient?
- [ ] **Security**: Are there any security concerns?
- [ ] **Accessibility**: Does it maintain accessibility?

### Review Comments

Provide **constructive feedback**:

```markdown
Good: "Consider using a more descriptive variable name here"

Better: "The variable name `x` could be more descriptive. Consider using `componentName` instead."
```

## Release Process

### Version Bumping

Update version in `pubspec.yaml`:

```yaml
version: 0.1.0  # Increment appropriately
```

### Changelog

Update `CHANGELOG.md` with:

- **New features**
- **Bug fixes**
- **Breaking changes**
- **Deprecations**

### Release Checklist

- [ ] All tests pass
- [ ] Documentation updated
- [ ] Changelog updated
- [ ] Version bumped
- [ ] Tagged release on GitHub

## Getting Help

### Communication Channels

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Pull Requests**: For code contributions

### Code of Conduct

- **Be respectful** and inclusive
- **Provide constructive feedback**
- **Help others** when possible
- **Follow project guidelines**

## Recognition

Contributors will be recognized in:

- **README.md** contributors section
- **Release notes**
- **GitHub contributors page**

Thank you for contributing to Component Creator! Your contributions help make this tool better for the entire Flutter community. 