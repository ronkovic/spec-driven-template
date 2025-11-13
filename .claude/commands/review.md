---
description: Review code changes for quality, security, and best practices
args:
  - name: file-paths
    description: Comma-separated list of files to review (optional, reviews all changes if omitted)
---

Review code changes comprehensively:

## IMPORTANT: Output Language
**All output, review findings, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers in markdown may be in English.

## 1. Code Quality
- Check for code smells and anti-patterns
- Verify proper error handling
- Ensure consistent code style
- Look for duplicate code
- Check for proper TypeScript types (no `any` unless justified)

## 2. Test Coverage
- Verify tests exist for new functionality
- Check test quality (not just coverage numbers)
- Ensure edge cases are tested
- Validate mock usage is appropriate

## 3. Security Best Practices
- Check for SQL injection vulnerabilities
- Verify input validation (Zod schemas)
- Ensure authentication/authorization checks
- Look for exposed secrets or credentials
- Validate CORS and CSP settings
- Check for XSS vulnerabilities

## 4. Performance
- Identify potential N+1 query problems
- Check for unnecessary re-renders (React)
- Verify database queries are optimized
- Look for memory leaks

## 5. Documentation
- Ensure complex logic has comments
- Check if README needs updates
- Verify API documentation is current
- Validate JSDoc comments for public APIs

## 6. Architecture Compliance
- Ensure changes align with project architecture
- Verify proper separation of concerns
- Check if microservice boundaries are respected
- Validate MCP/A2A protocol usage

## 7. Suggestions
- Provide specific, actionable improvements
- Prioritize suggestions (critical, important, nice-to-have)
- Include code examples for suggested changes
