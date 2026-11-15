# 0_ASELCM_Integration

LV3(거버넌스)와 LV2(챕터 조직)를 함께 묶는 통합 패키지입니다.

- `ASELCM_SystemOfSystems.sysml`: `GovernanceSystemContext`와 `incoseKoreaChapterContext`를 포함하는 상위 part,
  `GovernanceInterfacePort` ↔ 켤레 포트 연결, `chapter`의 `perform action` / `exhibit state` 연결.
- 의존 방향: 이 패키지 → LV3, LV2. LV3는 LV2를 import하지 않고, LV2는 이 패키지를 import하지 않습니다(순환 금지).
- LV2와 LV3를 함께 참조해야 하는 요소는 이 폴더에만 추가합니다.

# 의존 구조도

0_ASELCM_Integration ASELCM_SystemOfSystems ──► LV3 GovernanceSystemAndTooling, LV2 ChapterSystemContext, ChapterConOpsAndLifecycle

LV2 → LV3 (단방향)
StakeholdersConcerns ──► GovernanceSystemAndTooling, ChapterSystemContext, ExternalActors, StakeholderDefinitions
WG_Submissions_Tracker ──► ModelingAssignments ──► SprintMeetings_2026_Q4 ──► ChapterSprint
ChapterSprint ──► WorkingGroupsAndRoles ──► ChapterSystemContext ──► ChapterMetricsAndGuards
ChapterSystemContext ──► ChapterMembersDirectory ──► StakeholderDefinitions
ChapterSystemContext, ChapterMetricsAndGuards, ChapterConOps, ChapterSprint, ChapterObjectives ──► QualityGatesAndReviewProcess, GovernanceInterfaces (LV3)

LV3: GovernanceSystemAndTooling ──► ModelingConventionsAndPolicies, QualityGatesAndReviewProcess (LV2 import 없음)
