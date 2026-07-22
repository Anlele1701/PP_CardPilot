# Template: architecture/design-system.md (Design System Document)

> File này quy định cấu trúc cho `docs/architecture/design-system.md`.
> Mục tiêu: tài liệu hoá design tokens + component inventory của package UI dùng chung (`cardpilot_ui`). Đây là tài liệu **sống** — mỗi khi thêm component/token mới trong `cardpilot_ui`, cập nhật lại đây trong cùng PR.

---

## Cấu trúc bắt buộc

```markdown
# {Tên dự án} Design System

**Live Preview:** {Widgetbook Cloud URL nếu có, hoặc "—" nếu chưa deploy}

---

## Design Tokens

### Colors
<!-- Copy TRỰC TIẾP giá trị hex từ file theme thật, không tự đặt màu -->
```dart
{tokenName}: {hexValue}
```

### Spacing
```dart
{tokenName}: {value}
```

### Typography
<!-- Nếu chưa có type scale riêng biệt (dùng Material default), ghi rõ điều đó -->

---

## Component Inventory
<!-- Liệt kê MỌI component thật đang tồn tại trong lib/src/components — không thêm component chưa build -->
<!-- Đánh dấu rõ component nào có Widgetbook preview, component nào chưa -->

| Component | Props | Widgetbook Preview | Ghi chú |
|-----------|-------|---------------------|---------|
| ... | ... | ✅ / ❌ | ... |

## Known Gaps
<!-- Bất kỳ inconsistency nào phát hiện được giữa token và component thật (VD: component dùng hex inline thay vì token) -->

## File Structure
```
{package path}/
├── lib/
│   ├── {barrel file}.dart
│   └── src/
│       ├── components/
│       └── theme/
```
```

---

## Quy tắc viết

1. **Mọi giá trị token phải copy trực tiếp từ code** (`packages/cardpilot_ui/lib/src/theme/*.dart`) — không tự sáng tác bảng màu "chuẩn" khác với thực tế.
2. **Component Inventory phải khớp 100% với `lib/src/components/`** — không liệt kê component dự kiến chưa build; những thứ đó thuộc `PRD`/roadmap, không thuộc design system doc.
3. Ghi rõ mục **Known Gaps** khi phát hiện lệch giữa token và implementation thật (VD: 1 component dùng màu hex trực tiếp thay vì `AppColors.xxx`, hoặc dark theme thiếu override cho 1 style) — đây là tài liệu trung thực về hiện trạng, không phải tài liệu "nên là gì".
4. Nếu chưa có Widgetbook Cloud deploy công khai, để "—" thay vì bịa link.
