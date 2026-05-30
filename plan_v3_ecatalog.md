# HK NEO+ Sterilizer · v3 기획서
## Long-scroll e-카탈로그 + 3D 컨피규레이터 통합

> **참조:** Daelim Bath/Kitchen mobile e-catalog (daelimbath.biz/e-catalog/mobile-about/), 기아 EV9 디지털 카탈로그, 삼성 B2B aiiBook
> **콘텐츠 소스:** ffrbiz.cafe24.com/mall/pdf/web/neo_plus.pdf, NEO_Plus_Mockups.pdf
> **재사용 자산:** 기존 3D 엔진 (HK_3dconfigurator_final.html)

---

## 1. 컨셉

**"카탈로그 페이지를 위에서 아래로 스크롤하면서 읽되, 핵심 페이지마다 3D 모델이 sticky로 따라오면서 살아 움직이는 형태."**

- 한국 B2B 시장이 익숙한 PDF 카탈로그 흐름을 그대로 따름 (목차 → 표지 → 기능 → 스펙 → 도면 → 인증 → 문의)
- 3D는 **단일 sticky 캔버스**로 페이지 전반에 걸쳐 유지. 스크롤 위치에 따라 카메라/조명/문열림 상태가 자동 전환
- 모바일 우선 (세로). 데스크탑은 좌(3D sticky) / 우(스크롤 텍스트) 분할
- PDF/CAD 다운로드 + 견적 문의 CTA는 우측 하단 플로팅 버튼

---

## 2. 전체 페이지 구조 (S00 → S15)

총 16개 섹션. 모바일 기준 각 섹션 = 100vh (한 화면). 데스크탑은 좌측 3D sticky, 우측 텍스트만 스크롤.

### S00 — HERO (인트로)
**3D 상태:** Full shot, 카메라 우측 위에서 비스듬, 배경 어둠
**카피:**
- Eyebrow: `HK · NEO+ STERILIZER`
- H1: `Engineered for Pure Preservation`
- Sub: `호텔·조리·병원을 위한 살균 캐비닛`
- 스크롤 다운 인디케이터 (↓ Scroll)

### S01 — POSITIONING (한 줄 정의)
**3D 상태:** Full shot 그대로, 카메라 천천히 좌측으로 panning
**카피:**
- H2: `99.9% 살균. 무화학. 무유지.`
- Body: `280nm UV-C LED, 음이온 발생기, 모듈식 거치대를 하나의 STS-304 캐비닛에 담았습니다.`
- Stat strip: `99.9% 살균률` · `280nm` · `25,000h` · `220V/60Hz`

### S02 — WHO IT'S FOR (사용처)
**3D 상태:** 카메라 멀리 빠짐 (제품 작게)
**카피:**
- H2: `이런 곳에 설치됩니다`
- 4개 카드 (호텔 / 단체급식 / 병원·요양 / 프랜차이즈 F&B)
- 각 카드에 짧은 시나리오 한 줄

### S03 — TABLE OF CONTENTS (목차)
**3D 상태:** 캐비닛 정면, 도어 닫힘 상태로 정지
**카피:**
- H2: `Five Core Systems`
- 6개 박스 (UV-C / Air Ionizer / LED Panel / Modular / Premium STS / Spec & Drawing)
- 각 박스 클릭 시 해당 섹션으로 smooth scroll

### S04 — UV-C STERILIZATION
**3D 상태 (자동):** 도어 좌우 활짝 열림 → UV-C LED 점등 → 푸른 빔 발사 (기존 UVC 챕터)
**카피:**
- Eyebrow: `01 · STERILIZATION`
- H1: `Kills 99.9% of what you can't see`
- Body: `280nm UV-C LED가 캐비닛 내부 전체를 살균합니다. 약품 없이, 교체 없이.`
- 3 카드: `CHEMICAL-FREE` / `HAZARD-FREE` / `280nm WAVELENGTH`
- 큰 통계: `99.9% STERILIZATION`

### S05 — AIR IONIZER
**3D 상태:** UV-C 꺼짐, 음이온 파티클 푸르게 떠다님 (기존 Ionizer 챕터)
**카피:**
- Eyebrow: `02 · AIR PURIFICATION`
- H1: `Clean air, every cycle`
- Body: `120만 개의 음이온이 캐비닛 내부 공기를 순환시키며 냄새와 부유 박테리아를 중화시킵니다.`
- 4 카드: `NEGATIVE ION` / `ANTIBACTERIAL` / `ODOR REMOVE` / `AIR FLOW`

### S06 — LED PANEL
**3D 상태:** 카메라 panel 클로즈업 (FOV 24, 망원). 패널 영상 재생 (panel_video2)
**카피:**
- Eyebrow: `03 · CONTROL`
- H1: `Every cycle, at a glance`
- Body: `직관적인 하나의 패널 — 모드·시간·실시간 상태.`
- 6 상태 그리드: `MODE` / `TIME` / `ALERT` / `DIAG` / `SOUND` / `LIGHT`

### S07 — MODULAR DESIGN
**3D 상태:** 도어 열린 채 카메라 내부로. 거치대들 인덱싱.
**카피:**
- Eyebrow: `04 · MODULAR`
- H1: `Configure your inside`
- Body: `8가지 거치대 모듈을 자유롭게 조합. 칼·도마·장갑·앞치마.`
- 8 모듈 카드 (F02 타공선반 / F03 칼 / F04 도마 / F05 고무장갑 / F06 고무장화 / F10 다기능 / F11 도마받침 / F16 앞치마)
- 우측 하단: `[모듈 구성하기 →]` (Builder 진입 미리보기, 현재는 placeholder)

### S08 — PREMIUM STAINLESS
**3D 상태:** 사이드 앵글 클로즈업, 표면 specular sweep
**카피:**
- Eyebrow: `05 · MATERIAL`
- H1: `Built to last`
- Body: `STS-304 0.8T 바디·도어. 위생적이고 부식에 강하며, 주방 환경에 최적화됐습니다.`
- 3 카드: `BODY STS-304 0.8T` / `DOOR STS-304 0.8T` / `FEET Adjustable Stainless`

### S09 — DIMENSIONS
**3D 상태:** 정면 정지 + 치수선 오버레이 (W/D/H)
**카피:**
- Eyebrow: `06 · DIMENSIONS`
- H1: `1000 × 600 × 1900 mm`
- Body: `설치 공간: 좌우 도어 스윙 각 600mm 권장. 캐비닛 본체 100kg.`
- 치수 표 (Width / Depth / Height / Weight / Power)

### S10 — SPEC TABLE
**3D 상태:** 작은 360° 뷰어 위젯 (스펙 옆에 박혀있음). 마우스/터치로 회전.
**카피:**
- H2: `Specifications`
- 표:
  | MODEL | HKNS-1019 |
  | SIZE (mm) | W1000 × D600 × H1900 |
  | THICKNESS | STS-304 · 0.8T |
  | DOOR | Dual swing |
  | STERILIZE | UV-C LED · 280nm |
  | POWER | 220V / 60Hz |
  | CONTROL | P.C.B |
  | WINDOW | Glass (Transparent) |
  | FEET | Adjustable Stainless |
  | CERT | KC · HACCP · 조달 24885355 |

### S11 — DRAWINGS
**3D 상태:** 3D 숨김 (텍스처 중심 섹션)
**카피:**
- H2: `Drawings`
- 3개 도면 이미지 (Front view / Side view / Plan view + Section)
- 우측 하단: `↓ DOWNLOAD PDF · CAD` 버튼

### S12 — CERTIFICATIONS
**3D 상태:** 3D 숨김
**카피:**
- H2: `Certified for trust`
- 인증 마크 3개 (KC / HACCP / 조달청 24885355)
- 각 마크 아래에 인증서 발급일·번호

### S13 — RESOURCES (다운로드 센터)
**3D 상태:** 3D 숨김
**카피:**
- H2: `Everything in one place`
- 4 PDF 카드:
  1. 사용설명서 (PDF 12p)
  2. **카탈로그 (PDF 24p · 2026)** ← ffrbiz.cafe24.com 실제 링크
  3. 도면·CAD (PDF + DWG)
  4. 인증서 (KC·HACCP·조달)

### S14 — FAQ
**3D 상태:** 3D 숨김
**카피:**
- H2: `Common questions`
- 카테고리 사이드 (전체 · UV-C 안전 · 설치/전원 · 사용/청소 · A/S)
- 10개 Q&A 아코디언

### S15 — CTA / CONTACT
**3D 상태:** 마지막 hero shot 다시 등장 (floating, black BG)
**카피:**
- H1: `Make it yours`
- Sub: `Pick your racks. See your price. Get a quote.`
- 큰 버튼: `BUILD YOUR CONFIGURATION →` (Builder)
- 연락처: `1899-3651` · KakaoTalk · Email · 카탈로그 다운로드
- 푸터: 회사 정보, 사업자등록, 주소

---

## 3. 항상 떠있는 UI 요소

### Floating Top Bar (스크롤 시 반투명)
- 좌: HK 로고 · NEO+ 텍스트
- 중앙(데스크탑): 현재 섹션 이름 + 페이지 인디케이터 (예: `04 / 16`)
- 우: 햄버거 메뉴 (목차 펼침)

### Right Edge Dot Nav
- 16개 dot 세로 배치
- 현재 섹션 dot 강조 + 라벨 hover 표시
- 클릭 시 해당 섹션으로 smooth scroll

### Bottom Floating CTA (모바일 only)
- 두 버튼: `↓ PDF 받기` · `✉ 견적 문의`
- 스크롤 200vh 지난 후 슬라이드 업으로 나타남

### Progress Bar (상단 1px 가는 줄)
- 전체 스크롤 진행률을 가시화

---

## 4. 3D 통합 방식

### sticky iframe 패턴
- `HK_3dconfigurator_final.html`을 iframe으로 embed
- iframe은 `position: sticky; top: 0; height: 100vh;`
- 부모 페이지가 길게 스크롤되는 동안 iframe은 화면에 고정
- 일정 영역 벗어나면 unstick (다음 텍스트 섹션으로 자연스럽게 넘김)

### 섹션 ↔ 3D 챕터 동기화
- IntersectionObserver로 현재 viewport에 들어온 섹션 감지
- 매핑 테이블:
  - S00, S01, S02, S03 → OVERVIEW
  - S04 → UV-C
  - S05 → IONIZER
  - S06 → PANEL
  - S07 → MODULAR
  - S08 → PREMIUM
  - S09 → DIMENSIONS
  - S10 → 작은 360° 뷰어 (별도 컴팩트 모드)
  - S11–S14 → 3D 숨김
  - S15 → OVERVIEW (다시)
- `iframe.contentWindow._enterChapter(chapter)` 호출로 전환

### 모바일 vs 데스크탑 레이아웃

**모바일 (≤ 768px):**
- 상단 50vh: iframe sticky
- 하단 50vh: 텍스트 카드 (스크롤로 진행)
- 텍스트 카드가 위로 슬라이드되면서 다음 섹션 도착

**데스크탑 (≥ 769px):**
- 좌 50%: iframe sticky (전체 페이지 동안)
- 우 50%: 스크롤되는 콘텐츠 컬럼
- 우측 컨텐츠는 최대 폭 540px

---

## 5. 인터랙션 디테일

- 섹션 도착 시 텍스트 fade-in + slide-up (50ms stagger)
- 큰 통계 숫자(99.9%, 1.2M 등)는 viewport 진입 시 counting animation
- 거치대 모듈 카드는 hover 시 미니 미리보기 (호버 이미지 swap)
- 카탈로그 PDF 다운로드 버튼 hover 시 PDF 첫 페이지 미니썸네일

---

## 6. 콘텐츠 출처 매핑

| 섹션 | 데이터 출처 |
|---|---|
| 모델명·치수·재질 | ffrbiz 카탈로그 / Mockup Spec table |
| 기능 카피 (UV-C/Ionizer/Modular) | Mockup PDF 챕터 02-06 |
| 거치대 8종 (F02–F16) | Mockup PDF 챕터 05 |
| 인증 정보 | Mockup PDF 챕터 07 + 조달 24885355 |
| FAQ Q&A | 일반적 살균기 카테고리 + v2 작성 |
| 연락처 | Mockup PDF 챕터 10 (1899-3651) |
| PDF 카탈로그 링크 | ffrbiz.cafe24.com/mall/pdf/web/neo_plus.pdf |

---

## 7. 파일 구조

신규 생성:
- `mobile_configurator_v3.html` — 메인 long-scroll 페이지 (별도 버전, v2와 공존)
- `HK_3dconfigurator_final.html` — 기존, 변경 없이 reuse (iframe으로 embed)

URL:
```
https://jed-cyber.github.io/configurator/mobile_configurator_v3.html
```

(기존 v1: `mobile_configurator_final.html`, v2: `mobile_configurator_v2.html` 그대로 유지)

---

## 8. 기술 스택

- 순수 HTML/CSS/JS (단일 파일)
- IntersectionObserver API (섹션 감지)
- CSS Scroll-driven animation (progress bar)
- postMessage / contentWindow direct call (iframe → 3D 챕터 전환)
- Lottie 또는 SVG icon (작은 아이콘들)
- 로컬 폰트: Inter / Pretendard

---

## 9. 다음 단계 (사용자 결정 필요)

1. **이 구조 OK?** S00~S15 16개 섹션 순서, 추가/삭제 의견
2. **카탈로그 PDF 실제 내용 확인** — ffrbiz PDF에서 추가 추출할 정보 있는지 (가격? 옵션? 부속품?)
3. **시각 톤** — Daelim처럼 화이트 베이스 / 또는 v1처럼 다크 베이스?
4. **거치대 8종 이미지** 있는지 (없으면 텍스트 + 아이콘만)
5. **인증 마크 이미지** 있는지 (KC, HACCP 공식 마크)
6. **로딩 시간** — 3D 엔진이 무거우므로 첫 진입 시 로딩 스플래시 어떻게?
7. **모바일에서 3D 비활성** 옵션 둘지 (성능 이슈 시)

---

## 10. 예상 구현 단계

1. **Phase A (1차 빌드):** v3 파일 생성 + 16개 섹션 텍스트만 (placeholder 이미지). 3D iframe 연결 + sticky.
2. **Phase B (3D 동기화):** IntersectionObserver로 섹션 감지 → iframe 챕터 자동 전환. 모바일/데스크탑 분기.
3. **Phase C (디테일):** 아이콘, 카드 hover, 카운팅 애니메이션, dot nav.
4. **Phase D (콘텐츠 보강):** 실제 사진/도면/인증마크 삽입.
5. **Phase E (Builder):** Modular 거치대 선택 + 견적 화면 (현재 placeholder).

각 Phase 끝날 때마다 GitHub Pages에 push해서 사용자 검수.
