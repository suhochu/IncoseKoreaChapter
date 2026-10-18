package ChapterSprint {
    private import ChapterMembers::*;
    private import Time::*;
    private import Chapter_Behavior::ConOps::*;
    private import SystemContext::*;
    private import ScalarValues::*;

    // SE 모델링 과제 단계 정의
    enum def SEAssignmentStageKind {
        Stage1_SoIAndQuestionSelection; // 과제 1: 대상시스템(SoI) 및 Engineering Question 선정
        Stage2_BlackBoxAndConOps; // 과제 2: 블랙박스 정의, 임무/MOE 및 5-Tuple ConOps
        Stage3_LogicalArchitecture; // 과제 3: 화이트박스 논리 아키텍처 및 기능 할당
        Stage4_PhysicalAndVnv; // 과제 4: 물리 아키텍처 및 요구사항 검증(V&V)/시뮬레이션
    }

    enum def SubmissionStatusKind {
        notStarted;
        inProgress;
        underReview; // 교수님/자문단 피드백 대기
        revisionRequired; // 피드백 반영 및 Gate 재검증 필요
        approvedBaseline; // KnowledgeRepository 정식 등록 승인
    }

    // [신규] 학술자문단(교수님) 피드백 구조체
    item def AdvisoryFeedback {
        ref reviewer : IncoseKoreaChapterMember [1..*]; // 예: 이중윤 교수, 서은석 교수
        attribute feedbackItems : String [1..*]; // 피드백 상세 내용
        attribute isResolved : Boolean default false; // 모델 반영 완료 여부
    }

    // [신규] 모델링 과제 마스터 템플릿 (가이드 문서 및 필수 체크리스트 관리)
    action def ModelingAssignment :> ActionItemTask {
        attribute assignmentNo : Integer;
        attribute stage : SEAssignmentStageKind;
        attribute guideDocumentURL : String [0..1]; // 과제 실무 가이드 PDF 링크
        attribute mandatoryCheckpoints : String [1..*]; // 필수 반영 기준 (교수님 피드백 + 6대 Gate)
        part feedbackHistory : AdvisoryFeedback [0..*]; // 과제 공통 교수님 피드백
    }

    // [신규] 워킹그룹 또는 개별 회원의 과제 제출물 관리
    item def AssignmentSubmission {
        ref targetAssignment : ModelingAssignment;
        ref submitter : IncoseKoreaChapterMember [1..*];
        ref producedModelArtifact : ReferenceModelArtifact; // SystemContext에 정의될 모델 산출물
        attribute status : SubmissionStatusKind default SubmissionStatusKind::inProgress;

        // 가이드 7장 6대 자체 감사 게이트 및 교수님 피드백 통과 여부
        attribute passGate1_WholeSystem : Boolean default false;
        attribute passGate2_BlackBox : Boolean default false;
        attribute passGate3_TimeframeAssumption : Boolean default false;
        attribute passGate4_ODDGrouping : Boolean default false;
        attribute passGate5_ThreeExternalScopes : Boolean default false;
        attribute passGate6_NoIsolatedActor : Boolean default false;
        attribute passMOEQuantification : Boolean default false; // 목표값/한계값/단위 명시 여부
    }

    // 격주 스프린트 및 킥오프 회의의 공통 템플릿 정의
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
} // package ChapterSprint
