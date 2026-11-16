#### [2-4] 회원 및 활동 레지스트리 (`4_Member_and_Activity_Registry/`)

스키마(`def`)와 분리된 **실제 데이터 인스턴스(Usage) 기록소**입니다.

##### 파일 14. `2_ASELCM LV2_Chapter_Organization/4_Member_and_Activity_Registry/1_ChapterMembersDirectory.sysml`

- **패키지명**: `ChapterMembersDirectory`
- **역할 및 목적**: 챕터 소속 13명 회원의 실제 설문 1·2 응답 데이터를 `IncoseKoreaChapterMember` Usage로 등록하고 `chapterMemberRoster` 컬렉션으로 묶는 디렉터리 파일입니다.
- **주요 정의 및 구성요소**:
  - `part chapterMemberRoster : IncoseKoreaChapterMember [0..*];` (전체 회원 컬렉션)
  - **등록된 13명 회원 Usage 요약 (`<M001>` ~ `<M013>`)**:

| 회원 ID (`short name`) |    성명    | 소속 및 직책                                          | 주요 도메인 (`domain`)   | 설문 2 (GtWR 요구사항/보안 규칙) 응답 여부 및 핵심 키워드                                                      |
| :--------------------: | :--------: | :---------------------------------------------------- | :----------------------- | :------------------------------------------------------------------------------------------------------------- |
|      **`<M001>`**      |  `'이수'`  | 인터그래비티(주) / 비행SW팀 연구원                    | 방산/항공우주            | **응답 완료** — MBSE 실무 적용, 디지털 엔지니어링, SysML v2 기반 MILS/SILS/HILS 시뮬레이션 레퍼런스            |
|      **`<M002>`**      | `'박승훈'` | 영풍전자 / 무인항전체계개발팀 책임연구원              | 방산/항공우주            | **응답 완료** — 무인기 MBSE 실무 지식 및 모델링 툴 적용, LRU SW/HW 요구도 구조화                               |
|      **`<M003>`**      | `'이중윤'` | 아주대학교 / 시스템공학과 교수                        | 방산/자동차/철도/IT/학계 | **응답 완료** — 도메인별 개념설계 참조모델 개발(R.1) 및 아키텍트 양성(R.2), AI 보안 처리 후 공개               |
|      **`<M004>`**      | `'서은석'` | 서울대학교 / 교수                                     | 자동차/학계              | **응답 완료** — SE 산학협력, 한국 기업이 Fast Follower에서 First Mover로 도약하기 위한 SE 전파                 |
|      **`<M005>`**      | `'추수호'` | 현대모비스 / 책임연구원 (시스템 엔지니어)             | 자동차/모빌리티          | **응답 완료** — SysML v2 + MBSE + ISO 26262 + ISO/SAE 21434 통합 자동차 아키텍처 레퍼런스 완성                 |
|      **`<M006>`**      | `'구정모'` | 볼보그룹코리아(주) / Principal Solution Architect     | 자동차/IT                | **응답 완료** — 제품 개발 단계 SysML 적용, MBSE Ontology 및 메타모델 레퍼런스                                  |
|      **`<M007>`**      | `'김희재'` | 에드워드코리아 / NPI-IS Sr. Systems Engineer          | 기타 (반도체 장비 제조)  | **응답 완료** — MBSE 활용성, 요구사항/V&V 추적성 및 Regression 관리, 살아있는(Live) 아키텍처 문서화            |
|      **`<M008>`**      | `'김다운'` | 한국항공우주산업(KAI) / 디지털엔지니어링팀 선임연구원 | 방산/항공우주            | **응답 완료** — 항공기 개발 MBSE 실효성 입증, RA 모델 및 RFLP/Agile 방법론, K-MOSA 기여                        |
|      **`<M009>`**      | `'박홍석'` | 시스템엔지니어링(주) / 연구개발팀 연구원              | 학계/연구소              | **응답 완료** — SysML v2, ISO 15288, 시니어 설계자의 관점 전환 및 계층 분리 사례, 자사 SysML v2 도구 실습 제공 |
|      **`<M010>`**      | `'심정환'` | 로터스정보기술 / 대표이사                             | IT/소프트웨어            | 설문 1만 보유 — INCOSE 공인 국제 인증자격(SEP) 소모임 및 스터디그룹 기대                                       |
|      **`<M011>`**      | `'최성열'` | 현대모비스 / 책임연구원 (시스템 엔지니어)             | (설문 1 기본 소속 보유)  | 설문 1 기본 소속/직책 보유 (Automotive WG 핵심 모델러로 활동)                                                  |
|      **`<M012>`**      | `'최지원'` | 아주대학교 / 공학연구소 연구원                        | IT/학계                  | 설문 1만 보유 — 신흥 SE 기술 교류, 국제 세미나, SEP 자격증 스터디 관심                                         |
|      **`<M013>`**      | `'이의범'` | 현대모비스 / 책임연구원 (시스템 평가 엔지니어)        | (설문 1 기본 소속 보유)  | 설문 1 기본 소속/직책 보유 (Automotive WG 참여)                                                                |

---

##### 파일 15. `2_ASELCM LV2_Chapter_Organization/4_Member_and_Activity_Registry/2_MemberNeedsAndSecurityRules.sysml`

- **패키지명**: `MemberNeedsAndSecurityRules`
- **역할 및 목적**: 설문 2에 응답한 9명 회원(`<M001>` ~ `<M009>`)의 속성 데이터를 요구사항 객체(`MemberNeedRequirement`)와 보안 규칙 객체(`KnowledgeSharingSecurityRequirement`)로 변환하고, 모든 회원 요구사항이 챕터 최상위 목적(`chapterObjective`)으로부터 파생(`#derivation connection`)되었음을 추적성으로 연결합니다.
- **주요 정의 및 구성요소**:
  - **하위 패키지 1: `ChapterMembers_Needs`**
    - `requirement def MemberNeedRequirement`: `subject chapter : KoreaChapter`와 `actor member : IncoseKoreaChapterMember`만 지정하면, 내부 속성(`coreValueWhat`, `rationale`, `validationCriterion`, `priority`)이 `member.<속성>`으로부터 자동 바인딩되도록 설계되어 데이터 중복 기재를 방지합니다.
    - `need_M001` ~ `need_M009`: `'이수'`부터 `'박홍석'`까지 9명의 개별 요구사항 Usage이며, 각각 `#derivation connection { end #original ::> chapterObjective; end #derive ::> need_M00N; }`를 통해 최상위 목표와의 요구사항 파생 추적성(Requirement Traceability)을 형성합니다.
  - **하위 패키지 2: `SecurityRules`**
    - `requirement def KnowledgeSharingSecurityRequirement`: `actor member`의 `securityRule`과 `securityRuleOther`를 자동 바인딩하는 보안 요구사항 정의.
    - `security_M001` ~ `security_M009`: 9명 회원의 개별 정보보안 제약사항 Usage.

---

##### 파일 16. `2_ASELCM LV2_Chapter_Organization/4_Member_and_Activity_Registry/3_SprintMeetings_2026_Q4.sysml`

- **패키지명**: `SprintMeetings_2026_Q4`
- **역할 및 목적**: 2026년 4분기 스프린트 일정(`sprint1` ~ `sprint3`)과 3건의 실제 회의 기록(킥오프 미팅, 1차 온라인 미팅, 2차 온라인 미팅), 회의록 아티팩트 메타데이터, 그리고 각 회의에서 도출된 단기 실행 과제(`ActionItemTask`)를 정형 모델로 기록합니다.
- **주요 정의 및 구성요소**:
  - **스프린트 일정 Usage**:
    - `sprint1` (마감: 2026-10-23), `sprint2` (마감: 2026-11-13), `sprint3` (마감: 2026-11-27).
  - **회의 1: `action kickOffMeeting_20261009 : ChapterSprintMeeting` (2026-10-09 18:00 KST)**
    - 장소: 사당역 주변 셀스스토리 8인 회의실 / 우담정 (모드: `projectLab`, 참석자 6명: 이중윤, 서은석, 추수호, 최성열, 이수, 박홍석).
    - 핵심 결정사항: Think-Tank가 아닌 **Do-Tank** 지향, SDV 비히클 전체/우주 임무 전체 대상 하향식 모델링, 사내 민감 데이터 금지 및 공개/AI 가상 데이터 활용, 격주 웹 미팅 및 분기 오프라인 모임 확정.
    - Action Items: `ai1_setupChannels`(추수호, 즉시 처리), `ai2_selectTargetSoI`(추수호/최성열/이수/박홍석, 기한: `sprint1`).
  - **회의 2: `action onlineMeeting1_20261030 : ChapterSprintMeeting` (2026-10-30 19:52 KST)**
    - 장소: Google Meet 및 SE-Labs AI 협업 공간 (모드: `onlineReview`, 참석자 9명).
    - 핵심 결정사항: 4대 WG 대상 시스템(SoI) 확정, **2035년 목표 시점 및 DoDAF 2.02(AV-1, AV-2, OV-1) 목차 통일**, 드론 3대 임무별(감시정찰/공격/보급) PESTEL-CTIMMRA 및 OV-1(정상/최악) 분리, 상위 효과(와우 포인트, 공장 수율 등) 중심 MOE 계층화, 반도체 장비의 Level 0 상위 공정 컨텍스트 및 공장 베리에이션 하향식 정의.
    - Action Items (`ai1` ~ `ai7`): 목차 통일 및 AI Skills 공유(`ai1`), Aerospace/Automotive/Semiconductor/Robotics 각 WG별 ConOps 보완(`ai2`~`ai5`, 기한: `sprint2`), SE-Labs 워크스페이스/세미나(`ai6`), 차기 회의 일정 투표(`ai7`, 기한: 2026-11-04).
  - **회의 3: `action onlineMeeting2_20261113 : ChapterSprintMeeting` (2026-11-13 19:53 KST)**
    - 장소: Google Meet 및 SE-Labs AI 협업 공간 (모드: `onlineReview`, 참석자 5명: 이중윤, 추수호, 박홍석, 최성열, 김희재).
    - 핵심 결정사항:
      1. Automotive WG 대상 시스템을 **'인간-AI-다중로봇 공생형 전주기 자율주행 모빌리티 복합체계(SoS)'** 및 7대 구성 시스템(CS1~CS7)으로 확장.
      2. 생성형 AI 루브릭 의존 배제 및 인간 아키텍트가 직접 검토·승인하는 **설명 가능한 AI(XAI) 거버넌스** 확립.
      3. 사용자 관점 **MOE**와 개발자 관점 **MOP** 명확히 분리 및 V-사이클 좌측 상단 사전 검증(시뮬레이션/FMEA).
      4. CV(Capability View) 생략 및 **AV-1 -> AV-2 -> OV-1 -> OV-5b -> SV-10c** 순서로 모델링 절차 표준화, OV-5b와 SV-10c 간 할당(`Allocation`/`implementedBy`) 추적성 설정.
      5. SE-Labs AI의 메타모델 관리 모드(Definition)와 사용 모드(Usage) 분리 거버넌스 및 GitHub/VS Code 연동.
      6. Semiconductor WG(EUV Zenith 진공 펌프)의 ASML 노광장비 미션 서비스 정의, 자체 개발 목표값(10% 마진)과 3시그마 산포 통제, 최악 조건(부품 산포, 정전, 지진 등) 시나리오 반영.
    - Action Items (`ai1` ~ `ai4`, 기한: `sprint3` / 즉시): Automotive MOE/MOP 분리 및 로봇 작업단(CS4) 상세화(`ai1`), 핵심 시나리오 5~6개 선정 및 OV-5b/SV-10c 매핑 발표(`ai2`), SE-Labs 토론탭 링크 공유(`ai3`), Semiconductor 최악 조건 및 MRS Beating Point 반영(`ai4`).

---

##### 파일 17. `2_ASELCM LV2_Chapter_Organization/4_Member_and_Activity_Registry/4_ModelingAssignments_and_Feedbacks.sysml`

- **패키지명**: `ModelingAssignments_and_Feedbacks`
- **역할 및 목적**: 워킹그룹들이 참고하는 실무 가이드 문서 아티팩트와 SE 모델링 과제 마스터(`assignment1_2_BlackBoxAndConOps`), 그리고 해당 과제에 부여된 학술자문단(이중윤 교수님)의 1·2차 피드백 레코드를 관리합니다.
- **주요 정의 및 구성요소**:
  - **참고 아티팩트 (섹션 1)**:
    - `blackBoxConOpsGuide_PDF`: `"SE 블랙박스 정의 및 운용시나리오(ConOps) 개발 실무 가이드"` (`6. Projects/2. references` 폴더 매핑 및 Google Drive URL 포함).
    - `pestelAndMbseCookbook_Source`: `"PESTEL-CTIMMRA 분석 템플릿, DoDAF 2.02 가이드 및 MBSE 쿡북 리소스"` (`7. Source` 폴더 매핑).
  - **과제 마스터 정의 (섹션 2: `action assignment1_2_BlackBoxAndConOps : ModelingAssignment`)**:
    - 과제 번호 `(1, 2)` 및 단계(`stage1_SoIAndQuestionSelection`, `stage2_BlackBoxAndConOps`) 통합 정의.
    - 상속 대상 스캐폴드로 `"LV1_BlackBox_ConOps_Scaffold"`를 지정하고, 통과 필수 요건으로 LV3의 `ReferenceModelAssignmentApprovalGate`를 참조(`ref constraint cp_approvalGate`)합니다.
    - **학술자문단 피드백 내역 (`advisoryFeedbacks`)**:
      - `profFeedback_1_KickOff` (`kickOffMeeting_20261009`에서 일자 자동 파생): 존재목적 달성 표현, 정량적 MOE(목표값/한계값/단위) 정의, 블랙박스 대상시스템과 외부 환경(운용 시점 인프라 가정) 간 상호작용 초점.
      - `profFeedback_2_OnlineSprint1` (`onlineMeeting1_20261030`에서 일자 자동 파생): 2035년 기준 AV-1/AV-2/OV-1 목차 통일 및 PESTEL-CTIMMRA 반영, 다목적 드론의 임무별 맥락/시나리오 분리, 상위 효과 중심 MOE 계층화, 반도체 장비의 Level 0 상위 공정 컨텍스트 및 공장별 베리에이션 하향식 정의.

---

##### 파일 18. `2_ASELCM LV2_Chapter_Organization/4_Member_and_Activity_Registry/5_WG_Submissions_Tracker.sysml`

- **패키지명**: `WG_Submissions_Tracker`
- **역할 및 목적**: 4대 도메인 워킹그룹이 과제 1·2(`assignment1_2_BlackBoxAndConOps`)에 대해 제출한 참조모델 현황과 품질 게이트 통과 상태를 추적하는 레지스트리입니다.
- **주요 정의 및 구성요소**:
  - 각 제출 Usage는 `targetAssignment`와 `workingGroup`만 바인딩하여 도메인, SoI 명칭, 패키지 경로, 폴더, 소유자를 자동 파생받습니다:

| 제출 트래커 Usage 명                  | 매핑 워킹그룹 (`workingGroup`)        | 제출 모델 제목 (`submittedModel.title`)                                                   | 모델 버전 (`modelVersion`) | 보안 클리어 (`isSecurityCleared`) | 현재 상태 (`status`) |
| :------------------------------------ | :------------------------------------ | :---------------------------------------------------------------------------------------- | :------------------------: | :-------------------------------: | :------------------: |
| **`aerospaceWG_Sub_Assignment2`**     | `chapterOrganization.aerospaceWG`     | Multi-Purpose Quadcopter Drone System (Surveillance, Strike, Logistics) Reference Model   |    `v0.2-DoDAF-ConOps`     |              `true`               |     `inProgress`     |
| **`automotiveWG_Sub_Assignment2`**    | `chapterOrganization.automotiveWG`    | 2035 Software-Defined Vehicle (SDV) Whole-System Reference Model (제출자: 추수호, 최성열) |    `v0.2-DoDAF-ConOps`     |              `true`               |     `inProgress`     |
| **`itRoboticsWG_Sub_Assignment2`**    | `chapterOrganization.itSwWG`          | Disaster Search and Rescue Support Robot System Reference Model                           |    `v0.2-DoDAF-ConOps`     |              `true`               |     `inProgress`     |
| **`semiconductorWG_Sub_Assignment2`** | `chapterOrganization.semiconductorWG` | EUV Zenith Semiconductor Equipment Fab-Context Reference Model                            |    `v0.2-DoDAF-ConOps`     |              `true`               |     `inProgress`     |

---
