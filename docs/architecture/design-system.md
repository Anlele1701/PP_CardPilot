# CardPilot Design System

**Live Preview:** Widgetbook Cloud (deploy tự động từ nhánh `develop` qua `.github/workflows/widgetbook-cloud.yml`) — URL cụ thể: **TBD**, cần lấy từ Widgetbook Cloud project settings.
**Package:** `apps/cardpilot-mobile/packages/cardpilot_ui`

> Toàn bộ giá trị dưới đây copy trực tiếp từ code (`lib/src/theme/*.dart`, `lib/src/components/**`) tại thời điểm viết tài liệu (2026-07-22).

---

## Design Tokens

### Colors (`lib/src/theme/app_colors.dart`)

```dart
brandBlue   = 0xFF1D7DFF
brandGreen  = 0xFF4BC879
ink         = 0xFF102033
muted       = 0xFF65758B
surface     = 0xFFFFFFFF
darkSurface = 0xFF0D1522
skyTop      = 0xFFDFF1FF
skyBottom   = 0xFFFFFFFF
```

### Spacing (`lib/src/theme/app_spacing.dart`)

```dart
xs  = 4.0
sm  = 8.0
md  = 16.0
lg  = 24.0
xl  = 32.0
xxl = 48.0
```

### Typography & Theme (`lib/src/theme/app_theme.dart`)

- Material 3 (`useMaterial3: true`), `ColorScheme.fromSeed(seedColor: AppColors.brandBlue, ...)` cho cả light và dark.
- **Light theme**: `scaffoldBackgroundColor: AppColors.surface`; custom `TextTheme`:
  - `headlineLarge`: 34px, weight 800, letterSpacing -0.8, color `ink`
  - `bodyLarge`: 17px, height 1.35, color `muted`
- **Dark theme**: chỉ set `scaffoldBackgroundColor: AppColors.darkSurface` + seeded color scheme — **không override `TextTheme`**, nên headline/body dùng Material default thay vì token đã định nghĩa ở light theme (xem Known Gaps).

---

## Component Inventory

| Component | Props | Widgetbook Preview | Ghi chú |
|-----------|-------|---------------------|---------|
| `AppPrimaryButton` | `label` (String), `onPressed` (VoidCallback?), `isLoading` (bool, default false) | ✅ (Enabled/Disabled/Loading) | Full-width `FilledButton`, nền `brandBlue`, padding dọc `AppSpacing.md`; khi loading hiện `CircularProgressIndicator` 20×20 |
| `OnboardingHeroIllustration` | `illustration` (`OnboardingIllustration`: pilot/cashback/insights) | ✅ (Pilot/Cashback/Insights) | Vector graphics vẽ tay bằng `CustomPainter` (không dùng image asset) — nền trời gradient + hình minh hoạ theo variant |
| `OnboardingPageView` | `controller` (PageController), `slides` (`List<OnboardingSlideData>`), `onPageChanged` | ❌ (chỉ xuất hiện gián tiếp qua `OnboardingMockScreen`) | `PageView.builder`, mỗi trang: illustration (flex 7) + logo mark + title/subtitle (flex 6) |
| `OnboardingPagination` | `currentPage`, `pageCount` (int) | ✅ (Page 1/2/3 of 3) | Dot indicator — dot active là pill 22×8 `brandBlue`, dot inactive 8×8 `brandBlue` 22% opacity, animation 220ms `easeOutCubic` |
| `OnboardingSlideData` | `title`, `subtitle`, `illustration` | N/A (data class, không phải widget) | DTO riêng của UI package — tách biệt khỏi domain entity `OnboardingSlide` của app |

Ngoài bộ trên (tất cả phục vụ riêng cho onboarding + 1 button dùng chung), **chưa có component nào khác** trong `cardpilot_ui` — chưa có card/list/input/badge/chart component nào cho các tính năng Cards/Transactions/Dashboard sắp build.

## Known Gaps

- **Illustration painters dùng màu hex nội tuyến thay vì token**: `_SkyPainter`/`_CardPainter` (bên trong `onboarding_hero_illustrations.dart`) dùng trực tiếp `0xFF0A78FF`/`0xFF1BE0C7`/`0xFF0B5CD1` thay vì tham chiếu `AppColors`. Nên refactor để mọi màu đi qua token, tránh lệch màu khi rebrand.
- **Dark theme thiếu custom `TextTheme`**: `AppTheme.dark` không override `headlineLarge`/`bodyLarge` như `AppTheme.light` — cần bổ sung để trải nghiệm dark mode nhất quán.
- **`OnboardingPageView` chưa có Widgetbook use case riêng** — chỉ được test gián tiếp qua `OnboardingMockScreen` (dùng dữ liệu mock riêng ở `cardpilot_widgetbook/lib/mocks/onboarding_mocks.dart`, trùng lặp nội dung với `OnboardingLocalDataSource` thật).

## File Structure

```
apps/cardpilot-mobile/packages/cardpilot_ui/lib/
├── cardpilot_ui.dart              # barrel export
└── src/
    ├── components/
    │   ├── app_primary_button.dart
    │   └── onboarding/
    │       ├── onboarding_hero_illustrations.dart
    │       ├── onboarding_page_view.dart
    │       ├── onboarding_pagination.dart
    │       └── onboarding_slide_data.dart
    └── theme/
        ├── app_colors.dart
        ├── app_spacing.dart
        └── app_theme.dart
```

---

**Tài liệu liên quan:** [Mobile Architecture](../MOBILE_ARCHITECTURE.md) · [PRD](../PRD.md)
