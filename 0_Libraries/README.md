# 파일 2. `0_Libraries/SysideViews.sysml`

- **패키지명**: `library package <SV> SysideViews` (Sensmetry Syside Version 0.10.1 표준 뷰 라이브러리)
- **역할 및 목적**: SysML v2 모델을 Syside 환경에서 정형 테이블(`TableView`, `HierarchicalTableView`) 및 추적성 매트릭스(`MatrixView`, `ConnectionMatrixView`, `AllocationMatrixView`, `RequirementMatrixView`)로 렌더링하기 위한 메타모델 라이브러리입니다.
- **주요 정의 및 구성요소**:
  - `enum def <CT> ColumnType`: 테이블 열에 표시할 모델 요소의 메타데이터 종류를 정의합니다.
    - 주요 리터럴: `declaredShortName`, `declaredName`, `reqId`, `shortName`, `name`, `qualifiedName`, `owner`, `attributeValue`(특정 속성값 표시 및 UI 편집 지원), `namedFeatureValue`(참조/피처 값 표시), `documentation`, `specificDocumentation`, `heritage`(상속 계보 표시), `constraintLanguage`.
  - `enum def <Dir> MatrixTraceabilityDirection`: 매트릭스 행-열 간 관계 방향(`undirected` "✔", `row2col` "↗", `col2row` "↙").
  - `view def ContentView`: 라이브러리/참조/추상 요소 포함 여부 및 상속 피처 노출(`exposeFeaturesAndHeritage`) 기본 속성을 정의합니다.
  - `package <TVD> TableViewDefinitions`:
    - `view def <TV> TableView :> ContentView`: 행 높이(`maxRowHeight`), 필터(`globalFilter`), 열 순서(`columnOrder`), 개별 열 뷰(`columnViews`)를 정의합니다.
    - `view def <HTV> HierarchicalTableView :> TableView`: `SysML::Definition` 필터와 계층적 접기/펼치기 기능을 제공합니다.
  - `package <MVD> MatrixViewDefinitions`:
    - `MatrixView`, `EditableMatrixView`, 그리고 연결(`ConnectionUsage`), 할당(`AllocationUsage`), 요구사항 파생(`@RequirementDerivation::derivation`)을 각각 필터링하는 `ConnectionMatrixView`, `AllocationMatrixView`, `RequirementMatrixView`를 제공합니다.
- **모델 내 활용**: `2_ASELCM LV2_Chapter_Organization/5_Views_and_Viewpoints/3_ChapterViews.sysml`에서 회원 요구사항 일람표, 챕터 핵심 MoE 대시보드, 워킹그룹 제출 및 게이트 통과 현황 테이블을 구현할 때 직접 상속하여 사용합니다.

---

📜 0. AISkillsCatalog.sysml # 전체 AI Skill 메타데이터 정의 및 타겟 단계(Phase/Pillar) 매핑 모델
┃ ┣ 📜 Skill_P1_BlackBox_GtWR_Context.md # [Problem Black-Box] GtWR 요구사항 정제 & System Context 생성 스킬
┃ ┣ 📜 Skill_P2_WhiteBox_FuncDecomp_Refine.md # [Problem White-Box] 기능 분해, 개념 서브시스템 할당 & refine 감사 스킬
┃ ┣ 📜 Skill_S1_Solution_LSA_SysReqDeriver.md # [Solution LSA] 정형 시스템 요구사항(deriveReqt) 및 논리 인터페이스 도출 스킬
┃ ┣ 📜 Skill_S2_Solution_LSSA_SafetySec.md # [Solution LSSA] ISO 26262 / 21434 안전·보안 아키텍처 주입 및 satisfy 스킬
┃ ┗ 📜 Skill_I1_Impl_MBDBridge_ExecView.md # [Implementation & Gov] Simulink 연동, 보안 마스킹 & 리더십 설득 View 생성 스킬
