# Changelog

All notable changes to the Spec-Driven Development Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Template health monitoring dashboard
- Community-contributed templates
- Multi-language support expansion
- Additional MCP integrations
- Enhanced testing frameworks

## [1.1.0] - 2025-11-14

### Added

#### Phase 1: Core Maintenance System
- **Template Maintenance System**: Comprehensive maintenance tools for keeping the template up-to-date
  - `/check-template-health` command: Health check and scoring system for template quality (0-100 scale)
  - `/template-update-scan` command: Automated scanning for ecosystem changes and update requirements
  - `/merge-template-update` command: Safe cleanup and merge preparation for template updates
- **Configuration Management**:
  - `.template-config.json`: Central configuration file with version tracking and metadata
  - `.template-ignore`: Patterns for project-specific files to exclude during template updates
- **Documentation**:
  - `docs/MAINTENANCE.md`: Complete guide for template maintenance and update processes (550+ lines)
  - `CHANGELOG.md`: Version history and change tracking
- **Version Tracking**: Comprehensive update history in `.template-config.json`

#### Phase 2/3: Automation Tools
- **GitHub Actions**: Automated health monitoring (template repository only)
  - `.github/workflows/template-health-check.yml`: Monthly automated health checks
  - Repository detection: Automatically skips on projects created from template
  - Structure validation, documentation quality checks, version consistency
  - Auto-creates issues for critical failures
- **Agents**: Specialized automation agents
  - `template-health-agent.md` (Explore): Comprehensive health analysis with 5-category scoring
  - `template-updater-agent.md` (general-purpose): Automated problem fixing with rollback support
- **Skills**: Reusable maintenance skills
  - `dependency-updater.md`: Safe npm dependency management with phased updates

### Changed
- Updated `.gitignore` with additional patterns for local files and verification documents
- Enhanced `README.md` with maintenance information section and links to new documentation
- Updated `TEMPLATE_CHECKLIST.md` to include maintenance system components
- Updated `.template-ignore` to preserve GitHub Actions workflow
- Enhanced `docs/MAINTENANCE.md` with automation tools section

### Improved
- Template now has self-updating capabilities with automated health monitoring
- Better tracking of compatibility and dependencies
- Clear guidelines for version management and releases
- Automated detection of ecosystem changes (Claude Code, Node.js, TypeScript, frameworks)
- Safe update workflow with dry-run mode and automatic rollback

### Technical Details
- **Files**: 45 → 56 (+11 files)
- **Slash Commands**: 12 → 15 (+3 commands)
- **Agents**: 0 → 2 (template-health, template-updater)
- **Skills**: 3 → 4 (+dependency-updater)
- **GitHub Actions**: 0 → 1 (template-health-check)
- Added automated quality scoring (0-100 scale, 5 categories)
- Introduced branch strategy for template updates (`template-update/*`)
- Repository detection prevents Actions from running on derived projects

## [1.0.0] - 2025-11-13

### Added
- **Initial Release**: Complete Spec-Driven Development Template for Claude Code
- **Slash Commands** (12 total):
  - Project initialization: `/init-project`
  - Specification management: `/add-requirements`, `/add-technical`, `/add-implementation`
  - Quality assurance: `/spec-check`, `/check-implementation`, `/review`
  - Development: `/implement`, `/update-specs`
  - Review workflow: `/review-specs`, `/adjust-specs`
  - Git integration: `/commit-prep`
- **Templates** (8 total):
  - **Project-level** (5): Overview, Technical Architecture, Development Standards, Phase Plan, README
  - **Feature-level** (3): Requirements, Technical Specification, Implementation Guide
- **Scripts**:
  - `init.sh`: Unix/Mac project initialization script
  - `init.ps1`: Windows PowerShell initialization script
- **Examples** (4 total):
  - `sample-requirements.md`: Complete requirements specification example
  - `sample-technical.md`: Technical specification with AWS Cognito integration
  - `sample-implementation.md`: 5-phase implementation guide example
  - `sample-workflow.md`: End-to-end workflow walkthrough
- **Documentation**:
  - `README.md`: Comprehensive template overview and quick start
  - `WORKFLOW_GUIDE.md`: Detailed 11-step development workflow
  - `WORKFLOW_STEPS_DETAIL.md`: Step-by-step practical examples
  - `SPEC_TEMPLATES_GUIDE.md`: Template usage and customization guide
  - `MCP_SETUP.md`: MCP server setup instructions
  - `NAMING_CONVENTIONS.md`: File and directory naming guidelines
  - `TEMPLATE_CHECKLIST.md`: Setup verification checklist
  - `CONTRIBUTING.md`: Contribution guidelines
- **Configuration**:
  - `.gitignore`: Comprehensive ignore patterns
  - `.env.example`: Environment variable template
  - `.mcp.json.example`: MCP configuration template
- **License**: MIT License

### Features
- Complete spec-driven development workflow automation
- Template-based document generation
- Japanese and English bilingual support
- Quality gates integration (testing, linting, type checking)
- Git workflow optimization
- MCP (Model Context Protocol) integration

### Workflow
11-step development process:
1. Project initialization
2. Specification review and adjustment
3. Feature requirements definition
4. Requirements validation
5. Technical specification creation
6. Implementation guide creation
7. Implementation execution
8. Implementation verification
9. Specification synchronization
10. Code review
11. Commit preparation

### Template Structure
```
spec-driven-template/
├── .claude/
│   ├── commands/           # 12 slash commands
│   └── skills/            # 3 reusable skills
├── specs/
│   ├── templates/         # 8 specification templates
│   ├── requirements/      # Feature requirements (empty)
│   ├── technical/         # Technical specs (empty)
│   ├── implementation/    # Implementation guides (empty)
│   └── decisions/         # ADRs (empty)
├── scripts/               # Initialization scripts
├── examples/              # 4 complete examples
├── docs/                  # Comprehensive documentation
└── [configuration files]
```

### Design Principles
- **Spec-first**: Documentation before implementation
- **Template-driven**: Consistent structure across projects
- **Quality-focused**: Built-in quality gates and validation
- **Automation-first**: Minimize manual work through slash commands
- **Flexibility**: Adaptable to various project types and scales

### Target Users
- Solo developers using Claude Code
- Small to medium development teams
- Projects requiring clear documentation and spec-driven approach
- Teams transitioning to AI-assisted development

---

## Version History Summary

| Version | Date | Type | Key Changes |
|---------|------|------|-------------|
| 1.1.0 | 2025-11-14 | Minor | Template maintenance system |
| 1.0.0 | 2025-11-13 | Major | Initial release |

## Migration Guides

### From 1.0.0 to 1.1.0

**No migration required** - This is a non-breaking update that adds maintenance capabilities.

**Recommended actions for existing projects:**
1. Pull the latest template updates
2. Copy new maintenance commands to your `.claude/commands/` directory:
   - `check-template-health.md`
   - `template-update-scan.md`
   - `merge-template-update.md`
3. Add configuration files:
   - `.template-config.json`
   - `.template-ignore`
4. Review `MAINTENANCE.md` for ongoing maintenance guidelines

**Optional enhancements:**
- Set up monthly health checks using `/check-template-health`
- Review and customize `.template-ignore` for your project needs

## Support

- **Documentation**: https://github.com/ronkovic/spec-driven-template#readme
- **Issues**: https://github.com/ronkovic/spec-driven-template/issues
- **Discussions**: https://github.com/ronkovic/spec-driven-template/discussions

---

**Maintained by**: [@ronkovic](https://github.com/ronkovic)
**License**: MIT
**Repository**: https://github.com/ronkovic/spec-driven-template
