# Template: tasks.md + tasks/ (Task & Subtask Backlog)

> File này quy định cấu trúc cho `docs/processes/tasks.md` (index) + `docs/processes/tasks/phase-{N}/epic-{NN}-{slug}/T-{ID}-{slug}/` (1 folder/task, chứa task + toàn bộ subtask).
> Mục tiêu: backlog xuyên phase, mỗi task có **mô tả cụ thể + acceptance criteria kiểm tra được + ref docs bấm được + (với task màn hình) link tới prototype**, module (BE/MOBILE/UI/AI/DEVOPS/DATA/QA) rõ ràng, và audit trail.

---

## 0. Nguyên tắc chia Task/Subtask (đọc trước khi điền bất cứ gì)

> Đây là thay đổi quan trọng nhất so với version trước của template này — sai ở đây thì toàn bộ backlog phải viết lại.

### 0.1 Với Epic có màn hình (user-facing): 1 Task = 1 Màn hình

Nếu Epic sinh ra 1 hoặc nhiều màn hình mobile (VD: Auth → Login/Register/Forgot Password, Card Management → Add/Edit Card, Card List), thì **đơn vị Task là màn hình đó**, không phải 1 API/1 lớp kỹ thuật riêng lẻ. Lý do: màn hình là đơn vị giá trị mà PM/stakeholder nhìn thấy và nghiệm thu được; 1 API riêng lẻ (VD "Register API") không tự đứng được — nó chỉ có ý nghĩa khi phục vụ 1 màn hình cụ thể.

- Task = `T-S{NN}` (theo đúng ID màn hình đã định nghĩa ở `deployment-phase-N.md` mục 2 — S01, S02, ...).
- **Subtask** = phần việc theo từng module CẦN để hoàn thiện màn hình đó: thường có `BE` (API/logic backend riêng cho màn hình này), `MOBILE` (build màn hình Flutter), `UI` (component dùng chung nếu màn hình cần component mới), `AI` (nếu màn hình cần 1 pipeline AI riêng), `QA` (test case cho màn hình).
- Việc thu thập dữ liệu (`DATA`) hiếm khi là subtask của 1 màn hình — thường là task độc lập (xem 0.2) vì 1 bộ data (VD: seed `banks`/`credit_cards`) phục vụ nhiều màn hình.

### 0.2 Việc dùng chung nhiều màn hình → Task độc lập (Foundational), KHÔNG lặp lại thành subtask ở mỗi màn hình

Có những phần việc **không thuộc về riêng 1 màn hình** — nó là nền tảng mà nhiều màn hình/nhiều Epic cùng dùng. VD: `Auth Guard + RBAC` được dùng bởi gần như mọi API; `core/network — API client` được mọi màn hình dùng để gọi API; quyết định chọn auth provider ảnh hưởng cả Epic Auth.

- Những việc này **giữ nguyên là 1 Task độc lập** (không nested làm subtask của bất kỳ màn hình nào), đặt trong Epic phù hợp nhất về mặt nghiệp vụ.
- Màn hình nào cần nó thì khai báo **Depends On (Task)** trỏ tới Task đó — KHÔNG copy/duplicate lại nội dung thành subtask riêng ở từng màn hình (duplicate = khi 1 API đổi, phải sửa N chỗ, sai lệch dần).
- Quy tắc nhận diện: nếu phần việc được ≥ 2 Task/màn hình khác nhau phụ thuộc vào → **Foundational, tách task riêng**. Nếu chỉ 1 màn hình duy nhất dùng → **Subtask của màn hình đó**.

### 0.3 Epic không có màn hình (Admin-only / Infra / Data)

Epic không sinh ra màn hình mobile nào (VD: CI/CD, hoặc nghiệp vụ Admin chưa có UI vì dự án chưa có module `FE`) thì Task vẫn là **1 đơn vị năng lực (capability)** như trước — không ép thành "màn hình". Ghi rõ trong task "Không có màn hình — lý do" (VD: "Admin API, chưa có Admin UI trong dự án").

### 0.4 Gap phát hiện khi mapping Task ↔ Screen

Nếu 1 API/logic đã có trong `ARCH-API`/Task Breakdown gốc nhưng KHÔNG có màn hình nào trong `deployment-phase-N.md` mục 2 tiêu thụ nó, **ghi rõ gap** (không âm thầm bỏ qua, không ép gán vào 1 màn hình không liên quan). Tương tự nếu 1 màn hình cần 1 API mà task breakdown gốc chưa từng liệt kê (thường do người viết đầu tiên bỏ sót) — bổ sung task/subtask mới và ghi chú rõ đây là bổ sung, kèm nguồn (VD: endpoint đã có trong `ARCH-API` bảng liệt kê nhưng chưa lên Task Breakdown).

---

## 1. Module Legend

| Mã Module | Tên đầy đủ | Phạm vi (thư mục / app thật) | Git commit scope |
|-----------|-----------|-------------------------------|-------------------|
| `BE` | Backend | {đường dẫn app backend thật} | `{scope}` |
| `MOBILE` | Mobile App | {đường dẫn app mobile thật} | `{scope}` |
| `UI` | Shared UI / Design System | {đường dẫn package UI dùng chung, nếu có} | `{scope}` |
| `AI` | AI/ML Pipeline | Cross-cutting — nằm trong module nào build thật (VD: trong BE) | `{scope}` |
| `DEVOPS` | DevOps / Infra / CI-CD | `.github/workflows/`, `Dockerfile`, `compose.yaml` | `{scope}` |
| `DATA` | Data Collection / Seeding | Seed script, thu thập dữ liệu thủ công (không phải code feature) | `{scope}` |
| `QA` | Quality Assurance / Testing | Test suite của mọi module | `{scope}` |

> Mã module KHÔNG chứa dấu gạch ngang (dùng `UI` chứ không phải `UI-DS`) — vì ID có format `T-{MODULE}-{NNN}`.
> Nếu dự án có thêm web frontend/admin panel riêng (`FE`), thêm hàng — nhưng chỉ khi app đó **thực sự tồn tại** trong repo.

## 2. Quy Ước ID & Dependency

### 2.1 Task ID

- Task = màn hình: `T-S{NN}` — giữ đúng số màn hình đã đánh trong `deployment-phase-N.md` (S01, S02, ...), KHÔNG đánh số lại.
- Task = capability độc lập (foundational hoặc admin-only): `T-{MODULE}-{NNN}` — global theo module, không reset theo phase/epic.
- Subtask (thuộc về đúng 1 task cha, dù task cha là `T-S{NN}` hay `T-{MODULE}-{NNN}`): `{ID cha}.{n}` — VD `T-S03.1`, `T-BE-019.1`. Module của subtask ghi ở cột riêng, có thể khác module gợi ý trong ID cha (VD `T-S03.3` có thể là `QA`).

### 2.2 Phase, Depends On (Task), Depends On (Phase Gate)

- `Phase`: nhãn kế hoạch (task nhắm launch phase nào) — KHÔNG phải cơ chế phụ thuộc.
- `Depends On (Task)`: phụ thuộc kỹ thuật cụ thể — ID toàn cục, xuyên phase/epic/module thoải mái. Đây là cách 1 Task-màn-hình khai báo nó cần Task foundational nào (xem mục 0.2).
- `Depends On (Phase Gate)`: chỉ dùng khi blocker là quyết định release cấp phase (không phải 1 task cụ thể). Mặc định `—`.
- Status suy ra tự động: `Ready` nếu không có `Depends On (Task)`, ngược lại `Backlog`.

## 3. Acceptance Criteria (BẮT BUỘC — mục mới quan trọng nhất)

Mỗi Task (không phải subtask) PHẢI có mục Acceptance Criteria dạng checklist, viết theo góc nhìn **kiểm tra được** (ai đó có thể tick "done" hay "chưa done" mà không cần đoán):

- Dùng dạng "Given/When/Then" ngắn gọn hoặc checklist hành vi cụ thể — KHÔNG viết tiêu chí mơ hồ kiểu "hoạt động tốt", "UI đẹp".
- Với Task = màn hình: tiêu chí phải cover — (a) các trạng thái UI chính (empty/loading/error/success), (b) validate input nào, (c) điều hướng đi đâu sau khi thành công, (d) field/response nào hiển thị (trỏ ngược `ARCH-API`).
- Với Task = capability backend: tiêu chí phải cover — input hợp lệ/không hợp lệ trả gì, status code, side-effect ghi vào bảng nào.
- Nếu 1 tiêu chí phụ thuộc quyết định chưa chốt (VD: chưa chọn auth provider), ghi rõ "TBD — chờ quyết định T-XXX" thay vì bịa ra tiêu chí.

**Sai**: `- [ ] Người dùng đăng nhập được`
**Đúng**:
```
- [ ] Nhập đúng email/password đã đăng ký → điều hướng sang Dashboard (S06), token lưu vào secure storage
- [ ] Nhập sai password → hiển thị inline error dưới field password, KHÔNG điều hướng
- [ ] Bấm "Dùng thử" (Skip) → vào thẳng Dashboard ở local-only mode, không gọi API
- [ ] Trường email/password để trống → nút Login bị disable
```

## 4. Ref Docs — PHẢI bấm được

Ref Docs không còn là text tự do (`SRS FR-AUTH-01`) — phải là **markdown link** tới file thật trong repo:

- Luôn link tới FILE (relative path đúng theo vị trí file task, tính từ `docs/processes/tasks/phase-{N}/epic-{NN}-{slug}/T-{ID}-{slug}/README.md`).
- Thêm `#anchor` khi heading đích **không chứa** `(`, `)`, `/`, `&` (chỉ chữ/số/khoảng trắng/dấu chấm số thứ tự) — anchor tính bằng: lowercase, bỏ dấu chấm, khoảng trắng → gạch ngang. VD heading `### 2.2 Table Definitions` → `#22-table-definitions`.
- Khi heading đích có ký tự đặc biệt (dấu ngoặc, dấu `/`, `&`) → **không đoán anchor** (dễ trỏ sai và lỗi âm thầm — không báo lỗi, chỉ scroll về đầu file), chỉ link tới file, giữ tên section trong text link để người đọc Ctrl+F.
- Format: `[SRS FR-AUTH-01](../../../../../SRS.md#31-user-management--auth-module-fr-auth)` hoặc (không có anchor an toàn) `[ARCH-API — POST /api/auth/login (Planned)](../../../../../architecture/api.md)`.

## 5. Mobile Screen Task — PHẢI ref được tới Prototype

Với Task = màn hình, PHẢI có link trực tiếp tới prototype tương tác, không chỉ mô tả suông:

```
**Prototype:** [prototype.html#view-s03](../../../../../prototypes/prototype.html#view-s03) (mở file, tab sẽ tự nhảy tới màn hình S03 — xem `prototypes/prototype.html` đã hỗ trợ đọc `location.hash` khi load)
```

Nếu dự án chưa có prototype cho 1 màn hình mới (chưa từng build), ghi rõ `**Prototype:** — (chưa có, cần Design bổ sung trước khi build)` thay vì bỏ trống lặng lẽ.

## 6. Physical Layout — 1 Folder / Task

```
docs/processes/tasks/
  phase-{N}/
    epic-{NN}-{epic-slug}/
      T-S{NN}-{screen-slug}/              (hoặc T-{MODULE}-{NNN}-{slug}/ nếu không phải màn hình)
        README.md                          (task: mô tả, acceptance criteria, dependencies, ref docs, prototype, audit trail của task cha)
        T-S{NN}.1-{module}-{slug}.md        (1 file / subtask)
        T-S{NN}.2-{module}-{slug}.md
        ...
```

- `README.md` của task **không lặp lại** nội dung subtask — chỉ liệt kê bảng subtask (ID | Module | Tên | Status | link file) rồi link sang từng file.
- Mỗi file subtask có Audit Trail riêng (giống hệt cấu trúc audit của task, thu nhỏ).
- `docs/processes/tasks.md` (root) là **index toàn cục**: Module Legend, Quy ước ID, Dependency Graph theo Epic, Module × Epic Matrix, và bảng mỗi Epic chỉ gồm ID + Task + Module + Status + link tới `README.md` của folder task đó.

### Cấu trúc `README.md` của 1 Task

```markdown
# T-{ID} — {Tên task (tên màn hình nếu là screen task)}

**Module (chủ đạo):** `{MOD}` — xem subtask cho breakdown theo module
**Phase:** {N}
**Epic:** Epic {N} — {Tên Epic}
**Status:** {Backlog | Ready | In Progress | In Review | Blocked | Done}
**Prototype:** {link #view-sNN hoặc "— (chưa có)"}  <!-- chỉ nếu Task = màn hình -->

## Mô tả
<!-- input → xử lý → output. Với screen: mô tả user thấy/làm gì, luồng chính + luồng lỗi -->

## Acceptance Criteria
- [ ] ...

## Dependencies
- **Depends On (Task):** {T-XXX, ... hoặc —} — bao gồm mọi Task foundational cần (xem mục 0.2)
- **Depends On (Phase Gate):** {Phase N released hoặc —}

## Ref Docs
- [{Tên doc + section}]({relative path}{#anchor nếu an toàn})

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-{ID}.1 | `{MOD}` | {Tên} | {Status} | [T-{ID}.1-....md](./T-{ID}.1-....md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| {Status} | {Tên/TBD} | {YYYY-MM-DD} | — | — | — | — | ... |
```

### Cấu trúc file subtask (`T-{ID}.{n}-{module}-{slug}.md`)

```markdown
# T-{ID}.{n} — {Tên subtask}

**Parent:** [T-{ID}](./README.md)
**Module:** `{MOD}`
**Status:** {Backlog | Ready | ...}

## Mô tả
<!-- riêng phần việc của module này để hoàn thiện task cha -->

## Ref Docs
- [...](...)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| {Status} | TBD | {YYYY-MM-DD} | — | — | — | — | ... |
```

---

## Quy tắc viết — Tổng hợp PHẢI có

1. **Task = màn hình** cho Epic user-facing (mục 0.1); **Task = capability** cho Epic không màn hình (mục 0.3).
2. **Việc dùng chung ≥ 2 Task → tách Task foundational độc lập**, không duplicate thành subtask nhiều nơi (mục 0.2).
3. **Acceptance Criteria bắt buộc**, kiểm tra được, không mơ hồ (mục 3).
4. **Ref Docs là markdown link thật**, có anchor khi an toàn, không đoán anchor khi heading có ký tự đặc biệt (mục 4).
5. **Task màn hình phải link Prototype** cụ thể tới đúng view, hoặc ghi rõ "chưa có" (mục 5).
6. **1 Folder / Task**, subtask là file riêng trong folder đó, `tasks.md` chỉ là index (mục 6).
7. **Module** — mọi task/subtask gắn đúng 1 mã module; nếu 1 phần việc thật sự cần nhiều module cùng lúc, đó là dấu hiệu cần tách thành nhiều subtask, không gộp 2 module vào 1 dòng.
8. **Audit Trail bắt buộc** mỗi task/subtask — `Created Date` = ngày viết backlog, `Created By`/`Reviewed By` = TBD nếu chưa gán, KHÔNG bịa tên người.
9. **Ghi chú Gap** khi mapping Task ↔ Screen phát hiện thiếu (mục 0.4) — không âm thầm bỏ qua, không ép gán sai.
10. **Ghi chú trong Audit Trail nên trỏ PR/commit** khi có — commit scope khớp `Module` (xem `GIT_COMMIT_CONVENTIONS.md`), subject chứa Task ID.

### Ví dụ Sai/Đúng — Task = màn hình vs Task = API rời rạc

**Sai** (task rời rạc theo API, không nghiệm thu được như 1 đơn vị giá trị):
```
T-BE-005 — Register API
T-MOBILE-002.2 — Register screen (UI riêng, tách khỏi backend, khó biết bao giờ "xong" theo nghĩa user dùng được)
```

**Đúng** (task = màn hình, subtask theo module):
```
T-S04 — Register Screen
  ├─ T-S04.1 (BE)     Register API — POST /api/auth/register
  ├─ T-S04.2 (BE)     Gán Bronze mặc định khi tạo user (cross-epic: Membership)
  ├─ T-S04.3 (MOBILE) Register screen UI/logic
  └─ T-S04.4 (QA)     Test case: email trùng, password yếu, thành công
```

### Ví dụ Sai/Đúng — Foundational vs Subtask trùng lặp

**Sai** (Auth Guard bị copy thành "subtask" ở mọi màn hình cần login — 6 bản sao, sửa 1 chỗ quên 5 chỗ):
```
T-S06.0 (BE) Auth Guard + RBAC   <!-- lặp lại y hệt ở T-S07, T-S08, T-S09... -->
```

**Đúng** (Auth Guard là 1 Task foundational, mọi màn hình chỉ Depends On):
```
T-BE-009 — Auth Guard + RBAC          (Epic 2, độc lập)
T-S06 — Dashboard Screen  → Depends On (Task): T-BE-009, ...
T-S07 — Add/Edit Card     → Depends On (Task): T-BE-009, ...
```

### Ví dụ Sai/Đúng — Ref Docs

**Sai**: `SRS FR-AUTH-01` (text tự do, không bấm được)

**Đúng** (anchor an toàn):
`[ARCH-DB #2.2 Table Definitions](../../../../../architecture/database.md#22-table-definitions)`

**Đúng** (heading có ký tự đặc biệt → không đoán anchor, chỉ link file):
`[SRS — 3.1 FR-AUTH](../../../../../SRS.md)`
