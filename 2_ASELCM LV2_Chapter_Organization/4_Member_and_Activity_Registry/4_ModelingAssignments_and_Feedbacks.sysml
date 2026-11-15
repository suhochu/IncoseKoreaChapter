package ModelingAssignments_and_Feedbacks {
    doc
    /* [5. Architecture Methodologies & 6. Projects/2. references 매핑]
     * SE 모델링 과제 마스터 정의, 실무 가이드 아티팩트 및 학술자문단 피드백 레코드 관리.
     * 새 과제는 'action <이름> : ModelingAssignment' usage 1개를 추가하고
     * 필수 체크포인트는 constraint def를 ref로 참조한다(설명 문자열 금지).
     */
    private import ScalarValues::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;
    private import ChapterSprint::*;
    private import SprintMeetings_2026_Q4::*;
    private import WorkingGroupsAndRoles::*;
    private import QualityGatesAndReviewProcess::*;

    // =========================================================================
    // 1. 실무 가이드 및 방법론 레퍼런스 아티팩트
    // =========================================================================
    item blackBoxConOpsGuide_PDF : ChapterArtifact {
        :>> title = "SE 블랙박스 정의 및 운용시나리오(ConOps) 개발 실무 가이드";
        :>> category = ArtifactCategoryKind::assignmentGuide;
        ref :>> owner = ('추수호', chapterOrganization.academicAdvisors.assignee);
        ref :>> folder = incoseKoreaChapterContext.chapter.repository.folder6_Projects.sub2_References;
        :>> locationURL =
            "https://drive.google.com/file/d/1QX67QduPw5aJVv79QpfobkCHERMwHphw/view?usp=drive_link";
    }

    item pestelAndMbseCookbook_Source : ChapterArtifact {
        :>> title = "PESTEL-CTIMMRA 분석 템플릿, DoDAF 2.02 가이드 및 MBSE 쿡북 리소스";
        :>> category = ArtifactCategoryKind::methodologyReference;
        ref :>> owner = ('이중윤', '추수호',);
        ref :>> folder = incoseKoreaChapterContext.chapter.repository.folder7_Source;
    }

    // =========================================================================
    // 2. 과제 1·2: 대상시스템 선정, 블랙박스 정의 및 운용시나리오(ConOps) 개발 마스터 정의
    // =========================================================================
    action assignment1_2_BlackBoxAndConOps : ModelingAssignment {
        :>> assignmentNo = (1, 2);
        :>> stage = (
            SEAssignmentStageKind::stage1_SoIAndQuestionSelection,
            SEAssignmentStageKind::stage2_BlackBoxAndConOps
        );
        :>> startDate {
            :>> year = 2026;
            :>> month = 10;
            :>> day = 10;
            :>> hour = 20;
        }
        ref :>> guideArtifact = blackBoxConOpsGuide_PDF;
        :>> scaffoldPackageName = "LV1_BlackBox_ConOps_Scaffold";

        ref :>> owner = (
            '추수호', '최성열', '구정모', '이수', '박승훈', '김다운', '박홍석', '김희재', '최지원'
        );
        :>> taskDescription =
            "2035년 목표 시점 및 DoDAF 2.02(AV-1, AV-2, OV-1, OV-5b) 구조와 LV1_BlackBox_ConOps_Scaffold를 결합하여 워킹그룹별 대상시스템(SoI)의 임무/MOE 계층, PESTEL-CTIMMRA 운용시점 인프라 가정, 외부환경 컨텍스트 및 5-Tuple 블랙박스 ConOps(Nominal/최악 조건) 작성";
        ref :>> dueSprint = sprint2;

        // 통과 필수 요건: 설명 문자열 대신 constraint def 참조 (기준 설명은 constraint def의 doc에만 있다).
        // 통합 승인 게이트는 학술자문단 피드백 1~3 및 가이드 Gate 1~6 constraint를 모두 포함한다.
        ref constraint cp_approvalGate : ReferenceModelAssignmentApprovalGate :> mandatoryCheckpoints;

        // 학술자문단 1차·2차 피드백 레코드 분리 관리 (feedbackDate는 sourceMeeting 일시에서 파생)
        item profFeedback_1_KickOff : AdvisoryFeedback :> advisoryFeedbacks {
            ref :>> reviewers = '이중윤';
            ref :>> sourceMeeting = kickOffMeeting_20261009;
            :>> feedbackPoints = (
                "1. 운용 개념은 대상시스템의 존재목적(임무 또는 사업목표)을 달성하는 모습을 표현해야 함.",
                "2. 임무/사업 목표에 대한 서술 및 달성 여부에 대한 운용효과성측정지표(MOE) 정의 및 목표값/한계값/단위 지정 (수치 자체는 정확할 필요 없음).",
                "3. 운용 시나리오 작성 시 블랙박스 개념 강조 -> 블랙박스 대상시스템이 외부 환경과 상호작용하는 것에 초점을 두고 운용 시나리오 작성 (이 외부 환경에 대한 가정은 운용 시점의 인프라에 대한 가정임)."
            );
        }

        item profFeedback_2_OnlineSprint1 : AdvisoryFeedback :> advisoryFeedbacks {
            ref :>> reviewers = '이중윤';
            ref :>> sourceMeeting = onlineMeeting1_20261030;
            :>> feedbackPoints = (
                "1. 2035년 장기 시점 기준으로 전 워킹그룹의 AV-1, AV-2, OV-1 목차 구조를 통일하고 PESTEL-CTIMMRA 맥락 분석을 반영할 것.",
                "2. 다목적 시스템(드론 등)은 임무별(감시정찰/공격/보급)로 운영 맥락과 OV-1(정상/최악 조건)을 독립 분리할 것.",
                "3. MOE는 시스템 내부 성능이 아닌 상위 임무 성공률, 사용자 와우 포인트(Wow Point), 수요처 공장 수율/품질 등 상위 효과성에서 출발해 측정 가능한 말단 지표로 계층화할 것.",
                "4. 반도체 장비 등 하위 시스템 성격의 경우 내부 인터록/기능보다 Level 0 상위 공정 컨텍스트와 납품 공장별 베리에이션(Variation)부터 하향식으로 정의할 것."
            );
        }
    }
} // package ModelingAssignments_and_Feedbacks
