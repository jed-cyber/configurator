══════════════════════════════════════════════════════
  HK 3D Configurator — 폴더 안내
══════════════════════════════════════════════════════

▶ 실행 방법
─────────────────────────────────────────────────
  1) start.bat 더블클릭
  2) 자동으로 브라우저 열림 → http://localhost:8000/splat_configurator.html
  3) 종료할 때 검정 cmd 창에서 Ctrl+C

  ※ 단독 캐비넷만 (splat 배경 없이) 보려면:
     http://localhost:8000/HK_3dconfigurator.html


▶ 현재 사용 중인 파일 (건드리지 말 것)
─────────────────────────────────────────────────
  start.bat                     서버 시작 + 브라우저 자동 오픈
  splat_configurator.html       메인 화면 (splat 배경 + iframe 안 캐비넷)
  HK_3dconfigurator.html        캐비넷 3D 본체 (95% 코드가 여기)
  lookdev-preset (5).json       현재 룩데브 preset (HDRI/라이트/색감)
  hk_mainmodeling_assemble.glb  캐비넷 3D 모델
  three-global-shim.js          Three.js 글로벌 노출 shim
  tex\                          텍스처 (floor, AO, imagesequence)


▶ 부가 파일
─────────────────────────────────────────────────
  정리.bat                      backup 파일을 _archive\ 로 이동 (1회 실행)
  README.txt                    이 문서
  screenshots\                  검수 캡쳐 / 진단 메모
  _archive\                     옛 backup / 메모 (정리.bat 실행 후 생성됨)


▶ 작업 흐름 메모
─────────────────────────────────────────────────
  · HK_3dconfigurator.html 이 거대한 단일 HTML — 95% 코드.
  · 키프레임 BG 그레이딩 시스템 (v77.813):
      window._OVERVIEW_BG / _UVC_BG 객체로 챕터별 룩 정의
      window.keyframeBgLerp(target, durMs) 단일 함수
      window._bgKeyframeSyncTick() 매 frame sync (라이브 슬라이더)
  · 새 챕터 추가 시: _XXX_BG 객체 + onEnter/onExit 에서 keyframeBgLerp 호출
  · 디버그용 노출: window.bcPass / hsPass / wbPass / composer


▶ 자주 깨지는 부분
─────────────────────────────────────────────────
  · 캐시 — Ctrl+Shift+R 로 하드 리로드 권장
  · iframe 캐시 — splat_configurator.html 의 iframe src 에 Date.now()
    cache buster 가 자동 추가되어 있음 (v77.781+)
  · Python 서버 — Python 3.x 필요 (start.bat 가 py -3 -> python 순서로 시도)
