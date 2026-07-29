# Settings Refactoring - TODO

## Steps

- [x] Create plan and get user confirmation
- [ ] **Step 1**: Create `lib/core/providers/theme_mode_provider.dart` - Riverpod provider for theme mode that persists to SharedPreferences
- [ ] **Step 2**: Update `lib/app/app.dart` - Convert to ConsumerWidget, watch theme mode provider
- [ ] **Step 3**: Update `lib/features/dashboard/presentation/pages/profile_view.dart` - Replace expandable "App Settings" content with a navigation tile
- [ ] **Step 4**: Update `lib/features/dashboard/presentation/pages/settings_view.dart` - Wire up dark mode toggle to actually work

