#### [2-5] 뷰포인트 및 뷰 (`5_Views_and_Viewpoints/`)

ISO/IEC/IEEE 42010 아키텍처 기술 표준에 따라 **이해관계자 관심사(`Concern`) -> 관점(`Viewpoint`) -> 뷰 및 대시보드 테이블(`View` / `TableView`)**을 빈틈없이 연결합니다.

##### 파일 19. `2_ASELCM LV2_Chapter_Organization/5_Views_and_Viewpoints/1_StakeholdersConcerns.sysml`

- **패키지명**: `StakeholdersConcerns`
- **역할 및 목적**: 챕터 내·외부 이해관계자들이 챕터 시스템(`theChapter : KoreaChapter`)에 대해 가지는 **8대 핵심 관심사(Concerns)**를 5개 그룹으로 정의합니다.
- **주요 정의 및 구성요소**:
  - `concern def KoreanChapterConcern`: 공통 `subject theChapter : KoreaChapter` 및 기본 `stakeholder member : Member`를 정의하는 부모 Concern.
  - **5대 그룹별 8개 세부 Concern**:
    1. **Group 1 (Member Value 매핑)**:
       - `StakeholderIdentificationConcern`: 회원 소속, 도메인, 지역, 가용 기여 자원 식별.
       - `ValueRationaleValidationConcern`: 회원에게 제공할 핵심 가치(What), 근거(Why), 검증 기준(Validation), 우선순위(Priority).
       - `RiskSecurityConcern`: 기업 IP 보호 및 민감 기술 정보 침해 방지를 위한 보안 규칙(`SecurityRule`).
    2. **Group 2 (Administrative Operations 매핑)**:
       - `OperationalFlowConcern` (추가 이해관계자: `ContextINCOSESector`): 스프린트, 과제 수행, 세미나 및 섹터 보고 흐름.
       - `KnowledgeAssetConcern`: 회의록, 가이드, LV1 참조모델 코드의 구조화 및 `KnowledgeRepository` 형상 관리.
       - `LifecycleEvolutionConcern`: Phase 1 -> 2 -> 3 성장 단계 전환 및 핵심 성과 지표(Core MoEs) 관리.
    3. **Group 3 (INCOSE Alignment 매핑)**:
       - `BoundaryDependencyConcern` (추가 이해관계자: `ContextToolVendor`, `ContextTechnicalOperations`): 외부 의존성, 가용 툴 라이선스 및 글로벌 리소스(SE Handbook) 연계.
    4. **Group 4 (Peer Society Connection 매핑)**:
       - `CapabilityValueConcern` (추가 이해관계자: `PeerSocietyMember`, `ContextPeerSocietyOrganization`): 국내 타 학회(KOSSE/KCOSE) 대비 고유 역량 제공.
    5. **Group 5 (Governance and Quality 매핑)**:
       - `GovernanceQualityConcern` (추가 이해관계자: `GovernanceSystemContext`): LV3 모델링 규약, 품질 게이트(피드백/가이드 Gate) 충족 여부 및 제출 상태(`status`)와의 무모순성 추적.

---

##### 파일 20. `2_ASELCM LV2_Chapter_Organization/5_Views_and_Viewpoints/2_ChapterViewpoints.sysml`

- **패키지명**: `ChapterViewpoints`
- **역할 및 목적**: 파일 19에서 정의한 8개 관심사를 `frame concern` 문법으로 묶어 아키텍처를 바라보는 **5대 공식 관점(Viewpoints)**을 정의합니다.
- **주요 정의 및 구성요소**:
  1. `viewpoint 'administrative operations viewpoint'`: `OperationalFlowConcern`, `KnowledgeAssetConcern`, `LifecycleEvolutionConcern` 3개 관심사를 프레임(frame)하여 챕터 행정/운영/지식자산/성장 관점을 정의합니다.
  2. `viewpoint 'member value viewpoint'`: `StakeholderIdentificationConcern`, `ValueRationaleValidationConcern`, `RiskSecurityConcern` 3개 관심사를 프레임하여 회원 실질 가치 및 보안 관점을 정의합니다.
  3. `viewpoint 'incose alignment viewpoint'`: `BoundaryDependencyConcern`을 프레임하여 INCOSE 섹터 보고, TechOps 표준 도입, 툴 벤더 라이선스 관리 관점을 정의합니다.
  4. `viewpoint 'peer society connection viewpoint'`: `CapabilityValueConcern`을 프레임하여 KOSSE/KCOSE 등 타 학회와의 상호보완 및 챕터 고유 역량 관점을 정의합니다.
  5. `viewpoint 'governance and quality viewpoint'`: `GovernanceQualityConcern`을 프레임하여 LV3 거버넌스 규약, 품질 게이트 통과 여부 및 제출 상태 일관성 감사 관점을 정의합니다.

---

##### 파일 21. `2_ASELCM LV2_Chapter_Organization/5_Views_and_Viewpoints/3_ChapterViews.sysml`

- **패키지명**: `ChapterViews`
- **역할 및 목적**: 파일 20의 5대 Viewpoint를 `satisfy`하며 관련 모델 요소를 노출(`expose`)하는 **5개 기본 아키텍처 뷰(`view`)**와, `SysideViews::TableView`를 상속받아 실시간 모델 데이터를 표 형태로 모니터링하는 **4개 정형 대시보드 테이블 뷰**를 정의합니다.
- **주요 정의 및 구성요소**:
  - **기본 아키텍처 뷰 5종 (섹션 1)**:
    1. `AdministrativeOperationsView` (`satisfy 'administrative operations viewpoint'`): 저장소, 아티팩트, ConOps/Lifecycle, 스프린트, 워킹그룹, MoE, 회의록, 과제, 제출 트래커 전체 노출.
    2. `MemberValueView` (`satisfy 'member value viewpoint'`): 회원 정의, `chapterMemberRoster`, 회원별 Needs 및 SecurityRules 노출.
    3. `IncoseAlignmentView` (`satisfy 'incose alignment viewpoint'`): 툴 벤더, INCOSE 섹터, TechOps 액터 및 교환 아이템 노출.
    4. `PeerSocietyConnectionView` (`satisfy 'peer society connection viewpoint'`): 타 학회 액터/회원, 벤치마크 아이템, 챕터 3대 고유 역량 인스턴스 노출.
    5. `GovernanceQualityView` (`satisfy 'governance and quality viewpoint'`): LV3 거버넌스 시스템, 품질 게이트, 모델링 규약/정책, 제출 스키마 및 트래커 노출.
  - **Syside 정형 모니터링 테이블 뷰 4종 (섹션 2)**:

| 테이블 뷰 명칭 (`view ... : TableView`)   | 만족하는 Viewpoint                      | 노출 대상 (`expose`)                 | 렌더링 컬럼 구성 (`columnViews`)                                                                                                                                    |
| :---------------------------------------- | :-------------------------------------- | :----------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`MemberNeedsGtWRTableView`**            | `'member value viewpoint'`              | `ChapterMembers_Needs::*`            | `declaredName`(요구사항 ID), `coreValueWhat`(What), `rationale`(Why), `validationCriterion`(Validation)                                                             |
| **`ChapterCoreMoEsTableView`**            | `'administrative operations viewpoint'` | `incoseKoreaChapterContext::chapter` | `declaredName`, `accumulatedPresentationsCount`, `completedReferenceModelsCount`, `developedAISkillsCount`, `regularActiveMembersCount`, `sepCertifiedMembersCount` |
| **`AssignmentSubmissionStatusTableView`** | `'administrative operations viewpoint'` | `WG_Submissions_Tracker::*`          | `declaredName`(제출 ID), `workingGroup`(참조 WG), `status`(제출 상태)                                                                                               |
| **`AssignmentGateStatusTableView`**       | `'governance and quality viewpoint'`    | `WG_Submissions_Tracker::*`          | `declaredName`(제출 ID), `status`(제출 상태), `isGatePassed`(게이트 통합 통과 여부), `checklist`(상세 체크리스트)                                                   |

---
