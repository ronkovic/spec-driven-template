---
description: Interactively adjust and refine specification documents
args:
  - name: scope
    description: "Scope of adjustment: 'project' (all project specs) or feature name (e.g., 'multi-tenant-auth')"
---

Interactively adjust and refine specification documents based on review feedback or new insights.

## IMPORTANT: Output Language
**All output, adjustment suggestions, and communication with the user must be in Japanese (日本語).**
Only technical identifiers (variable names, function names, etc.) should remain in English.

## Task

Guide the user through an interactive process to adjust and improve specification documents.

---

## Adjustment Workflow

### Step 1: Current State Analysis

1. **Read the specification documents** in the specified scope
2. **Identify areas needing adjustment**:
   - Incomplete sections
   - Ambiguous descriptions
   - Inconsistencies with other specs
   - Missing technical details
   - Unrealistic goals or timelines
   - Security or performance concerns

3. **Present findings** to the user:
```markdown
## Current State Analysis Results

### Documents Reviewed
- [Document 1]
- [Document 2]

### Areas Recommended for Adjustment
1. **[Area 1]**: [Reason]
   - Current state: [Description]
   - Concerns: [Details]

2. **[Area 2]**: [Reason]
   - Current state: [Description]
   - Concerns: [Details]

### Adjustment Priority
- 🔴 High Priority: [Count] items
- 🟡 Medium Priority: [Count] items
- 🟢 Low Priority: [Count] items
```

### Step 2: Interactive Adjustment

For each area identified, engage in dialogue with the user:

#### 2.1 Present the Issue

```markdown
## Adjustment Item #[N]: [Title]

**Location**: [Document Name] - [Section]
**Priority**: 🔴 High / 🟡 Medium / 🟢 Low
**Category**: [Completeness / Consistency / Quality / Feasibility]

### Current State
[Current content or missing content]

### Issues
[What is the problem and why adjustment is needed]

### Impact
[Impact if this issue is left unaddressed]

### Recommended Adjustment
[Specific adjustment proposal]

### Adjustment Options
A. [Option A] - [Description]
B. [Option B] - [Description]
C. [Option C] - [Description]
D. Enter custom adjustment
E. Skip (address later)
```

#### 2.2 Collect User Input

Ask the user to:
- Choose an option (A/B/C/D/E)
- Provide additional context if needed
- Suggest alternative approaches

#### 2.3 Apply Adjustment

Based on user input:
1. Update the specification document
2. Ensure consistency with related docs
3. Add explanatory comments if needed
4. Record the decision (if significant, create ADR)

#### 2.4 Confirm Changes

Show the user what was changed:
```markdown
## ✅ Adjustment Complete: [Title]

### Changes Made
**Before**:
[Content before change]

**After**:
[Content after change]

### Related Updates
- [Related Document 1]: [Update content]
- [Related Document 2]: [Update content]

### Next Adjustment Item
[N+1]/[Total]: [Next title]
```

### Step 3: Consistency Verification

After all adjustments:

1. **Cross-document consistency check**:
   - Verify that changes are reflected across all related docs
   - Check for new inconsistencies introduced by changes
   - Ensure terminology is consistent

2. **Report inconsistencies** if found:
```markdown
## ⚠️ Consistency Check

### Inconsistencies Found
1. **[Inconsistency 1]**:
   - Document A: [Content A]
   - Document B: [Content B]
   - Recommended action: [Action plan]

2. **[Inconsistency 2]**: ...
```

3. **Resolve inconsistencies** interactively

### Step 4: Quality Re-check

Run quality checks on adjusted documents:

```markdown
## Quality Check Results

| Document | Completeness | Quality | Consistency | Overall |
|----------|-------------|---------|-------------|---------|
| [Doc 1] | [%] | [%] | [%] | [%] |
| [Doc 2] | [%] | [%] | [%] | [%] |

### Improvement Status
- Before adjustment: [Score]%
- After adjustment: [Score]%
- Improvement: +[Difference]%

### Remaining Issues
- [Issue 1]: [Priority]
- [Issue 2]: [Priority]
```

### Step 5: Summary and Next Steps

Provide a comprehensive summary:

```markdown
## 🎉 Adjustment Complete Summary

### Adjustment Statistics
- Adjustment items: [Count]
- Updated documents: [Count]
- ADRs created: [Count]
- Time spent: [Time]

### Major Changes
1. **[Change 1]**: [Description]
2. **[Change 2]**: [Description]
3. **[Change 3]**: [Description]

### Quality Improvement
| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Completeness | [%] | [%] | +[%] |
| Quality | [%] | [%] | +[%] |
| Consistency | [%] | [%] | +[%] |

### Updated Files
- [File 1]
- [File 2]
- [File 3]

### Recommended Next Steps

#### To Execute Immediately
1. [Action 1]
2. [Action 2]

#### When Ready
```bash
# Final spec review
/review-specs [scope]

# Add feature requirements (if project initialization)
/add-requirements [first-feature]

# Start implementation (if feature spec)
/implement [feature-name]
```

### Notes
- [Note 1]
- [Note 2]
```

---

## Adjustment Categories

### 1. Completeness Adjustments

**Missing Information**:
- Add required sections
- Supplement details
- Set concrete numerical targets
- Add examples

**Vague Descriptions**:
- Clarification
- Make concrete
- Quantification

### 2. Consistency Adjustments

**Cross-document Inconsistencies**:
- Unify terminology
- Align numerical values
- Align scope
- Align technology choices

**Internal Inconsistencies**:
- Resolve contradictions
- Remove duplicates

### 3. Quality Adjustments

**Clarity Issues**:
- Improve expression
- Organize structure
- Add diagrams and tables

**Feasibility Issues**:
- Revise unrealistic goals
- Adjust schedule
- Reallocate resources

### 4. Technical Adjustments

**Architecture Improvements**:
- Performance optimization
- Scalability improvement
- Security enhancement

**Implementation Details**:
- Detailed technical specifications
- API design improvements
- Data model optimization

---

## Adjustment Patterns

### Pattern 1: Scope Refinement

**Trigger**: MVP is too large or ambiguous

**Process**:
1. List current MVP features
2. Assign business value and implementation complexity to each feature
3. Create priority matrix
4. Redefine true MVP
5. Move remaining to Phase 2 or later

**Template**:
```markdown
## MVP Scope Adjustment

### Priority Matrix
| Feature | Business Value | Complexity | Priority | Phase |
|---------|---------------|-----------|----------|-------|
| [Feature 1] | High | Low | P0 | MVP |
| [Feature 2] | High | High | P1 | Phase 2 |
| [Feature 3] | Low | Low | P2 | Phase 3 |

### Adjusted MVP
**Included Features**:
- [Feature 1]
- [Feature 4]
- [Feature 5]

**Moved to Phase 2**:
- [Feature 2] - Reason: [High complexity]
- [Feature 6] - Reason: [Dependencies]
```

### Pattern 2: Technical Stack Validation

**Trigger**: Technology choice is unclear or inappropriate

**Process**:
1. Review current technology stack
2. Match against project requirements
3. Evaluate alternatives
4. Consider team skillset
5. Document final decision and reasoning

**Template**:
```markdown
## Technical Stack Validation

### [Technology Component]: [Current Choice]

**Requirements**:
- [Requirement 1]
- [Requirement 2]

**Alternative Evaluation**:
| Option | Pros | Cons | Score |
|--------|------|------|-------|
| [Option A] | [Pros] | [Cons] | [Score] |
| [Option B] | [Pros] | [Cons] | [Score] |

**Decision**: [Selected option]

**Reasoning**:
1. [Reason 1]
2. [Reason 2]

**Trade-offs**:
- Adopted: [Benefits]
- Declined: [Drawbacks]
```

### Pattern 3: Risk Mitigation Planning

**Trigger**: Risks are identified but mitigation is insufficient

**Process**:
1. Re-evaluate impact and probability of each risk
2. Plan countermeasures in three categories
   - Prevention (prevent occurrence)
   - Mitigation (reduce impact)
   - Response (handle when it occurs)
3. Set owner and deadline
4. Define monitoring method

**Template**:
```markdown
## Risk Mitigation Plan: [Risk Name]

**Risk Assessment**:
- Impact: High / Medium / Low
- Probability: High / Medium / Low
- Risk Level: [Impact × Probability]

**Countermeasures**:

### Prevention (Prevent Occurrence)
- [Measure 1] - Owner: [Name] - Deadline: [Date]
- [Measure 2] - Owner: [Name] - Deadline: [Date]

### Mitigation (Reduce Impact)
- [Measure 1] - Owner: [Name] - Deadline: [Date]

### Response (When It Occurs)
1. [Step 1]
2. [Step 2]

**Monitoring**:
- Metric: [Metric]
- Frequency: [Frequency]
- Owner: [Name]
```

### Pattern 4: Timeline Optimization

**Trigger**: Schedule is unrealistic

**Process**:
1. Analyze current schedule
2. Visualize dependencies
3. Identify critical path
4. Find parallelizable work
5. Place buffers appropriately
6. Propose optimized schedule

**Template**:
```markdown
## Schedule Optimization

### Current Issues
- [Issue 1]: [Details]
- [Issue 2]: [Details]

### Dependency Analysis
```
[Task A] → [Task B] → [Task E]
           ↘ [Task C] ↗
[Task D] ────────────↗
```

### Critical Path
[Task A] → [Task B] → [Task E]
Duration: [X] days

### Optimization Proposal
**Parallelization**:
- Execute [Task C] and [Task D] in parallel
- Savings: [Y] days

**Add Resources**:
- Add team member to [Task E]
- Savings: [Z] days

**Scope Adjustment**:
- Move [Task F] to Phase 2
- Savings: [W] days

### Optimized Schedule
- Original: [X] weeks
- Optimized: [Y] weeks
- Reduction: [Z] weeks
```

---

## Interactive Adjustment Modes

### Mode 1: Guided Adjustment
- Claude Code presents issues
- User selects from options
- Progress adjustments step by step

### Mode 2: Free-form Adjustment
- User specifies areas to adjust
- Claude Code adjusts while asking questions
- Flexible approach

### Mode 3: Bulk Adjustment
- Present multiple issues at once
- User decides policy in bulk
- Claude Code applies in bulk

---

## Notes

- **Save frequently**: Save changes incrementally during adjustment
- **Create ADRs**: Record important decisions as ADRs
- **Maintain history**: Record change history in documents
- **Engage in dialogue**: Proceed while confirming user intent
- **Be flexible**: Flexibly respond to user requests
- **Validate continuously**: Continuously verify impact of adjustments

---

## Example Usage

### Adjust project specifications
```bash
/adjust-specs project
```

### Adjust feature specifications
```bash
/adjust-specs multi-tenant-auth
```

---

## Expected Outcome

After adjustment:
- [ ] All adjustment items addressed
- [ ] Cross-document consistency ensured
- [ ] Quality score improved
- [ ] Ready to start implementation
- [ ] Changes properly documented

---

## Next Steps After Adjustment

```bash
# Final review after adjustment
/review-specs [scope]

# If project specs
/add-requirements [first-feature]

# If feature specs
/spec-check [feature-name]
```
