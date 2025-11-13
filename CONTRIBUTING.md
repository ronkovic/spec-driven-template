# Contributing to Spec-Driven Development Template

Thank you for your interest in contributing to the Spec-Driven Development Template! This document provides guidelines for contributing to this project.

## 🎯 Ways to Contribute

- **Bug Reports**: Report issues you encounter
- **Feature Requests**: Suggest new features or improvements
- **Documentation**: Improve or translate documentation
- **Code**: Submit fixes or new features
- **Templates**: Enhance or add new templates
- **Examples**: Add more sample workflows

## 🚀 Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub, then:
git clone https://github.com/YOUR_USERNAME/spec-driven-template.git
cd spec-driven-template
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 3. Make Your Changes

- Follow existing code style and conventions
- Update documentation if needed
- Add examples if adding new features

### 4. Test Your Changes

- Verify all slash commands work
- Test templates with `/init-project`
- Check that workflow still functions end-to-end

### 5. Commit

Use conventional commits format:

```bash
git commit -m "feat: add new feature"
git commit -m "fix: resolve issue"
git commit -m "docs: update README"
```

**Commit Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Test additions or changes
- `chore`: Maintenance tasks

### 6. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

## 📋 Pull Request Guidelines

### PR Checklist

- [ ] Clear title describing the change
- [ ] Description explains what and why
- [ ] Related issues are linked
- [ ] Documentation is updated
- [ ] Changes follow existing patterns
- [ ] No breaking changes (or clearly documented)

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Template enhancement

## Motivation
Why is this change needed?

## Changes Made
- Change 1
- Change 2

## Testing Done
How was this tested?

## Related Issues
Fixes #123
```

## 🎨 Style Guidelines

### Documentation

- Write in clear, simple language
- Use examples where possible
- Keep Japanese and English documentation in sync
- Follow existing document structure

### Templates

- Use consistent formatting
- Include placeholders for user input
- Provide inline examples
- Document all required sections

### Code (Scripts, Examples)

- Use TypeScript for code examples
- Include comments for complex logic
- Follow existing naming conventions
- Add error handling

## 📝 Template Contribution Guidelines

### Adding New Templates

1. Place template in appropriate directory:
   - Project-level: `specs/templates/project_*.template.md`
   - Feature-level: `specs/templates/feature_*.template.md`

2. Follow naming convention:
   - Use snake_case
   - Use descriptive names
   - Include `.template.md` extension

3. Template structure:
   - Include document metadata section
   - Use consistent section headers
   - Provide placeholder syntax: `[PLACEHOLDER]` or `{{variable}}`
   - Include examples and instructions

4. Update documentation:
   - Add to SPEC_TEMPLATES_GUIDE.md
   - Update TEMPLATE_CHECKLIST.md
   - Reference in relevant commands

### Enhancing Existing Templates

- Maintain backward compatibility
- Document breaking changes
- Update examples
- Test with existing workflows

## 🤖 Slash Command Guidelines

### Adding New Commands

1. Create command file: `.claude/commands/your-command.md`

2. Command structure:
```markdown
---
description: Brief description
args:
  - name: arg-name
    description: Argument description
---

Command instructions here...

## IMPORTANT: Output Language
**All output must be in Japanese (日本語).**
...
```

3. Testing:
   - Test command in Claude Code
   - Verify it works with workflow
   - Check error handling

4. Documentation:
   - Add to WORKFLOW_GUIDE.md
   - Include usage examples
   - Document expected output

## 🌐 Internationalization

- Primary language: Japanese (日本語)
- Secondary language: English
- Keep both up-to-date
- Use clear, simple language

## 🐛 Bug Reports

### Good Bug Report Includes:

- **Description**: Clear description of the issue
- **Steps to Reproduce**: Exact steps to reproduce
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Environment**: Claude Code version, OS, etc.
- **Screenshots**: If applicable

### Bug Report Template

```markdown
## Description
Brief description of the bug

## Steps to Reproduce
1. Step 1
2. Step 2
3. Step 3

## Expected Behavior
What should happen

## Actual Behavior
What actually happens

## Environment
- Claude Code version:
- OS:
- Template version:

## Additional Context
Any other relevant information
```

## 💡 Feature Requests

### Good Feature Request Includes:

- **Problem**: What problem does this solve?
- **Solution**: Proposed solution
- **Alternatives**: Other options considered
- **Use Cases**: When would this be used?

## 📞 Communication

- Be respectful and constructive
- Stay on topic
- Provide context and examples
- Ask questions if unclear

## 🔒 Security

- Report security issues privately
- Do not open public issues for vulnerabilities
- Contact maintainers directly

## ⚖️ License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🙏 Thank You!

Your contributions help make this template better for everyone. Thank you for taking the time to contribute!

---

**Questions?** Feel free to open a discussion or contact the maintainers.
