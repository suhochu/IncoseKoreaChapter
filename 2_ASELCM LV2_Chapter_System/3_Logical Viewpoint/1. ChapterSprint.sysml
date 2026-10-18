package ChapterSprint {
    private import ChapterMembers::*;
    private import Time::*;
    private import ChapterBehavior::ConOps::*;
    private import SystemContext::*;
    private import INCOSE_Korea_Chapter_Governance::QualityAssurance::*;
    private import ScalarValues::*;

    // =========================================================================
    // 1. 격주 스프린트 및 킥오프 회의 공통 템플릿
    // =========================================================================
    action def ChapterSprintMeeting :> KnowledgeExchangeSession {
        attribute meetingDate : Iso8601DateTimeStructure;
        attribute location : String;
        ref attendees : IncoseKoreaChapterMember [1..*];
        attribute keyDecisions : String [0..*];
    }

    action def ActionItemTask {
        ref owner : IncoseKoreaChapterMember [1..*];
        attribute taskDescription : String;
        attribute dueDate : String;
    }

    // =========================================================================
    // 2. [신규] SE 모델링 과제(Assignment), 교수님 피드백 및 제출물 관리 스키마
    // =========================================================================
    enum def SEAssignmentStageKind {
        Stage1_SoIAndQuestionSelection; // 과제 1: 대상시스템(SoI) 및 Engineering Question 선정
        Stage2_BlackBoxAndConOps; // 과제 2: 블랙박스 정의, 임무/MOE 설정 및 5-Tuple ConOps 시나리오
        Stage3_LogicalArchitecture; // 과제 3: 화이트박스 논리 아키텍처 및 기능 분해/할당
        Stage4_PhysicalAndSimulation; // 과제 4: 물리 아키텍처, 요구사항 추적성 및 시뮬레이션 검증(V&V)
    }

    enum def SubmissionStatusKind {
        notStarted; // 착수 전
        inProgress; // 워킹그룹 모델링 진행 중
        underAcademicReview; // 학술자문단(교수진) 리뷰 및 게이트 검증 중
        revisionRequired; // 교수님 피드백 반영 및 보완 필요
        approvedBaseline; // 6대 Gate 통과 및 KnowledgeRepository 정식 등록 승인
    }

    // 학술자문단(교수진) 피드백 레코드 정의
    item def AdvisoryFeedback {
        doc
        /* 이중윤·서은석 교수님 등 학술자문단이 과제 및 모델에 대해 제시한 피드백과 해소 상태 */
        ref reviewers : IncoseKoreaChapterMember [1..*];
        attribute feedbackDate : String [0..1];
        attribute feedbackPoints : String [1..*];
        attribute isResolvedInModel : Boolean default false;
    }

    // SE 모델링 과제 마스터 정의 (ActionItemTask 확장)
    action def ModelingAssignment :> ActionItemTask {
        doc
        /* 각 스프린트 주기에 부여되는 시스템 엔지니어링 모델링 과제 템플릿.
         * 실무 가이드 문서, 필수 반영 체크포인트, 그리고 교수님 피드백을 통합 관리함.
         */
        attribute assignmentNo : Integer;
        attribute stage : SEAssignmentStageKind;
        ref guideArtifact : ChapterArtifact [0..1]; // 참고 실무 가이드(PDF 등)
        attribute scaffoldPackageName : String [0..1]; // 상속해야 할 LV1 공통 스캐폴드 패키지명
        attribute mandatoryCheckpoints : String [1..*]; // 과제 통과 필수 요건 목록
        part advisoryFeedbacks : AdvisoryFeedback [0..*]; // 교수님 피드백 내역
    }

    // 워킹그룹/회원별 과제 제출물 및 품질 게이트 심사 결과 트래커
    item def AssignmentSubmission {
        doc
        /* 각 워킹그룹이 특정 과제(ModelingAssignment)에 대해 제출한 LV1 참조모델과
         * LV3 거버넌스 품질 게이트(교수님 피드백 3종 + 실무 가이드 6대 Gate) 통과 현황을 관리함.
         */
        ref targetAssignment : ModelingAssignment;
        attribute workingGroupName : String;
        ref submitters : IncoseKoreaChapterMember [1..*];
        part submittedModel : ReferenceModelArtifact;
        attribute status : SubmissionStatusKind default SubmissionStatusKind::inProgress;

        // 교수님 피드백 3대 원칙 및 가이드 6대 Gate 충족 여부 체크리스트
        attribute passFeedback1_MissionConOps : Boolean default false; // 존재목적(임무/사업목표) 달성 표현 여부
        attribute passFeedback2_MOEQuantified : Boolean default false; // MOE 목표값/한계값/단위 지정 여부
        attribute passFeedback3_BlackBoxInfra : Boolean default false; // 운용시점 인프라 가정 기반 외부 상호작용 여부
        attribute passGate1_WholeSystem : Boolean default false; // 독립 임무 완결 단위(Whole-System) 여부
        attribute passGate2_SolutionFreeBlackBox : Boolean default false; // 내부 HW/SW 구현 배제 여부
        attribute passGate3_TimeframeLinked : Boolean default false; // 운용 시점 4대 전제 조건 반영 여부
        attribute passGate4_ODDThreeGroups : Boolean default false; // 장소 그룹(공칭/복합/극한) 추상화 여부
        attribute passGate5_ThreeExternalScopes : Boolean default false; // 조직/물리/자연 각 2개 이상 및 외란 아이템화 여부
        attribute passGate6_NoIsolatedActor : Boolean default false; // 모든 외부 액터의 시나리오 최소 1회 등장 여부
    }
} // package ChapterSprint
