#### [2-3] 운영 개념 및 수명주기 (`3_Operations_and_Lifecycle/`)

##### 파일 12. `2_ASELCM LV2_Chapter_Organization/3_Operations_and_Lifecycle/1_ChapterConOpsAndLifecycle.sysml`

- **패키지명**: `ChapterConOpsAndLifecycle`
- **역할 및 목적**: 챕터의 동적 운영 프로세스(`ConOps` 패키지 내 3대 Action Definition)와 챕터 조직의 3단계 성장 상태머신(`Lifecycle` 패키지 내 `ChapterLifecycle`)을 정의합니다.
- **주요 정의 및 구성요소**:
  - **하위 패키지 1: `ConOps` (3대 핵심 운영 프로세스)**
    1. `action def KnowledgeExchangeSession`: 온라인 지식 교환 모드(`mode`)와 외부 핸드북 리소스(`referenceResource`)를 입력받아 `present` -> `discuss` -> `archiveToKnowledgeStore` 순서로 수행하고 지식 자산(`producedArtifact : ChapterArtifact`)을 산출합니다.
    2. `action def ReferenceModelDevelopmentProcess`: Do-Tank의 핵심 파이프라인입니다.
       - 흐름: `issueAssignmentAndScaffold`(과제 가이드 및 스캐폴드 배포) -> `developDomainModelInWG`(워킹그룹별 도메인 모델 작성) -> `modelReview : ModelReviewProcess`(LV3의 검수·게이트 프로세스를 하위 액션으로 그대로 재사용) -> `baselineToKnowledgeRepository`(통과 모델을 `approvedReferenceModels`로 등록).
    3. `action def SectorReporting`: 내부 산출물(`internalData`)을 취합(`compileReport`)하여 아시아-오세아니아 섹터로 활동 보고서(`activityReport : SectorActivityReportItem`)를 전송(`sendToSector`)합니다.
  - **하위 패키지 2: `Lifecycle` (챕터 성장 상태머신)**
    - `state def ChapterLifecycle`: `in ref metrics : ChapterMoEsHolder`를 입력받아 3단계 상태 전이를 수행합니다:
      - **Phase 1 (`onlineStudyPhase`)**: 온라인 스터디 및 도메인별 LV1 참조모델 초기 개발 단계 (진입 기본 상태).
      - **전이 `phase1To2`**: `accept when metrics.isPhase1To2Ready` 만족 시 Phase 2로 전이.
      - **Phase 2 (`sponsorshipAndOfflineSeminarPhase`)**: 기업 스폰서 확보 및 오프라인 세미나 정례화 단계 (Sponsor, PeerSociety 연결 활성화).
      - **전이 `phase2To3`**: `accept when metrics.isPhase2To3Ready` 만족 시 Phase 3로 전이.
      - **Phase 3 (`officialWorkingGroupPhase`)**: INCOSE 본부 공식 워킹그룹(WG) 발족 및 자체 아키텍트 인증 프로그램 운영 단계.

---

##### 파일 13. `2_ASELCM LV2_Chapter_Organization/3_Operations_and_Lifecycle/2_SprintAndAssignmentSchema.sysml`

- **패키지명**: `ChapterSprint`
- **역할 및 목적**: 격주 스프린트 일정(`Sprint`), 스프린트 회의(`ChapterSprintMeeting`), 단기 실행 과제(`ActionItemTask`), SE 모델링 과제(`ModelingAssignment`), 학술자문단 피드백(`AdvisoryFeedback`), 그리고 워킹그룹 과제 제출물(`AssignmentSubmission`)의 **공통 데이터 스키마(Definition)**를 정의합니다.
- **주요 정의 및 구성요소**:
  - **스프린트 및 회의 스키마 (섹션 1)**:
    - `item def Sprint`: 스프린트 번호(`sprintNo`)와 마감일(`endDate : Iso8601DateTimeStructure`)을 보유하여 Action Item이 문자열 대신 객체 참조(`ref dueSprint`)로 기한을 자동 상속받게 합니다.
    - `action def ChapterSprintMeeting :> KnowledgeExchangeSession`: 회의 일시(`meetingDate`), 장소(`location`), 참석자(`ref attendees`), 주요 결정사항(`keyDecisions`)을 기록하며, 산출물(`producedArtifact`)의 카테고리를 `meetingMinutes`로, 저장 폴더를 `folder1_Meeting`으로 자동 고정합니다.
    - `action def ActionItemTask`: 담당자(`owner`), 설명(`taskDescription`), 목표 스프린트(`dueSprint`), 자동 파생 마감일(`dueDate default dueSprint.endDate`), 즉시 처리 여부(`isImmediate`), 완료 상태(`completionStatus : TaskCompletionKind`).
  - **SE 과제, 자문단 피드백 및 제출 트래커 스키마 (섹션 2)**:
    - `enum def SubmissionStatusKind`: `notStarted` -> `inProgress` -> `underAcademicReview` -> `revisionRequired` -> `approvedBaseline`.
    - `item def AdvisoryFeedback`: 리뷰어(`reviewers`), 출처 회의(`ref action sourceMeeting`), 자동 파생 피드백 일자(`feedbackDate default sourceMeeting.meetingDate`), 피드백 항목(`feedbackPoints`), 모델 반영 여부(`isResolvedInModel`).
    - `action def ModelingAssignment :> ActionItemTask`: 과제 번호(`assignmentNo`), 단계(`stage`), 실무 가이드(`guideArtifact`), 스캐폴드 패키지명(`scaffoldPackageName`), 필수 체크포인트 제약 참조(`ref constraint mandatoryCheckpoints : AssignmentCheckpointRule [1..*]`), 자문단 피드백 목록(`advisoryFeedbacks`).
    - `item def AssignmentSubmission`:
      - 대상 과제(`targetAssignment`)와 제출 워킹그룹(`workingGroup`)만 지정하면, 제출자(`submitters`), 도메인(`domain`), 대상 시스템명(`targetSoIName`), 패키지 경로(`modelFilePath`), 저장 폴더(`folder`), 소유자(`owner`)가 모두 `workingGroup`으로부터 자동 파생됩니다.
      - 내부 제약 `gateCheck : ReferenceModelAssignmentApprovalGate`를 통해 `isGatePassed`를 평가하며, **`assert constraint statusGateConsistency`**(`status == SubmissionStatusKind::approvedBaseline implies isGatePassed`)를 통해 게이트 미통과 모델이 `approvedBaseline` 상태로 둔갑하는 모순을 강제로 차단합니다.

---
