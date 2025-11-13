# Prisma Migration Skill

This skill handles Prisma schema changes and database migrations.

## IMPORTANT: Output Language
**All output, migration notes, and communication with the user must be in Japanese (日本語).**
Only technical identifiers, code, and section headers may be in English.

## Prerequisites
- Prisma CLI installed
- Database connection configured in `.env`
- Existing Prisma schema at `src/prisma/schema.prisma`

## Steps

### 1. Review Current Schema
```bash
cat src/prisma/schema.prisma
```
- Understand existing models
- Identify relationships
- Note indexes and constraints

### 2. Make Schema Changes
- Edit `src/prisma/schema.prisma`
- Add/modify models, fields, relations
- Add indexes for query optimization
- Add constraints for data integrity

### 3. Validate Schema
```bash
npx prisma validate
```
- Ensure syntax is correct
- Check for circular dependencies
- Verify relation fields

### 4. Format Schema
```bash
npx prisma format
```
- Apply consistent formatting

### 5. Generate Migration
```bash
npx prisma migrate dev --name descriptive_migration_name --create-only
```
- Creates migration SQL file
- Review generated SQL before applying

### 6. Review Migration SQL
```bash
cat prisma/migrations/TIMESTAMP_descriptive_migration_name/migration.sql
```
- Check for data loss warnings
- Verify indexes are created
- Ensure constraints are correct
- Look for potential performance issues

### 7. Test Migration (Optional)
For critical migrations:
```bash
# Backup production data
# Apply migration to staging first
npx prisma migrate deploy --preview-feature
```

### 8. Apply Migration
```bash
npx prisma migrate dev
```
- Applies migration to development database
- Generates Prisma Client

### 9. Generate Prisma Client
```bash
npx prisma generate
```
- Updates TypeScript types
- Refreshes Prisma Client API

### 10. Verify Migration
```bash
npx prisma studio
```
- Open Prisma Studio
- Verify schema changes
- Check data integrity

### 11. Update Seed Script (if needed)
If models changed significantly:
- Update `prisma/seed.ts`
- Ensure seed data matches new schema

### 12. Run Tests
```bash
npm run test
```
- Verify database queries still work
- Check for broken relations
- Validate data access patterns

## Common Patterns

### Adding a New Model
```prisma
model NewEntity {
  id        String   @id @default(cuid())
  name      String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  // Relations
  organizationId String
  organization   Organization @relation(fields: [organizationId], references: [id], onDelete: Cascade)

  @@index([organizationId])
  @@map("new_entities")
}
```

### Adding a Field to Existing Model
```prisma
model User {
  // ... existing fields

  // New field with default value to avoid breaking existing data
  newField String @default("default_value")
}
```

### Creating a Many-to-Many Relation
```prisma
model User {
  id    String @id @default(cuid())
  roles UserRole[]
}

model Role {
  id    String @id @default(cuid())
  users UserRole[]
}

model UserRole {
  userId String
  user   User   @relation(fields: [userId], references: [id], onDelete: Cascade)

  roleId String
  role   Role   @relation(fields: [roleId], references: [id], onDelete: Cascade)

  assignedAt DateTime @default(now())

  @@id([userId, roleId])
  @@index([userId])
  @@index([roleId])
}
```

## Rollback Strategy

If migration fails:
```bash
# Rollback last migration
npx prisma migrate resolve --rolled-back MIGRATION_NAME

# Reset database (development only!)
npx prisma migrate reset
```

## Production Migration Checklist
- [ ] Migration tested on staging
- [ ] Database backup created
- [ ] Downtime window scheduled (if needed)
- [ ] Migration SQL reviewed by senior developer
- [ ] Rollback plan prepared
- [ ] Monitoring alerts configured

## Documentation
After migration:
- Update `/docs/TECHNICAL_ARCHITECTURE.md` with schema changes
- Document any breaking changes
- Update API documentation if models changed
