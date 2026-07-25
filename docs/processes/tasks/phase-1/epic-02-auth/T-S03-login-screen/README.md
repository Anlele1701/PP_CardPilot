# T-S03 — Login Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** [prototype.html#view-s03](../../../../../prototypes/prototype.html#view-s03) — mở file, tự nhảy tới S03 (Login + nút "Dùng thử local")

## Mô tả

**Màn hình Đăng Nhập & Chế Độ Dùng Thử Local (Guest Mode):**
Màn hình này là cánh cửa đầu tiên để người dùng truy cập CardPilot. Người dùng có 2 lựa chọn:
1. Đăng nhập bằng Tài khoản CardPilot (Email + Mật khẩu).
2. Trải nghiệm ngay bằng nút **"Dùng thử" (Skip / Local Guest Mode)** — không ép buộc đăng ký/đăng nhập ban đầu, giúp tối đa hóa tỷ lệ giữ chân (Retention) người dùng thử nghiệm.

## Acceptance Criteria & Edge Cases

- [ ] **Đăng Nhập Thành Công:** Nhập đúng Email và Password → Gọi `POST /api/auth/login`, nhận Access Token (JWT) + Refresh Token. Lưu mã mã hóa vào Flutter `FlutterSecureStorage`, cập nhật App State và điều hướng mượt sang Dashboard (`S06`).
- [ ] **Bảo Mật Tiết Lộ Thông Tin (User Enumeration Protection):** Nếu nhập sai mật khẩu hoặc Email không tồn tại, trả về chung một thông báo lỗi inline: *"Email hoặc mật khẩu không chính xác."* Tuyệt đối không thông báo *"Email này chưa đăng ký"* để tránh bị tấn công dò tìm tài khoản.
- [ ] **Form Validation:** Kiểm tra định dạng Email hợp lệ trên Client (regex). Nếu Email/Password để trống hoặc sai định dạng, nút "Đăng nhập" bị disable.
- [ ] **Chế Độ Local Guest Mode:** Khi người dùng bấm nút **"Dùng thử" (Skip)**:
  * Lưu trạng thái `is_guest_mode = true` vào bộ nhớ local.
  * Chuyển thẳng sang Dashboard (`S06`) với badge "LOCAL GUEST" ở thanh Profile.
  * Không thực hiện bất kỳ lệnh gọi API yêu cầu xác thực Backend nào.
- [ ] **Anti-Double-Click & Loading State:** Khi đang gửi request đăng nhập, hiển thị loading spinner trên nút Đăng nhập và vô hiệu hóa tương tác tránh người dùng bấm nhiều lần sinh ra nhiều request song song.
- [ ] **Chuyển Hướng Màn Hình:** Có link chuyển nhanh sang Màn hình Đăng Ký (`S04`) và Màn hình Quên Mật Khẩu (`S05`).

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.1 FR-AUTH (FR-AUTH-02)](../../../../../SRS.md)
- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)
- [ARCH-MOBILE — Security & Storage](../../../../../MOBILE_ARCHITECTURE.md#app-folder-structure)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S03.1 | `BE` | Login API — POST /api/auth/login (JWT token pair generation) | Backlog | [T-S03.1-be-login-api.md](./T-S03.1-be-login-api.md) |
| T-S03.2 | `MOBILE` | Login screen UI/logic & SecureStorage integration | Backlog | [T-S03.2-mobile-login-screen.md](./T-S03.2-mobile-login-screen.md) |
| T-S03.3 | `QA` | Test matrix: auth failure, guest mode transition, token persistence | Backlog | [T-S03.3-qa-login-tests.md](./T-S03.3-qa-login-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | Senior PO | 2026-07-25 | Senior PO | 2026-07-25 | Senior PO | 2026-07-25 | Đã cập nhật chỉ dẫn PO cho Guest mode & User Enumeration protection |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
