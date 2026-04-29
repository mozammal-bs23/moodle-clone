# Flutter Analyze Issues - 95 remaining (from 160)

## Progress
- **Started:** 160 issues
- **Current:** 69 issues
- **Fixed:** 91 issues (56.9%)
- **Remaining:** 69 issues (43.1%)

## Recently Fixed
- ✅ Import style (always_use_package_imports) - 30+ issues
- ✅ Dependency sorting in pubspec files - 4 issues  
- ✅ Directive ordering - 3 issues
- ✅ Double to int literals - 13 issues
- ✅ Documentation in constants - 11 issues
- ✅ Omit local variable type - 1 issue
- ✅ Const constructors - 1 issue
- ✅ Deprecated Flutter members - 10 issues (background, onBackground, surfaceVariant, withOpacity)
- ✅ Redundant argument values - 6 issues (width: 1)

## Remaining Issues (69)
- **25** Missing documentation for public members (public_member_api_docs)
- **13** Lines longer than 80 characters
- **5** Unnecessary raw strings
- **5** Parameter ordering (always_put_required_named_parameters_first)
- **4** Constructor ordering (sort_constructors_first)
- **4** Mutable classes with equals/hashCode (avoid_equals_and_hash_code_on_mutable_classes)
- **3** Dependency sorting
- **2** Const constructors
- **1** Each: omit_local_variable_types, directives_ordering, always_use_package_imports

## Notes on Remaining Issues
- **Documentation (25):** Low priority - add doc comments to public members for API documentation
- **Line length (13):** Mostly in entity files and themes - can break long lines or reformat
- **Other style (14):** Parameter ordering, constructor ordering, raw strings - relatively low impact

## Summary by Type

- **Missing documentation**: ~80 issues
- **Import style (`always_use_package_imports`)**: ~30 issues
- **Parameter style (`avoid_final_parameters`)**: ~8 issues
- **Double to int literals**: ~6 issues
- **Sorting issues**: ~15 issues
- **Other lints**: ~15 issues

---

## Issues by File

### core/lib/utils/constants/app_constants.dart (27 issues)

**Lines 69-76, 80-81, 85-86** - Missing documentation for public constants
**Line 98** - Unnecessary double literal (prefer_int_literals)
**Line 101** - Unnecessary double literal (prefer_int_literals)
**Line 104** - Unnecessary double literal (prefer_int_literals)
**Line 107** - Unnecessary double literal (prefer_int_literals)
**Line 110** - Unnecessary double literal (prefer_int_literals)
**Line 113** - Unnecessary double literal (prefer_int_literals)

### core/lib/utils/base/base_event.dart (4 issues)

**Line 8** - Missing documentation for public member
**Line 17** - Constructor should be before other declarations
**Line 18** - Missing documentation for constructor
**Line 20** - Avoid final parameters

### core/lib/utils/base/base_state.dart (4 issues)

**Line 8** - Missing documentation for public member
**Line 15** - Constructor before other declarations
**Line 16** - Missing documentation for constructor
**Line 18** - Avoid final parameters

### data/lib/feature_home/datasources/home_remote_datasource.dart (~15 issues)

- Missing documentation for public members
- Always use package imports
- Avoid final parameters

### data/lib/feature_home/models/home_model.dart (~20 issues)

- Missing documentation for public members
- Avoid equals/hash code on mutable classes
- Constructor ordering

### data/lib/feature_home/repositories/home_repository_impl.dart (~10 issues)

- Missing documentation
- Always use package imports
- Avoid final parameters

### domain/lib/feature_home/entities/home_entity.dart (~40 issues)

- Missing documentation (most of file)
- Avoid equals/hash code on mutable classes
- Constructor ordering
- Omit local variable types
- Constructor parameter documentation

### domain/lib/feature_home/repositories/home_repository.dart (3 issues)

**Line 3** - Always use package imports
**Line 20** - Avoid final parameters

### domain/lib/feature_home/usecases/get_home_data_usecase.dart (5 issues)

**Line 4-5** - Always use package imports
**Line 13** - Missing documentation
**Line 20** - Avoid final parameters
**Line 21** - Unnecessary await in return

### domain/lib/feature_home/usecases/get_home_detail_usecase.dart (5 issues)

**Line 4-5** - Always use package imports
**Line 13** - Missing documentation
**Line 20** - Avoid final parameters
**Line 21** - Unnecessary await in return

### domain/pubspec.yaml (2 issues)

**Line 24, 30** - Dependencies not sorted alphabetically

### lib/home/pages/home_detail_page.dart (3 issues)

**Line 4** - Always use package imports
**Line 5** - Sort directive sections alphabetically
**Line 5** - Always use package imports

### lib/home/pages/home_page.dart (4 issues)

**Line 4** - Always use package imports
**Line 5** - Sort directive sections alphabetically
**Line 5** - Always use package imports
**Line 45** - Use const constructors for performance

### lib/home/widgets/home_content_widget.dart (2 issues)

**Line 6-7** - Always use package imports

### lib/main.dart (2 issues)

**Line 6-7** - Always use package imports

### lib/routes/app_router.dart (4 issues)

**Line 4-7** - Always use package imports (4 violations)

### lib/routes/route_observer.dart (1 issue)

**Line 32** - Line exceeds 80-character limit

### pubspec.yaml (2 issues)

**Line 20, 61** - Dependencies not sorted alphabetically

### test/widget_test.dart (1 issue)

**Line 11** - Sort directive sections alphabetically

---

## Priority Resolution Order

1. **High Priority (blockers):**
   - Fix import statements (always_use_package_imports) - 30 issues
   - Sort pubspec dependencies - 4 issues
   - Sort directives - ~3 issues

2. **Medium Priority (style consistency):**
   - Replace double with int literals - 6 issues
   - Use const constructors - 1 issue
   - Remove unnecessary await - 2 issues
   - Remove final from parameters - 8 issues
   - Sort constructors first - ~3 issues
   - Line length - 1 issue

3. **Low Priority (documentation):**
   - Add missing documentation - ~80 issues
   - Mutable classes equality - 2 issues

