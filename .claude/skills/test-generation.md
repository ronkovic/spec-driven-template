# Test Generation Skill

This skill handles creating comprehensive tests for components, services, and API endpoints.

## IMPORTANT: Output Language
**All output, test descriptions, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers may be in English.

## Prerequisites
- Vitest configured
- Testing Library for React components
- Supertest for API testing (optional)
- MSW for API mocking (optional)

## Test Types

### 1. Unit Tests
Test individual functions and components in isolation.

### 2. Integration Tests
Test how multiple units work together.

### 3. E2E Tests
Test complete user workflows (optional for MVP).

## Steps

### 1. Identify What to Test

#### For Services/Business Logic
- Happy path scenarios
- Edge cases
- Error handling
- Validation logic
- Database operations

#### For API Endpoints
- Authentication/authorization
- Input validation
- Success responses
- Error responses
- Database operations

#### For React Components
- Rendering with different props
- User interactions
- State changes
- Error states
- Accessibility

### 2. Create Test File Structure

```
src/
├── services/
│   ├── user.service.ts
│   └── user.service.test.ts
├── app/
│   └── api/
│       └── users/
│           ├── route.ts
│           └── route.test.ts
└── components/
    ├── UserCard.tsx
    └── UserCard.test.tsx
```

### 3. Service Test Template

```typescript
import { describe, it, expect, beforeEach, afterEach, vi } from 'vitest';
import { UserService } from './user.service';
import { prisma } from '@/lib/prisma';

// Mock Prisma
vi.mock('@/lib/prisma', () => ({
  prisma: {
    user: {
      create: vi.fn(),
      findUnique: vi.fn(),
      findMany: vi.fn(),
      update: vi.fn(),
      delete: vi.fn(),
    },
    organizationMembership: {
      findFirst: vi.fn(),
    },
  },
}));

describe('UserService', () => {
  let service: UserService;

  beforeEach(() => {
    service = new UserService();
    vi.clearAllMocks();
  });

  describe('create', () => {
    it('should create a user successfully', async () => {
      const mockUser = {
        id: 'user-1',
        email: 'test@example.com',
        name: 'Test User',
      };

      (prisma.user.create as any).mockResolvedValue(mockUser);

      const result = await service.create({
        email: 'test@example.com',
        name: 'Test User',
      });

      expect(result).toEqual(mockUser);
      expect(prisma.user.create).toHaveBeenCalledWith({
        data: {
          email: 'test@example.com',
          name: 'Test User',
        },
      });
    });

    it('should throw error if email already exists', async () => {
      (prisma.user.create as any).mockRejectedValue(
        new Error('Unique constraint violation')
      );

      await expect(
        service.create({
          email: 'existing@example.com',
          name: 'Test',
        })
      ).rejects.toThrow();
    });
  });

  describe('findById', () => {
    it('should return user if found', async () => {
      const mockUser = { id: 'user-1', email: 'test@example.com' };
      (prisma.user.findUnique as any).mockResolvedValue(mockUser);

      const result = await service.findById('user-1');
      expect(result).toEqual(mockUser);
    });

    it('should throw error if user not found', async () => {
      (prisma.user.findUnique as any).mockResolvedValue(null);

      await expect(service.findById('nonexistent')).rejects.toThrow(
        'User not found'
      );
    });
  });
});
```

### 4. API Route Test Template

```typescript
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { GET, POST } from './route';
import { NextRequest } from 'next/server';
import { getServerSession } from 'next-auth';

vi.mock('next-auth', () => ({
  getServerSession: vi.fn(),
}));

vi.mock('@/services/user.service', () => ({
  UserService: vi.fn().mockImplementation(() => ({
    findMany: vi.fn(),
    create: vi.fn(),
  })),
}));

describe('API: /api/users', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('GET', () => {
    it('should return 401 if not authenticated', async () => {
      (getServerSession as any).mockResolvedValue(null);

      const request = new NextRequest('http://localhost/api/users');
      const response = await GET(request);
      const data = await response.json();

      expect(response.status).toBe(401);
      expect(data.error).toBe('Unauthorized');
    });

    it('should return users for authenticated user', async () => {
      (getServerSession as any).mockResolvedValue({
        user: { id: 'user-1' },
      });

      const mockUsers = [
        { id: 'user-1', email: 'test1@example.com' },
        { id: 'user-2', email: 'test2@example.com' },
      ];

      const { UserService } = await import('@/services/user.service');
      const mockService = new UserService();
      (mockService.findMany as any).mockResolvedValue({
        items: mockUsers,
        pagination: { page: 1, limit: 20, total: 2, totalPages: 1 },
      });

      const request = new NextRequest(
        'http://localhost/api/users?organizationId=org-1'
      );
      const response = await GET(request);
      const data = await response.json();

      expect(response.status).toBe(200);
      expect(data.items).toHaveLength(2);
    });

    it('should validate query parameters', async () => {
      (getServerSession as any).mockResolvedValue({
        user: { id: 'user-1' },
      });

      const request = new NextRequest(
        'http://localhost/api/users?page=invalid'
      );
      const response = await GET(request);
      const data = await response.json();

      expect(response.status).toBe(400);
      expect(data.error).toBe('Validation error');
    });
  });

  describe('POST', () => {
    it('should create user with valid data', async () => {
      (getServerSession as any).mockResolvedValue({
        user: { id: 'admin-1' },
      });

      const mockUser = {
        id: 'user-new',
        email: 'new@example.com',
        name: 'New User',
      };

      const { UserService } = await import('@/services/user.service');
      const mockService = new UserService();
      (mockService.create as any).mockResolvedValue(mockUser);

      const request = new NextRequest('http://localhost/api/users', {
        method: 'POST',
        body: JSON.stringify({
          email: 'new@example.com',
          name: 'New User',
        }),
      });

      const response = await POST(request);
      const data = await response.json();

      expect(response.status).toBe(201);
      expect(data.id).toBe('user-new');
    });

    it('should return 400 with invalid data', async () => {
      (getServerSession as any).mockResolvedValue({
        user: { id: 'admin-1' },
      });

      const request = new NextRequest('http://localhost/api/users', {
        method: 'POST',
        body: JSON.stringify({
          email: 'invalid-email',
        }),
      });

      const response = await POST(request);
      const data = await response.json();

      expect(response.status).toBe(400);
      expect(data.error).toBe('Validation error');
    });
  });
});
```

### 5. React Component Test Template

```typescript
import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { UserCard } from './UserCard';

describe('UserCard', () => {
  const mockUser = {
    id: 'user-1',
    name: 'John Doe',
    email: 'john@example.com',
    role: 'EMPLOYEE',
  };

  it('should render user information', () => {
    render(<UserCard user={mockUser} />);

    expect(screen.getByText('John Doe')).toBeInTheDocument();
    expect(screen.getByText('john@example.com')).toBeInTheDocument();
    expect(screen.getByText('EMPLOYEE')).toBeInTheDocument();
  });

  it('should call onEdit when edit button is clicked', () => {
    const onEdit = vi.fn();
    render(<UserCard user={mockUser} onEdit={onEdit} />);

    const editButton = screen.getByRole('button', { name: /edit/i });
    fireEvent.click(editButton);

    expect(onEdit).toHaveBeenCalledWith(mockUser);
  });

  it('should display loading state', () => {
    render(<UserCard user={mockUser} isLoading={true} />);

    expect(screen.getByTestId('loading-spinner')).toBeInTheDocument();
  });

  it('should handle missing optional fields', () => {
    const userWithoutEmail = { ...mockUser, email: undefined };
    render(<UserCard user={userWithoutEmail} />);

    expect(screen.queryByText('john@example.com')).not.toBeInTheDocument();
    expect(screen.getByText('John Doe')).toBeInTheDocument();
  });

  it('should be accessible', () => {
    const { container } = render(<UserCard user={mockUser} />);

    // Check for proper heading structure
    expect(screen.getByRole('heading', { level: 3 })).toBeInTheDocument();

    // Check for alt text on images (if any)
    // Check for proper button labels
    const editButton = screen.getByRole('button', { name: /edit/i });
    expect(editButton).toHaveAccessibleName();
  });
});
```

### 6. Integration Test Template

```typescript
import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { prisma } from '@/lib/prisma';
import { UserService } from '@/services/user.service';
import { OrganizationService } from '@/services/organization.service';

describe('User-Organization Integration', () => {
  let orgService: OrganizationService;
  let userService: UserService;
  let testOrgId: string;
  let testUserId: string;

  beforeAll(async () => {
    orgService = new OrganizationService();
    userService = new UserService();

    // Create test organization
    const org = await orgService.create({
      name: 'Test Org',
      plan: 'starter',
    });
    testOrgId = org.id;
  });

  afterAll(async () => {
    // Cleanup
    await prisma.user.deleteMany({
      where: { organizationMemberships: { some: { organizationId: testOrgId } } },
    });
    await prisma.organization.delete({ where: { id: testOrgId } });
  });

  it('should create user and add to organization', async () => {
    const user = await userService.create({
      email: 'test@example.com',
      name: 'Test User',
    });

    await orgService.addMember(testOrgId, user.id, 'EMPLOYEE');

    const members = await orgService.getMembers(testOrgId);
    expect(members).toHaveLength(1);
    expect(members[0].userId).toBe(user.id);
  });

  it('should enforce organization user limits', async () => {
    // Test organization limit enforcement
    const org = await prisma.organization.findUnique({
      where: { id: testOrgId },
      include: { billing: true },
    });

    // Try to add users beyond limit
    // Expect error
  });
});
```

### 7. Test Coverage Goals

```typescript
// vitest.config.ts
export default defineConfig({
  test: {
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      lines: 80,
      branches: 75,
      functions: 80,
      statements: 80,
      exclude: [
        'node_modules/',
        'dist/',
        '**/*.test.ts',
        '**/*.config.ts',
        '**/types.ts',
      ],
    },
  },
});
```

### 8. Run Tests

```bash
# Run all tests
npm run test

# Run with coverage
npm run test:coverage

# Run specific test file
npm run test user.service.test.ts

# Run in watch mode
npm run test:watch

# Run integration tests only
npm run test:integration
```

### 9. Test Fixtures

Create test fixtures in `tests/fixtures/`:

```typescript
// tests/fixtures/users.ts
export const mockUsers = {
  admin: {
    id: 'admin-1',
    email: 'admin@example.com',
    name: 'Admin User',
    role: 'ADMIN',
  },
  employee: {
    id: 'employee-1',
    email: 'employee@example.com',
    name: 'Employee User',
    role: 'EMPLOYEE',
  },
};

// tests/fixtures/organizations.ts
export const mockOrganizations = {
  starter: {
    id: 'org-1',
    name: 'Starter Org',
    plan: 'starter',
  },
  enterprise: {
    id: 'org-2',
    name: 'Enterprise Org',
    plan: 'enterprise',
  },
};
```

### 10. Mocking Strategies

#### Mock Prisma
```typescript
vi.mock('@/lib/prisma', () => ({
  prisma: {
    user: {
      create: vi.fn(),
      findUnique: vi.fn(),
      // ... other methods
    },
  },
}));
```

#### Mock External APIs
```typescript
vi.mock('@/lib/stripe', () => ({
  stripe: {
    customers: {
      create: vi.fn().mockResolvedValue({ id: 'cus_123' }),
    },
  },
}));
```

#### Mock Next Auth
```typescript
vi.mock('next-auth', () => ({
  getServerSession: vi.fn(),
}));
```

## Checklist
- [ ] Test file created with proper naming
- [ ] All critical paths tested
- [ ] Edge cases covered
- [ ] Error scenarios tested
- [ ] Mocks properly configured
- [ ] Test data fixtures created
- [ ] Coverage meets minimum threshold (80%)
- [ ] Tests are isolated (no dependencies between tests)
- [ ] Tests are deterministic (no random failures)
- [ ] Clean up resources in afterEach/afterAll
