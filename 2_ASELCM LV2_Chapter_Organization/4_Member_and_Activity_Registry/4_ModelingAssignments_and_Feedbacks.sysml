package ModelingAssignments_and_Feedbacks {
    doc
    /* [5. Architecture Methodologies & 6. Projects/2. references 매핑]
     * SE 모델링 과제 마스터 정의, 실무 가이드 아티팩트 및 학술자문단(교수진) 피드백 레코드 관리
     */
    private import ScalarValues::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;
    private import ChapterSprint::*;

    // =========================================================================
    // 1. 실무 가이드 및 방법론 레퍼런스 아티팩트
    // =========================================================================
    item blackBoxConOpsGuide_PDF : ChapterArtifact {
        :>> title = "SE 블랙박스 정의 및 운용시나리오(ConOps) 개발 실무 가이드";
        :>> category = ArtifactCategoryKind::assignmentGuide;
        :>> owner = "추수호 / 학술자문단";
        :>> repoFolderPath = "6. Projects/2. references";
        :>> locationURL =
            "https://drive.google.com/file/d/1QX67QduPw5aJVv79QpfobkCHERMwHphw/view?usp=drive_link";
    }

    item pestelAndMbseCookbook_Source : ChapterArtifact {
        :>> title = "PESTEL-CTIMMRA 분석 템플릿, DoDAF 2.02 가이드 및 MBSE 쿡북 리소스";
        :>> category = ArtifactCategoryKind::methodologyReference;
        :>> owner = "이중윤 / 추수호";
        :>> repoFolderPath = "7. Source";
        :>> locationURL = "7. Source/";
    }

    // =========================================================================
    // 2. 과제 2: 블랙박스 정의 및 운용시나리오(ConOps) 개발 마스터 정의
    // =========================================================================
    action assignment1_2_BlackBoxAndConOps : ModelingAssignment {
        :>> assignmentNo = (1, 2);
        :>> stage = (
            SEAssignmentStageKind::Stage1_SoIAndQuestionSelection,
            SEAssignmentStageKind::Stage2_BlackBoxAndConOps
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
            ChapterMembersDirectory::'추수호', ChapterMembersDirectory::'최성열',
            ChapterMembersDirectory::'구정모', ChapterMembersDirectory::'이수',
            ChapterMembersDirectory::'박승훈', ChapterMembersDirectory::'김다운',
            ChapterMembersDirectory::'박홍석', ChapterMembersDirectory::'김희재',
            ChapterMembersDirectory::'최지원'
        );
        :>> taskDescription =
            "2035년 목표 시점 및 DoDAF 2.02(AV-1, AV-2, OV-1, OV-5b) 구조와 LV1_BlackBox_ConOps_Scaffold를 결합하여 워킹그룹별 대상시스템(SoI)의 임무/MOE 계층, PESTEL-CTIMMRA 운용시점 인프라 가정, 3대 외부환경 컨텍스트 및 5-Tuple 블랙박스 ConOps(Nominal/최악 조건) 작성";
        :>> dueDate = "2026-11-13 (Sprint 2)";

        :>> mandatoryCheckpoints = (
            "1. [교수님 피드백 1] 운용 개념(ConOps)이 대상시스템의 존재목적(임무 또는 사업목표)을 달성하는 모습을 표현하고 satisfy 관계로 연결할 것",
            "2. [교수님 피드백 2] 임무/사업 목표 서술(What/Why) 및 달성 판정용 운용효과성측정지표(MOE)를 고객/임무/공장 효과 중심의 계층 구조로 정의하고 목표값(Target)/한계값(Threshold)/단위(Unit)를 지정할 것",
            "3. [교수님 피드백 3] 2035년 운용 시점의 PESTEL-CTIMMRA 인프라 가정을 명시하고, 블랙박스 SoI가 외부 환경(조직/물리/자연)과 상호작용하는 것에 초점을 두고 시나리오를 작성할 것",
            "4. [실무 가이드 6대 Gate] Whole-System(Gate 1), Solution-Free 블랙박스(Gate 2), 시점 4대 전제 연계(Gate 3), ODD 3대 장소 그룹핑(Gate 4), 3대 외부 범위 각 2개 이상 및 외란 아이템화(Gate 5), 고립 액터 방지(Gate 6) 준수"
        );

        // 학술자문단(교수진) 1차·2차 피드백 레코드 분리 관리
        part profFeedback_1_KickOff : AdvisoryFeedback :> advisoryFeedbacks {
            ref :>> reviewers = ChapterMembersDirectory::'이중윤';
            :>> feedbackDate = "2026-10-09";
            :>> feedbackPoints = (
                "1. 운용 개념은 대상시스템의 존재목적(임무 또는 사업목표)을 달성하는 모습을 표현해야 함.",
                "2. 임무/사업 목표에 대한 서술 및 달성 여부에 대한 운용효과성측정지표(MOE) 정의 및 목표값/한계값/단위 지정 (수치 자체는 정확할 필요 없음).",
                "3. 운용 시나리오 작성 시 블랙박스 개념 강조 -> 블랙박스 대상시스템이 외부 환경과 상호작용하는 것에 초점을 두고 운용 시나리오 작성 (이 외부 환경에 대한 가정은 운용 시점의 인프라에 대한 가정임)."
            );
            :>> isResolvedInModel = false;
        }

        part profFeedback_2_OnlineSprint1 : AdvisoryFeedback :> advisoryFeedbacks {
            ref :>> reviewers = ChapterMembersDirectory::'이중윤';
            :>> feedbackDate = "2026-10-30";
            :>> feedbackPoints = (
                "1. 2035년 장기 시점 기준으로 전 워킹그룹의 AV-1, AV-2, OV-1 목차 구조를 통일하고 PESTEL-CTIMMRA 맥락 분석을 반영할 것.",
                "2. 다목적 시스템(드론 등)은 임무별(감시정찰/공격/보급)로 운영 맥락과 OV-1(정상/최악 조건)을 독립 분리할 것.",
                "3. MOE는 시스템 내부 성능이 아닌 상위 임무 성공률, 사용자 와우 포인트(Wow Point), 수요처 공장 수율/품질 등 상위 효과성에서 출발해 측정 가능한 말단 지표로 계층화할 것.",
                "4. 반도체 장비 등 하위 시스템 성격의 경우 내부 인터록/기능보다 Level 0 상위 공정 컨텍스트와 납품 공장별 베리에이션(Variation)부터 하향식으로 정의할 것."
            );
            :>> isResolvedInModel = false;
        }
    }
} // package ModelingAssignments_and_Feedbacks
