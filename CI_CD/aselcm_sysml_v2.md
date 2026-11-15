# ASELCM SysML v2 아키텍처 및 코드 품질 레퍼런스 가이드

본 문서는 **ASELCM (INCOSE Korea Chapter MBSE 프로젝트)** 코드베이스의 품질 기준(SSOT)입니다. 코드 커밋 및 리팩토링 시 AI는 본 문서의 **규칙 ID(`[ARCH-1]` 등)**를 기준으로 검토하며, 아래의 **토큰 최적화 프로토콜**을 엄격히 준수해야 합니다.

---

## 0. AI 코드 리뷰 및 토큰 최적화 프로토콜 (Token-Efficient Protocol)

AI는 매 커밋 검토 시 입출력 토큰 낭비를 막기 위해 반드시 아래 4가지 원칙으로만 응답합니다.

1. **위반 사항 중심 보고 (Exception-Only Reporting):**
   * 통과한 규칙은 설명하지 않고 체크리스트 요약(`Pass`)으로만 표기합니다.
   * 위반 사항이나 수정 내역은 **규칙 ID**(예: `[SYN-2]`)만 인용하여 1줄로 요약하고, 규칙의 정의를 장황하게 재설명하지 않습니다.
2. **변경 블록 부분 출력 (Targeted / Diff Output):**
   * 전체 파일 재출력은 **신규 파일**이거나 사용자가 명시적으로 **"전체 코드 출력"**을 요청한 경우에만 수행합니다.
   * 기존 파일 수정 시에는 변경된 요소(Part/Action/Constraint 등) 전후 맥락만 발췌하고, 변경 없는 코드는 `// ... 기존 코드 유지 ...`로 생략합니다.
3. **기존 TODO 재분석 금지 (Skip Known TODOs):**
   * 본 문서 **6.3절(Known TODO 레지스트리)**에 등록된 보류 항목은 매번 다시 지적하거나 분석하는 데 토큰을 쓰지 않습니다.
4. **고정 출력 포맷 (Compact Output Format):**
   * **① 변경/검토 요약표:** `| 규칙ID | 파일:요소명 | 변경/지적 내용 (1줄) | 상태(완료/TODO/Pass) |`
   * **② 의존성 검증:** 패키지 import 변경이 있을 때만 텍스트 트리 출력 (없으면 `"의존성 변경 없음 (DAG 유지)"` 1줄 표기).
   * **③ 수정 코드 블록:** `## 파일경로 ##` 헤더 + 수정된 코드 블록.

---

## 1. 아키텍처 및 단방향 의존성 규칙 (Architecture & DAG)

모든 패키지 간 `import`는 **단방향 비순환 그래프(DAG)**를 유지해야 하며, 하위 계층이 상위 계층을 참조하는 역방향 참조나 순환 참조(Cycle)를 엄격히 금지합니다.

### 1.1 계층별 역할 및 경계 규칙

* **`[ARCH-1]` 통합 계층 격리 (`0_ASELCM_Integration/*`):**
  * `LV3`(거버넌스)와 `LV2`(챕터 조직)를 동시에 import하여 포트(`connect`)와 동적 행위(`perform`, `exhibit`)를 연결하는 **유일한 위치**입니다. 다른 어떤 패키지도 통합 패키지를 import할 수 없습니다.
* **`[ARCH-2]` LV3 상위 독립성 (`1_ASELCM_LV3_Governance/*`):**
  * 모델링 규약, 글로벌/보안 정책, 품질 게이트(Feedback/Gate/Maturity) 및 인터페이스를 정의합니다. **`LV3`는 절대로 `LV2`나 `LV1`을 import하지 않습니다.**
* **`[ARCH-3]` LV2 단방향 참조 (`2_ASELCM_LV2_Chapter_Organization/*`):**
  * 챕터 목표, 조직, 회원, 스프린트, 과제 제출 및 뷰(View)를 관리하며, `LV3`를 단방향으로만 import합니다.
* **`[ARCH-4]` LV1 및 외부 라이브러리 보호:**
  * `3_ASELCM_LV1_Target_Reference_Models/*` 및 `0_Libraries/SysideViews.sysml`은 거버넌스/조직 모델 작업 시 수정하지 않으며, 참조 깨짐 여부만 점검합니다.

### 1.2 표준 패키지 의존 구조도 (Standard DAG)

```text
[0_ASELCM_Integration]
  ASELCM_SystemOfSystems ──► LV3 (GovernanceSystemAndTooling)
                         ──► LV2 (ChapterSystemContext, ChapterConOpsAndLifecycle)

[LV2 내부 및 LV2 ──► LV3 단방향 흐름]
  ChapterViews ──► ChapterViewpoints ──► StakeholdersConcerns
  StakeholdersConcerns ──► GovernanceSystemAndTooling(LV3), ChapterSystemContext, ExternalActorsAndInterfaces, StakeholderDefinitions
  WG_Submissions_Tracker ──► ModelingAssignments_and_Feedbacks ──► SprintMeetings_2026_Q4 ──► ChapterSprint
  ChapterSprint ──► WorkingGroupsAndRoles ──► ChapterSystemContext ──► ChapterMetricsAndGuards
  ChapterSystemContext ──► ChapterMembersDirectory ──► StakeholderDefinitions
  MemberNeedsAndSecurityRules ──► ChapterObjectives, ChapterSystemContext, ChapterMembersDirectory, StakeholderDefinitions
  ChapterSystemContext, ChapterMetricsAndGuards, ChapterConOpsAndLifecycle, ChapterSprint, ChapterObjectives
    ──► QualityGatesAndReviewProcess(LV3), GovernanceInterfaces(LV3)

[LV3 내부 흐름 (LV2/LV1 import 금지)]
  GovernanceSystemAndTooling ──► ModelingConventionsAndPolicies, QualityGatesAndReviewProcess
```

### 1.3 순환 참조 방지 패턴 (Anti-Cycle Patterns)

* **`[ARCH-5]` 양방향 참조(`ref`) 금지:** 부모-자식 또는 연관 객체 간 양쪽에 모두 `ref`를 두지 않습니다.
  * *표준 패턴:* `WorkingGroup`에는 제출물 목록을 두지 않고, `AssignmentSubmission`에서만 `ref workingGroup : WorkingGroup`으로 단방향 참조합니다.
  * *표준 패턴:* `ChapterArtifact`에서 `WorkingGroup`을 직접 참조하지 않고, 제출 모델의 `owner`를 `workingGroup.participants`(`IncoseKoreaChapterMember`)로 파생 연결합니다.
* **`[ARCH-6]` 공용 타입의 상위(LV3) 승격:** `LV2`와 `LV3`가 공유하는 Enum 및 임계값(`SEAssignmentStageKind`, `MaturityGateThresholds`, `Phase1ToPhase2GateConstraint` 등)은 `LV3`의 `QualityGatesAndReviewProcess`에 배치합니다.

---

## 2. 객체지향(OOP) 철학 및 SysML v2 문법 표준 (OOP & Syntax)

좋은 객체지향 프로그래밍(캡슐화, 상속, 다형성, 인터페이스 분리)의 철학을 SysML v2 표준 문법과 **Syside (v0.10.x)** 의미론에 정확히 매핑하여 작성합니다.

### 2.1 OOP 개념의 SysML v2 매핑 원칙

| OOP 개념 | SysML v2 구현 문법 | 적용 원칙 및 코드 예시 |
| :--- | :--- | :--- |
| **Class / Interface** | `* def` (`part def`, `item def`, `action def`) | 도메인 개념과 스키마(구조/행위/제약)는 반드시 `def`로 추상화. |
| **Instance / Field** | Usage (`part`, `item`, `action`, `attribute`) | 실제 운영 데이터(회원, WG, 회의록, 제출물)는 Usage로만 선언. |
| **Abstract Class** | `abstract constraint def`, `abstract part def` | 공통 시그니처 강제 (예: `AssignmentCheckpointRule`, `PhaseTransitionGateCondition`, LV1 스캐폴드). |
| **Inheritance / Subsetting** | `:>` (Specializes / Subsets) | 상위 `def` 상속 또는 컬렉션(`workingGroups`, `chapterMemberRoster`)에 원소 추가 시 사용. |
| **Method/Field Override** | `:>>` (Redefines) | 상속받은 속성값 지정, 파라미터 바인딩, 포트/참조 구체화 시 사용. |
| **Parameter Object (DTO)** | 복합 `attribute def` | 다수의 파라미터(17개 게이트 입력 등)는 `AssignmentGateChecklist` 하나로 캡슐화. |
| **Interface Inversion** | `port def` & Conjugation (`~`) | 기준 포트는 1곳만 정의하고 상대 액터는 켤레 포트(`~GovernanceInterfacePort`)로 대칭 결합. |

### 2.2 필수 문법 및 Syside 특화 규칙

* **`[SYN-1]` Part vs Item 정확한 타이핑:** `item def`로 선언된 타입(`ChapterArtifact`, `ReferenceModelArtifact`, `AISkillArtifact`, `AdvisoryFeedback`, `AssignmentSubmission`, `Sprint`)의 Usage는 반드시 **`item`** 키워드로 선언합니다 (`part` 사용 절대 금지).
* **`[SYN-2]` Constraint 바인딩 `:>>` 강제:** 모든 `constraint` 내부의 입력 파라미터 바인딩은 `in :>> paramName = value;` 형식을 따릅니다. 선언 형식도 동일 계층 내에서 `in paramName : Type;`으로 통일합니다.
* **`[SYN-3]` Constraint 평가 결과 참조 (`.result`):** Syside에서 `constraint` usage 자체는 `Boolean` 타입과 호환되지 않으므로, 파생 속성이나 `decide` 분기 가드에서 참조할 때는 반드시 `<constraintUsage>.result`를 사용합니다.
* **`[SYN-4]` 스코프 충돌 시 소유 타입 명시:** `AssignmentSubmission` 내부의 `gateCheck`처럼 소유 요소의 속성명(`checklist`)과 constraint 파라미터명(`checklist`)이 같을 경우, 자기 참조 오류를 막기 위해 `in :>> checklist = AssignmentSubmission::checklist;`로 한정합니다.
* **`[SYN-5]` Requirement `subject` 중복 바인딩 금지:** `satisfy <Req> by <Target>;` 구문이 있는 경우, Requirement Usage 내부에 `subject chapter = ...;`를 중복 선언하지 않습니다 (`feature-value-overriding` 방지).
* **`[SYN-6]` 파생 Concern의 `subject` 첫 줄 재선언:** `KoreanChapterConcern`을 상속받아 `stakeholder`를 추가하는 `concern def`는 Syside 규칙상 반드시 첫 줄에 `subject :>> theChapter;`를 재선언해야 합니다.
* **`[SYN-7]` TableView 컬럼 표기 유지:** `SysideViews::TableView`에서 `ColumnType::attributeValue { attributeName = "..."; }` 작성 시, `:>> attributeName`은 `reference-error`를 유발하므로 `attributeName = "..."` 표기를 유지합니다.

---

## 3. 단일 정의(SSOT) 및 확장성(OCP) 패턴

**단일 진실 공급원(SSOT)** 원칙에 따라 동일한 값·경로·임계값·설명을 두 곳 이상에 리터럴로 적지 않으며, **개방-폐쇄 원칙(OCP)**에 따라 기존 `def` 수정 없이 Usage 추가만으로 모델을 확장합니다.

### 3.1 단일 정의 및 자동 파생 규칙 (SSOT Rules)

* **`[SSOT-1]` 임계값 단일화 (`MaturityGateThresholds`):**
  * Phase 전환 숫자 임계값은 `LV3`의 `phase1To2Thresholds`, `phase2To3Thresholds`에만 정의하며, 모든 비교 연산은 `>=` (정수 최소값 기준, 예: 15명 초과는 `16`)으로 통일합니다.
  * `ChapterObjective.targetReferenceModelCount`(`= phase1To2Thresholds.refModels`)와 `ChapterMoEsHolder`의 판정식은 이 값을 참조하거나 constraint 결과(`.result`)에서 파생합니다.
* **`[SSOT-2]` 폴더 경로 자동 파생 (`DirectoryFolder`):**
  * 아티팩트는 문자열 경로 대신 `ref folder : DirectoryFolder`를 가집니다.
  * 하위 폴더 Usage는 `:>> relativePath = <상위폴더>.relativePath + "/" + folderName;` 수식으로 경로를 파생하며, 경로 리터럴이나 잘못된 기본값(URL 등)을 직접 적지 않습니다.
* **`[SSOT-3]` 워킹그룹(WG) 메타데이터 파생:**
  * `AssignmentSubmission.submittedModel`의 `domain`, `targetSoIName`, `modelFilePath`, `folder`, `owner`와 `submitters` 기본값(`default workingGroup.participants`)은 모두 `workingGroup`에서 파생합니다.
  * `WorkingGroup.targetSysmlPackagePath`는 `lv1RootPath + "/" + lv1PackageFolderName`으로 파생합니다.
* **`[SSOT-4]` 게이트 상태 파생 및 무결성 단언 (`assert`):**
  * `ReferenceModelArtifact.isGateApproved`는 수동 입력하지 않고 `AssignmentSubmission.isGatePassed` (`gateCheck.result`)에서 파생합니다.
  * `assert constraint statusGateConsistency { status == SubmissionStatusKind::approvedBaseline implies isGatePassed }`를 통해 상태와 게이트 결과의 모순을 차단합니다.
* **`[SSOT-5]` MoE 컬렉션 크기 파생 (`size`):**
  * `KoreaChapter`의 `completedReferenceModelsCount`와 `developedAISkillsCount`는 `size(repository.approvedReferenceModels)` 및 `size(repository.registeredAISkills)`로 자동 산출합니다.
* **`[SSOT-6]` 요구사항 속성 바인딩의 Def 내재화:**
  * `MemberNeedRequirement`와 `KnowledgeSharingSecurityRequirement`의 속성(`= member.coreValueWhat` 등)은 `requirement def` 내부에서 한 번만 바인딩하고, 개별 Usage(`need_M001` 등)에는 `subject`와 `actor`만 지정합니다.
* **`[SSOT-7]` 날짜 및 체크포인트 참조화:**
  * 과제/액션아이템 기한은 문자열 대신 `ref dueSprint : Sprint`를 참조하여 `dueDate`(`default dueSprint.endDate`)를 파생하고, 피드백 일시는 `ref action sourceMeeting`에서 파생합니다.
  * `ModelingAssignment.mandatoryCheckpoints`는 설명 문자열 대신 `AssignmentCheckpointRule` 하위 `constraint def`를 `ref`로 참조합니다.

### 3.2 표준 확장 레시피 (3-Line OCP Recipes)

| 확장 항목 | 수정 위치 및 작업 절차 (기존 `def` 수정 금지) |
| :--- | :--- |
| **새 WG 추가** | ① `DomainKind`에 enum 추가 및 `KnowledgeRepository`에 도메인 폴더 Usage 추가 (`relativePath` 파생식 필수)<br>② `chapterOrganization`에 `part <wg명> :> workingGroups { ... }` 추가<br>③ `WG_Submissions_Tracker`에 `item <제출명> : AssignmentSubmission` 추가 (`workingGroup`만 바인딩) |
| **새 회원 추가** | ① `ChapterMembersDirectory`에 `part <M0NN> '성명' : IncoseKoreaChapterMember :> chapterMemberRoster` 추가<br>② 설문 2 응답이 있을 경우 `need_M0NN` 및 `security_M0NN` Usage(`subject`, `actor`만 지정) 추가 |
| **새 과제 추가** | ① `ModelingAssignments_and_Feedbacks`에 `action <과제명> : ModelingAssignment` Usage 추가<br>② `dueSprint`와 `ref constraint ... :> mandatoryCheckpoints` 지정 후 트래커에 WG별 제출 Usage 추가 |
| **새 분기 회의록** | ① `N_SprintMeetings_YYYY_Qn.sysml` 파일 및 `SprintMeetings_YYYY_Qn` 패키지 생성<br>② 해당 분기의 `item sprintN : Sprint` 및 `action <회의명> : ChapterSprintMeeting` Usage만 추가 |

---

## 4. 일관성, 명명 규칙 및 보안 (Naming, Formatting & Security)

### 4.1 Import 및 참조 갱신 규칙

* **`[FMT-1]` 상단 Private Import & Short Name:** 모든 파일은 패키지 선언 직후 상단에 `private import <Package>::*;`를 모아서 선언하고, 본문에서는 짧은 이름(Short Name)만 사용합니다.
* **`[FMT-2]` 이름 변경 시 전역 동기화:** 요소 이름 변경 시 `import`, `expose`, `ref`, 바인딩뿐만 아니라 **`TableView`의 `attributeName = "..."` / `featureName = "..."` 문자열**까지 모두 함께 갱신합니다.
* **`[FMT-3]` View 노출 최소화:** `MemberValueView` 등에서 디렉터리 전체(`ChapterMembersDirectory::*`)를 무분별하게 `expose`하지 않고, 집합 루트(`chapterMemberRoster`)와 필요한 정의만 노출합니다.

### 4.2 명명 규칙 (`NamingConventionRule` 준수)

* **`[NAM-1]` Definition & Package:** `PascalCase` 사용. 숫자와 밑줄(`_`)은 구분자로만 허용 (예: `Gate1_WholeSystemScopeRule`, `SprintMeetings_2026_Q4`).
* **`[NAM-2]` Usage & Attribute:** `lowerCamelCase` 사용. 밑줄(`_`)은 순번·식별자·날짜 구분에만 허용 (예: `folder1_Meeting`, `kickOffMeeting_20261009`, `ai1_setupChannels`, `need_M001`).
* **`[NAM-3]` Enum Literal:** 반드시 소문자(`lowerCamelCase`)로 시작 (예: `stage1_SoIAndQuestionSelection`, `inProgress`).
* **`[NAM-4]` 식별자 및 따옴표 이름:**
  * 회원 ID는 별도 속성을 만들지 않고 SysML short name(`<M001>`)으로 부여하며, `Member.name` 같은 중복 속성을 두지 않습니다.
  * 작은따옴표 이름(`'이수'`, `'member value viewpoint'`)은 사람 실명과 Viewpoint에만 허용합니다.

### 4.3 개인정보 보호 및 기업 보안 (Security Redlines)

* **`[SEC-1]` 개인 연락처 절대 금지:** 전화번호(`phoneNumber`)와 이메일(`email`) 속성 및 값은 모델 내 어떤 파일에도 포함할 수 없습니다 (외부 비공개 파일로 분리).
* **`[SEC-2]` 거버넌스 문서 내 실명 배제:** `LV3` 및 아키텍처 설명 `doc` 주석에서는 특정 교수의 실명을 쓰지 않고 역할명(**"학술자문단"**, **"워킹그룹 리드"**)으로 표기합니다.
* **`[SEC-3]` 기업 기밀 배제:** 소속 기업의 실제 수치, 비공개 프로젝트명, 사내 데이터는 절대 기재하지 않으며 익명화/가상화된 데이터만 사용합니다.

---

## 5. 문서화(`doc /* ... */`) 작성 표준 및 템플릿

`doc /* ... */` 주석은 테이블 뷰와 아키텍처 문서로 렌더링되는 정식 모델 요소입니다. 코드의 가독성과 도메인 이해를 돕기 위해 아래 규칙과 템플릿을 따릅니다.

### 5.1 `doc` 작성 핵심 원칙

* **`[DOC-1]` 하드코딩된 개수/수치 기재 금지:** `doc` 안에 `"5대"`, `"6대"`, `"3종"`, `"4개 행"`처럼 요소 추가 시 거짓이 되는 개수 표현이나, `"발표 10건 이상"` 같은 중복 임계값 숫자를 적지 않습니다 (단, 회의록 원문 `keyDecisions`는 이력 보존을 위해 예외). 대신 `"Phase1ToPhase2GateConstraint 참조"`처럼 단일 정의 요소를 가리킵니다.
* **`[DOC-2]` 변경 이력 태그 금지:** `[신규]`, `[개선]`, `[추가]` 같은 태그는 `doc`에 남기지 않고 Git 이력에 맡깁니다.
* **`[DOC-3]` Gate/Feedback 기준 설명의 단일화:** 품질 게이트의 상세 평가 기준은 해당 `constraint def`의 `doc` 한 곳에만 작성합니다.
* **`[DOC-4]` 불확실한 사항의 표준 TODO 표기:** 도구 한계나 도메인 확인이 필요한 사항은 `// TODO(확인 필요): <원인 및 대안>` 형식으로 남깁니다.

### 5.2 표준 `doc` 작성 템플릿

```sysml
// 1) 패키지 헤더 doc 템플릿
package <PackageName> {
    doc
    /* [<시스템 계층 또는 뷰포인트 명칭>]
     * 목적: <이 패키지가 해결하는 핵심 책임 1~2문장>
     * 의존 방향: <import 규칙 및 순환 방지 원칙 명시>
     * 확장 방법: <새 Usage 추가 시 수정해야 할 절차 요약 (해당 시)>
     */

// 2) Constraint / Gate def doc 템플릿
constraint def <GateName> :> AssignmentCheckpointRule {
    doc
    /* [<게이트 식별자 및 핵심 원칙 명칭>]
     * 판정 목적: <무엇을 검증하는가>
     * 통과 기준: <정성적/구조적 충족 요건 (구체적 숫자 임계값은 attribute 이름만 인용)>
     */
```

---

## 6. 유지보수성, CI/CD 파이프라인 및 도구 한계 대응

### 6.1 CI/CD 자동 검증 단계 (Automated Pipeline Stages)

커밋 및 PR 시 자동화 스크립트는 아래 4단계를 순서대로 검증합니다.

1. **Stage 1 (`syside check`):** 전체 `.sysml` 구문 오류, 타입 오류, 미해결 참조(`reference-error`), 중복 바인딩(`feature-value-overriding`) **0건** 확인.
2. **Stage 2 (DAG & Layer Linter):** 패키지 `import` 그래프를 추출하여 **순환 참조 0건** 및 **`LV3`의 `LV2`/`LV1` import 0건** 확인.
3. **Stage 3 (Static Rule & Security Linter):**
   * 정규식 스캔: 이메일(`@`), 전화번호(`010-`), 금지 속성(`phoneNumber`, `email`), `LV3 doc` 내 교수 실명, `[신규]`/`[개선]` 태그 검출 시 실패.
   * AST/패턴 스캔: `item def`의 `part` 선언 여부, `constraint` 내부 `in :>>` 누락 여부, 하위 `DirectoryFolder`의 `relativePath` 파생식 누락 여부 확인.
4. **Stage 4 (Artifact Sync):** 검증 통과 시 `merged_sysml.txt`, `diagrams/*.svg`, 테이블 뷰 export 산출물을 자동 재생성하여 커밋에 반영.

### 6.2 Syside (v0.10.x) 정적 평가기 한계 및 백업 전략 (Fallback Patterns)

| 기능 영역 | 현재 적용 패턴 | 도구/평가기 한계 및 문제 발생 시 전환할 백업(Fallback) 패턴 |
| :--- | :--- | :--- |
| **Constraint 결과 참조** | `<constraintUsage>.result` | Python 정적 평가기는 `.result` 값을 계산하지 못하고 참조만 반환함. 실행 환경에서 문제 시 **파생 Boolean 식만 남기고 constraint는 `assert constraint`로 전환**. |
| **컬렉션 크기 (`size`)** | `size(repository.approvedReferenceModels)` | 정적 평가기는 빈 컬렉션도 `1`로 평가함. UI 편집과 충돌 시 **수동 입력 속성 + `assert constraint { count == size(...) }` 방식으로 전환**. |
| **TableView 중첩 컬럼** | `AssignmentGateChecklist` 복합 속성 | 중첩 속성(`checklist.isIndependentWholeSystem`) 개별 열 렌더링 불가 시, **필요 항목만 상위 Usage에 1줄 파생 속성으로 노출**하거나 **`MatrixView` 사용**. |
| **패키지 Usage 확장** | `part chapterContext :> incoseKoreaChapterContext` | 통합 패키지에서 baseline과 인스턴스가 분리될 경우, baseline을 `part def`로 바꾸고 통합 패키지에서 단일 인스턴스 생성. |

### 6.3 현재 모델의 Known TODO 레지스트리 (AI 재분석 금지 목록)

아래 항목들은 현재 코드에 의도적으로 남겨둔 `TODO` 및 보류 결정 사항입니다. **사용자가 명시적으로 해소를 지시하기 전까지 AI는 리뷰 시 이 항목들을 오류로 지적하거나 임의로 수정하지 않습니다.**

1. **Automotive WG 참여자 vs 제출자 불일치:** WG 참여자(`'추수호', '최성열', '이의범'`)와 과제 제출자(`'추수호', '최성열'`)가 달라 `automotiveWG_Sub_Assignment2`에서 `submitters`를 재정의해 둔 상태.
2. **Phase 2 스폰서 조건 미포함:** `sponsorshipAndOfflineSeminarPhase` 단계명에는 '스폰서 확보'가 있으나 `Phase1ToPhase2GateConstraint` 판정식에는 기업 스폰서 조건이 제외되어 있음.
3. **회원 도메인 응답 보존:** `'김희재'` 회원의 설문 응답(`DomainKind::other` + `domainOther = "Manufacturing Semiconductor Equipment"`)은 설문 원문 보존을 위해 `semiconductor`로 임의 변경하지 않음.
4. **Phase 1 인가 상태 (`charterStatus`):** `KoreaChapter.charterStatus`가 `chartered`로 설정되어 있으며, Phase 1 기준 `emerging` 여부는 운영진 확인 보류 상태.
5. **통합 패키지 Action 입출력 바인딩:** `ASELCM_SystemOfSystems` 내 `perform action`들의 `in/out` 파라미터(`internalData` 등)와 `chapter.repository` 간 세부 바인딩 보류.
6. **`NamingConventionRule` 입력 바인딩:** `default true`는 제거 완료했으며, 외부 Python 린트 스크립트 결과를 입력 파라미터에 바인딩하는 자동화는 추후 구현 예정.

---

## 7. 커밋 전 8대 필수 체크리스트 (Fast Verification Checklist)

AI는 코드 생성/수정 완료 전 아래 8개 항목을 내부적으로 점검하고, 위반이 있을 때만 요약표에 보고합니다.

* `[ARCH]` **1. 단방향 의존성:** `LV3`가 `LV2`/`LV1`을 import하지 않으며, 전체 패키지 그래프에 순환 import가 없는가? (`[ARCH-1~6]`)
* `[SYN]` **2. 정확한 타이핑:** `item def`로 정의된 타입이 `part`로 선언된 곳이 없는가? (`[SYN-1]`)
* `[SYN]` **3. 바인딩 문법:** 모든 `constraint` 파라미터 바인딩에 `in :>>`가 붙어 있고, `.result` 참조 및 스코프 한정(`Type::attr`)이 정확한가? (`[SYN-2~6]`)
* `[SSOT]` **4. 중복 리터럴 제거:** 숫자 임계값, 폴더 경로 문자열, WG 메타데이터, 게이트 기준 설명이 두 곳 이상에 리터럴로 남아 있지 않은가? (`[SSOT-1~7]`)
* `[OCP]` **5. 확장성 유지:** WG, 회원, 과제, 회의록 추가 시 기존 `def`를 고치지 않고 Usage 추가만으로 완료되는가? (3.2절)
* `[FMT]` **6. 참조 무결성 및 명명 규칙:** 요소 이름 변경 시 `import`, `expose`, `ref`, 바인딩, `TableView`의 `attributeName` 문자열이 모두 함께 갱신되었으며, 명명 규칙을 준수하는가? (`[FMT-1~3]`, `[NAM-1~4]`)
* `[SEC]` **7. 개인정보 및 보안:** 전화번호, 이메일, 사내 기밀 데이터, 그리고 `LV3 doc` 내의 교수 실명이 완전히 배제되었는가? (`[SEC-1~3]`)
* `[DOC]` **8. 문서화 품질:** 새로운 요소에 명확한 `doc /* ... */`이 작성되었으며, 개수가 바뀌면 틀어지는 표현("5대", "3종" 등)이나 이력 태그(`[신규]` 등)가 없는가? (`[DOC-1~4]`)