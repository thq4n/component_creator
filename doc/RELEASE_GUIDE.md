# Release Guide

Hướng dẫn chi tiết các bước để release một version mới của Component Creator tool.

## Table of Contents

- [Tổng quan](#tổng-quan)
- [Chuẩn bị trước khi release](#chuẩn-bị-trước-khi-release)
- [Các bước release](#các-bước-release)
- [Kiểm tra sau release](#kiểm-tra-sau-release)
- [Troubleshooting](#troubleshooting)
- [Checklist](#checklist)

## Tổng quan

Quy trình release một version mới bao gồm các bước chính:
1. **Chuẩn bị**: Kiểm tra code, tests, documentation
2. **Version bump**: Tăng version number
3. **Documentation update**: Cập nhật tài liệu
4. **Commit & Push**: Commit changes và push lên repository
5. **Publish**: Publish package lên pub.dev
6. **Verification**: Kiểm tra sau khi publish

## Chuẩn bị trước khi release

### 1. Kiểm tra code quality

```bash
# Chạy tests
dart test

# Kiểm tra code formatting
dart format --set-exit-if-changed .

# Chạy static analysis
dart analyze

# Kiểm tra dependencies
dart pub deps
```

### 2. Kiểm tra functionality

```bash
# Test tool locally
dart run bin/component_creator.dart --help

# Test với một component đơn giản
dart run bin/component_creator.dart TestComponent

# Kiểm tra generated files
ls lib/components/ds_test_component/
ls lib/theme/components/ds_test_component/
```

### 3. Review changes

```bash
# Xem changes từ version trước
git log --oneline $(git describe --tags --abbrev=0)..HEAD

# Xem diff của các files chính
git diff HEAD~5 lib/tool/component_creator.dart
git diff HEAD~5 lib/tool/templates.dart
```

### 4. Kiểm tra documentation

- [ ] README.md có được cập nhật với features mới
- [ ] CHANGELOG.md có đầy đủ thông tin về version mới
- [ ] API.md có documentation cho các thay đổi
- [ ] USAGE_GUIDE.md có hướng dẫn sử dụng features mới
- [ ] QUICK_REFERENCE.md có thông tin cập nhật

## Các bước release

### Bước 1: Xác định loại version

Dựa trên [Semantic Versioning](https://semver.org/):

- **MAJOR.MINOR.PATCH**
  - **PATCH** (0.0.x): Bug fixes, không có breaking changes
  - **MINOR** (0.x.0): New features, backward compatible
  - **MAJOR** (x.0.0): Breaking changes

Ví dụ:
- `0.0.5` → `0.0.6`: Bug fix (PATCH)
- `0.0.6` → `0.1.0`: New feature (MINOR)
- `0.1.0` → `1.0.0`: Breaking change (MAJOR)

### Bước 2: Tăng version number

#### Cập nhật pubspec.yaml

```yaml
# Thay đổi version number
version: 0.0.7  # Tăng từ 0.0.6
```

#### Cập nhật CHANGELOG.md

Thêm section mới cho version:

```markdown
## [0.0.7] - 2025-06-20

### Added
- New feature description

### Changed
- Changed feature description

### Fixed
- Bug fix description

### Breaking Changes
- Breaking change description (nếu có)
```

### Bước 3: Cập nhật documentation

#### Cập nhật README.md

```markdown
### Version 0.0.7 (Current)
- 🎯 New feature description
- 🔧 Bug fix description
```

#### Cập nhật các file documentation khác

- **doc/API.md**: Thêm documentation cho API mới
- **doc/USAGE_GUIDE.md**: Thêm hướng dẫn sử dụng features mới
- **doc/QUICK_REFERENCE.md**: Cập nhật quick reference

### Bước 4: Commit changes

```bash
# Stage tất cả changes
git add .

# Commit với message chuẩn
git commit -m "chore: release version 0.0.7 with new features and bug fixes

- Added interactive component variants creation
- Fixed StatefulWidget template bug
- Updated documentation for new features
- Improved user experience with flexible generation options"

# Push lên repository
git push origin master
```

### Bước 5: Tạo Git tag

```bash
# Tạo annotated tag
git tag -a v0.0.7 -m "Release version 0.0.7"

# Push tag lên repository
git push origin v0.0.7
```

### Bước 6: Publish lên pub.dev

#### Kiểm tra trước khi publish

```bash
# Kiểm tra package
dart pub publish --dry-run

# Kiểm tra dependencies
dart pub deps

# Kiểm tra analysis
dart analyze
```

#### Publish package

```bash
# Publish lên pub.dev
dart pub publish
```

**Lưu ý**: Cần có quyền publish và đã verify email trên pub.dev

### Bước 7: Verify release

#### Kiểm tra pub.dev

1. Truy cập https://pub.dev/packages/component_creator
2. Kiểm tra version mới đã xuất hiện
3. Kiểm tra changelog và documentation
4. Test installation:

```bash
# Test global installation
dart pub global activate component_creator

# Verify version
component_creator --version  # nếu có
```

#### Kiểm tra GitHub

1. Kiểm tra tag đã được tạo: https://github.com/your-username/component_creator/tags
2. Kiểm tra release notes (nếu có)
3. Kiểm tra commit history

## Kiểm tra sau release

### 1. Test installation

```bash
# Test từ pub.dev
dart pub global activate component_creator

# Test functionality
component_creator TestComponent
```

### 2. Test với project thực tế

```bash
# Tạo test project
flutter create test_component_project
cd test_component_project

# Test tool
component_creator Button
component_creator "Custom Card"

# Kiểm tra generated files
ls lib/components/
ls lib/theme/components/
```

### 3. Kiểm tra documentation

- [ ] README.md hiển thị đúng trên GitHub
- [ ] CHANGELOG.md có đầy đủ thông tin
- [ ] Documentation links hoạt động
- [ ] Examples chạy được

### 4. Monitor feedback

- Kiểm tra GitHub Issues
- Monitor pub.dev analytics
- Theo dõi community feedback

## Troubleshooting

### Lỗi thường gặp

#### 1. "Publisher unverified uploader"

**Nguyên nhân**: Chưa verify email trên pub.dev

**Giải pháp**:
1. Đăng nhập vào https://pub.dev
2. Verify email address
3. Thử publish lại

#### 2. "Package version already exists"

**Nguyên nhân**: Version đã tồn tại trên pub.dev

**Giải pháp**:
1. Tăng version number
2. Update pubspec.yaml
3. Commit và push changes
4. Publish lại

#### 3. "Analysis failed"

**Nguyên nhân**: Code có lỗi analysis

**Giải pháp**:
```bash
# Fix analysis issues
dart analyze --fatal-infos

# Fix formatting
dart format .

# Fix lints
dart fix --apply
```

#### 4. "Tests failed"

**Nguyên nhân**: Tests không pass

**Giải pháp**:
```bash
# Chạy tests
dart test

# Fix failing tests
# Update test cases nếu cần
```

#### 5. "Documentation issues"

**Nguyên nhân**: Documentation không đầy đủ

**Giải pháp**:
1. Kiểm tra tất cả documentation files
2. Update examples
3. Verify links
4. Test documentation locally

### Rollback procedure

Nếu cần rollback version:

```bash
# Revert to previous version
git checkout v0.0.6

# Update pubspec.yaml
# version: 0.0.6

# Commit revert
git commit -m "revert: rollback to version 0.0.6"

# Push changes
git push origin master

# Delete tag nếu cần
git tag -d v0.0.7
git push origin :refs/tags/v0.0.7
```

## Checklist

### Trước khi release

- [ ] Code đã được test kỹ
- [ ] Tất cả tests pass
- [ ] Code formatting đúng
- [ ] Static analysis pass
- [ ] Documentation đã được cập nhật
- [ ] CHANGELOG.md có đầy đủ thông tin
- [ ] README.md có examples mới
- [ ] API documentation đã được cập nhật

### Trong quá trình release

- [ ] Tăng version number trong pubspec.yaml
- [ ] Cập nhật CHANGELOG.md
- [ ] Cập nhật README.md
- [ ] Cập nhật documentation files
- [ ] Commit changes với message chuẩn
- [ ] Push changes lên repository
- [ ] Tạo Git tag
- [ ] Push tag lên repository
- [ ] Test package với --dry-run
- [ ] Publish lên pub.dev

### Sau khi release

- [ ] Kiểm tra package trên pub.dev
- [ ] Test installation từ pub.dev
- [ ] Test functionality với project thực tế
- [ ] Kiểm tra documentation online
- [ ] Monitor feedback và issues
- [ ] Update release notes trên GitHub (nếu cần)

## Best Practices

### 1. Version Management

- **Luôn sử dụng Semantic Versioning**
- **Tăng version một cách có ý nghĩa**
- **Document breaking changes rõ ràng**
- **Maintain backward compatibility khi có thể**

### 2. Documentation

- **Update documentation trước khi release**
- **Include examples cho features mới**
- **Test documentation locally**
- **Verify all links hoạt động**

### 3. Testing

- **Test thoroughly trước khi release**
- **Test với real-world scenarios**
- **Test installation và uninstallation**
- **Test với different Flutter versions**

### 4. Communication

- **Write clear release notes**
- **Highlight breaking changes**
- **Provide migration guides nếu cần**
- **Respond to community feedback**

### 5. Automation

- **Sử dụng CI/CD nếu có thể**
- **Automate testing process**
- **Automate documentation generation**
- **Automate version bumping**

## Release Schedule

### Regular Releases

- **Patch releases**: Khi có bug fixes
- **Minor releases**: Khi có new features
- **Major releases**: Khi có breaking changes

### Release Frequency

- **Patch**: As needed (bug fixes)
- **Minor**: Every 2-4 weeks (new features)
- **Major**: Every 3-6 months (breaking changes)

### Pre-release Testing

- **Alpha releases**: For testing new features
- **Beta releases**: For community feedback
- **RC releases**: Release candidates

## Tools và Scripts

### Useful Commands

```bash
# Check current version
grep "version:" pubspec.yaml

# List all tags
git tag -l

# Show changes between versions
git log --oneline v0.0.6..v0.0.7

# Check package health
dart pub deps
dart analyze
dart test
```

### Automation Scripts

Có thể tạo scripts để automate release process:

```bash
#!/bin/bash
# release.sh

VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: ./release.sh <version>"
    exit 1
fi

# Update version
sed -i '' "s/version: .*/version: $VERSION/" pubspec.yaml

# Run tests
dart test

# Format code
dart format .

# Analyze code
dart analyze

# Commit changes
git add .
git commit -m "chore: release version $VERSION"

# Create tag
git tag -a v$VERSION -m "Release version $VERSION"

# Push changes
git push origin master
git push origin v$VERSION

# Publish
dart pub publish

echo "Release $VERSION completed!"
```

## Conclusion

Quy trình release cần được thực hiện cẩn thận và có hệ thống. Luôn đảm bảo:

1. **Code quality**: Tests pass, analysis clean
2. **Documentation**: Complete và up-to-date
3. **Communication**: Clear release notes
4. **Testing**: Thorough testing trước và sau release
5. **Monitoring**: Theo dõi feedback và issues

Với quy trình này, việc release sẽ trở nên reliable và professional hơn.

---

*Hướng dẫn này được cập nhật cho Component Creator v0.0.6+* 