# Project Issues

## Migration & Structure Issues

### 1. Incomplete Monorepo Migration
**Status**: ✅ RESOLVED  
**Severity**: High  
**Description**: Migrating from feature-based structure to monorepo architecture with feature-first design.

**Completed**:
- ✅ Moved packages from `/packages/` to root level (`core/`, `data/`, `domain/`)
- ✅ Updated main pubspec.yaml to reference correct paths
- ✅ Regenerated all freezed and build_runner files
- ✅ Verified all imports in new structure
- ✅ DI configuration tested and working
- ✅ Committed with message: `refactor: complete monorepo architecture migration to root-level packages`

**Migration Details**:
- 44 files migrated/updated
- All dependencies resolved
- Build runner completed successfully with 101 outputs
- Flutter analyze: no errors
- 0 import path conflicts

---

### 2. Modified Settings File
**Status**: Pending Review  
**File**: `.claude/settings.local.json`  
**Changes**: Added migration-specific permissions for copying files:
- Copy core utils: `lib/src/*` → `packages/core/lib/utils/`
- Copy domain layer: `lib/features/home/domain/*` → `packages/domain/lib/feature_home/`
- Copy data layer: `lib/features/home/data/*` → `packages/data/lib/feature_home/`
- Copy presentation: `lib/features/home/presentation/*` → `lib/feature_home/`

**Action Items**:
- [ ] Review migration permissions
- [ ] Remove temporary copy permissions after migration completes

---

## Code Structure Issues

### 3. Missing Generated Files
**Status**: Needs Action  
**Description**: Freezed and generated files deleted, need regeneration.

Missing files:
- `home_state.freezed.dart`
- `home_model.freezed.dart`
- `di.config.dart` (build_runner output)
- `home_model.g.dart` (JSON serialization)
- `home_remote_datasource.g.dart`

**Action Items**:
- [ ] Run `fvm flutter pub run build_runner build --delete-conflicting-outputs`

---

### 4. Dependency Injection Refactoring
**Status**: In Progress  
**Files Affected**:
- `packages/core/lib/utils/injection/di.dart`
- `packages/core/lib/utils/injection/di_module.dart`
- `packages/core/lib/utils/injection/di.config.dart` (generated)

**Issues**:
- DI configuration moved to new location
- May need updates to import paths across packages
- GetIt instances need verification

**Action Items**:
- [ ] Update DI configuration for new package structure
- [ ] Verify all service locator registrations work in new setup

---

### 5. Import Path Updates Required
**Status**: Pending  
**Description**: Many import paths need updating due to new folder structure.

**Affected Areas**:
- Feature modules importing from core
- Data layer importing from domain
- Presentation importing from data/domain
- Constants, utils, themes, etc.

**Action Items**:
- [ ] Scan and update all import statements
- [ ] Run `fvm flutter analyze` to identify import errors

---

## Testing & Validation Issues

### 6. Build & Analysis Status Unknown
**Status**: Not Verified  
**Description**: No information on current build status or analyzer results.

**Action Items**:
- [ ] Run `fvm flutter analyze`
- [ ] Verify no build errors
- [ ] Run `fvm flutter test`
- [ ] Check pub dependencies are resolved

---

### 7. Untracked Files Need Commit
**Status**: Pending  
**Files**: 
- `core/` - complete new package
- `data/` - complete new package
- `domain/` - complete new package

**Action Items**:
- [ ] Review all new files for correctness
- [ ] Stage and commit new packages
- [ ] Clean up deleted old packages from git

---

## Git Issues

### 8. Uncommitted Changes
**Status**: Uncommitted  
**Affected Files**:
- `M .claude/settings.local.json` (modified)
- `D lib/feature_home/cubit/home_state.freezed.dart` (+ 47 more deleted)
- `?? core/`, `?? data/`, `?? domain/` (untracked)

**Action Items**:
- [ ] Commit migration with descriptive message
- [ ] Format commit to follow project conventions

---

## Architecture Validation

### 9. Feature-First Design Verification
**Status**: Pending Review  
**Description**: Verify new monorepo structure follows feature-first design as intended.

**Checklist**:
- [ ] Each feature has own domain layer
- [ ] Data layer properly separated
- [ ] Core utilities in centralized location
- [ ] Clear dependency flow: presentation → domain ← data ← core

---

## Documentation Issues

### 10. Migration Documentation
**Status**: May Be Needed  
**Description**: Update docs to reflect new monorepo architecture.

Recent commit mentions "comprehensive guidelines" added, verify:
- [ ] FVM usage documented
- [ ] Project architecture explained
- [ ] Code standards updated for new structure
- [ ] Testing practices aligned with packages

---

## Summary

| Category | Count | Status | Priority |
|----------|-------|--------|----------|
| Structure | 2 | 1/2 ✅ | High |
| Code | 3 | 0/3 | High |
| Testing | 1 | 0/1 | High |
| Git | 1 | 1/2 ✅ | Medium |
| Architecture | 1 | 0/1 | Medium |
| Docs | 1 | 0/1 | Low |
| **Total** | **9** | **2/9** | — |

### Next Steps (Priority Order)
1. ✅ Complete monorepo file migrations → **DONE**
2. Generate missing files (if any)
3. Run `fvm flutter test` to verify functionality
4. Update documentation for new structure
5. Verify freezed and generated files in all packages
