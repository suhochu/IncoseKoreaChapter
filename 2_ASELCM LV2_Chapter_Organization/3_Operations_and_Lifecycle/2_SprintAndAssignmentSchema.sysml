package ChapterSprint {
    private import ScalarValues::*;
    private import Time::*;
    private import StakeholderDefinitions::*;
    private import ChapterSystemContext::*;
    private import ChapterConOpsAndLifecycle::ConOps::*;
    private import WorkingGroupsAndRoles::*;
    private import QualityGatesAndReviewProcess::*;

    // =========================================================================
    // 1. 스프린트, 격주 스프린트 및 킥오프 회의 공통 템플릿
    // =========================================================================
    enum def TaskCompletionKind {
        open; // 미착수
        inProgress; // 진행 중
        done; // 완료
    }

    item def Sprint {
        doc
        /* 스프린트 단위. Action Item과 과제는 문자열("Sprint 2") 대신 이 요소를 ref로 참조한다.
         * 새 스프린트는 분기별 회의록 패키지(SprintMeetings_YYYY_Qn)에 usage로 추가한다.
         */
        attribute sprintNo : Integer;
        attribute endDate : Iso8601DateTimeStructure; // 스프린트 마감일
    }

    action def ChapterSprintMeeting :> KnowledgeExchangeSession {
        attribute meetingDate : Iso8601DateTimeStructure;
        attribute location : String;
        ref attendees : IncoseKoreaChapterMember [1..*];
        attribute keyDecisions : String [0..*];

        // 회의록 산출물은 항상 '1. Meeting' 폴더에 저장된다(경로 문자열은 folder.relativePath 에서만 얻는다).
        out item :>> producedArtifact : ChapterArtifact {
            :>> category = ArtifactCategoryKind::meetingMinutes;
            ref :>> folder = incoseKoreaChapterContext.chapter.repository.folder1_Meeting;
        }
    }

    action def ActionItemTask {
        ref owner : IncoseKoreaChapterMember [1..*];
        attribute taskDescription : String;
        ref dueSprint : Sprint [0..1]; // 스프린트 마감이 기한이면 이 ref만 지정
        attribute dueDate : Iso8601DateTimeStructure [0..1] default dueSprint.endDate; // 스프린트와 무관한 기한만 재정의
        attribute isImmediate : Boolean default false; // 즉시 처리 항목이면 true (dueDate 없음)
        attribute completionStatus : TaskCompletionKind default TaskCompletionKind::open;
    }

    // =========================================================================
    // 2. SE 모델링 과제(Assignment), 학술자문단 피드백 및 제출물 관리 스키마
    // =========================================================================
    enum def SubmissionStatusKind {
        notStarted; // 착수 전
        inProgress; // 워킹그룹 모델링 진행 중
        underAcademicReview; // 학술자문단 리뷰 및 게이트 검증 중
        revisionRequired; // 학술자문단 피드백 반영 및 보완 필요
        approvedBaseline; // 게이트 통과 및 KnowledgeRepository 정식 등록 승인
    }

    // 학술자문단 피드백 레코드 정의
    item def AdvisoryFeedback {
        doc
        /* 학술자문단이 과제 및 모델에 대해 제시한 피드백과 해소 상태.
         * 피드백이 특정 회의에서 나왔다면 sourceMeeting만 지정하면 feedbackDate가 회의 일시에서 파생된다.
         */
        ref reviewers : IncoseKoreaChapterMember [1..*];
        ref action sourceMeeting : ChapterSprintMeeting [0..1];
        attribute feedbackDate : Iso8601DateTimeStructure [0..1] default sourceMeeting.meetingDate;
        attribute feedbackPoints : String [1..*];
        attribute isResolvedInModel : Boolean default false;
    }

    // SE 모델링 과제 마스터 정의 (ActionItemTask 확장)
    action def ModelingAssignment :> ActionItemTask {
        doc
        /* 각 스프린트 주기에 부여되는 시스템 엔지니어링 모델링 과제 템플릿.
         * 실무 가이드 문서, 필수 반영 체크포인트(Gate/Feedback constraint), 학술자문단 피드백을 통합 관리함.
         * 체크포인트 설명은 각 constraint def의 doc에만 있으며 여기서는 참조(ref)만 한다.
         */
        attribute assignmentNo : Integer [1..*];
        attribute stage : SEAssignmentStageKind [1..*];
        ref guideArtifact : ChapterArtifact [0..1]; // 참고 실무 가이드(PDF 등)
        attribute scaffoldPackageName : String [0..1]; // 상속해야 할 LV1 공통 스캐폴드 패키지명
        ref constraint mandatoryCheckpoints : AssignmentCheckpointRule [1..*]; // 과제 통과 필수 요건
        item advisoryFeedbacks : AdvisoryFeedback [0..*]; // 학술자문단 피드백 내역
        attribute startDate : Iso8601DateTimeStructure;
    }

    // 워킹그룹별 과제 제출물 및 품질 게이트 심사 결과 트래커
    item def AssignmentSubmission {
        doc
        /* 각 워킹그룹이 특정 과제(ModelingAssignment)에 대해 제출한 LV1 참조모델과
         * LV3 거버넌스 품질 게이트(학술자문단 피드백 + 실무 가이드 Gate) 통과 현황을 관리함.
         * 도메인, SoI, 저장 폴더, 소유자는 workingGroup 에서 파생하므로 제출 usage에는 다시 적지 않는다.
         */
        ref targetAssignment : ModelingAssignment;
        ref workingGroup : WorkingGroup;
        // 기본값은 WG 참여자. 제출자가 WG 참여자와 다를 때만 usage에서 재정의한다.
        ref submitters : IncoseKoreaChapterMember [1..*] default workingGroup.participants;
        attribute status : SubmissionStatusKind default SubmissionStatusKind::inProgress;

        // 게이트 입력 전체(Feedback + Gate 항목)를 하나의 체크리스트로 보관
        attribute checklist : AssignmentGateChecklist;

        // TODO(확인 필요): 속성 이름(checklist)이 constraint 파라미터 이름과 같아 'AssignmentSubmission::checklist' 로 한정했다.
        //   Syside Python API로 이 바인딩의 referent 가 AssignmentSubmission::checklist (자기 자신이 아님)임을 확인했다.
        //   실행 시 소유 인스턴스의 checklist로 해석되는지는 시뮬레이션 수준에서 추가 확인이 필요하다.
        constraint gateCheck : ReferenceModelAssignmentApprovalGate {
            in :>> checklist = AssignmentSubmission::checklist;
        }

        // TableView 표시용 파생 Boolean. 판정식은 gateCheck 한 곳에만 있다.
        // TODO(확인 필요): constraint usage는 Boolean에 직접 type-conform 하지 않아 '.result'로 참조했다(실행 의미 확인 필요).
        attribute isGatePassed : Boolean = gateCheck.result;

        item submittedModel : ReferenceModelArtifact {
            :>> domain = workingGroup.domain;
            :>> targetSoIName = workingGroup.targetSystemScope;
            :>> modelFilePath = workingGroup.targetSysmlPackagePath;
            ref :>> folder = workingGroup.targetFolder;
            ref :>> owner = workingGroup.participants;
            :>> isGateApproved = isGatePassed;
        }

        // 상태와 게이트 결과의 모순 방지: 승인된 Baseline이면 게이트를 반드시 통과해야 한다.
        assert constraint statusGateConsistency {
            status == SubmissionStatusKind::approvedBaseline implies isGatePassed
        }
    }
} // package ChapterSprint
