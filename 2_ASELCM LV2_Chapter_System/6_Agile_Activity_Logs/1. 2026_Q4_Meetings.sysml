package ChapterActivityLogs_2026_Q4 {
    private import ScalarValues::*;
    private import Time::*;
    private import ChapterMembers::*;
    private import SystemContext::*;
    private import ChapterBehavior::ConOps::*;
    private import ChapterSprint::*;

    // =========================================================================
    // 1. [실제 인스턴스] 2026-10-09 킥오프 미팅 Usage
    // =========================================================================
    action kickOffMeeting_20261009 : ChapterSprintMeeting {
        in :>> mode = ExchangeModeKind::handsOnLabStyle;

        attribute :>> meetingDate : Iso8601DateTimeStructure {
            :>> year = 2026;
            :>> month = 10;
            :>> day = 9;
            :>> hour = 18;
            :>> minute = 0;
            :>> second = 0;
            :>> hourOffset = 9; // KST 시차 (UTC+9)
            :>> minuteOffset = 0;
        }
        :>> location = "사당역 주변 셀스스토리 8인 회의실 / 우담정";

        // 문자열이 아니라 ChapterMembers에 정의된 실제 회원 Part들을 참조!
        ref :>> attendees = (
            ChapterMembers::'이중윤', ChapterMembers::'서은석', ChapterMembers::'추수호',
            ChapterMembers::'최성열', ChapterMembers::'이수', ChapterMembers::'박홍석',
        );

        :>> keyDecisions = (
            "싱크탱크(Think-Tank)가 아닌 실제 산출물을 만드는 도탱크(Do-Tank) 지향",
            "자동차는 SDV 비히클 전체, 우주는 임무 시스템 전체를 대상으로 Operational Stakeholder Requirement부터 하향식 모델링",
            "기업 내부 민감 데이터 문서화 금지, AI 및 공개 데이터를 기반으로 3개월 단위 레고 블록 모델링 수행",
            "공식 소통은 카카오톡, 저장소는 Google Workspace 및 GitHub, 격주(2주) 웹 미팅 및 분기(3개월) 오프라인 모임 진행",
        );

        out item :>> producedArtifact : ChapterArtifact {
            :>> title = "INCOSE Korea KickOff Meeting (20261009) - 회의록";
            :>> category = ArtifactCategoryKind::meetingMinutes;
            :>> owner = "추수호";
            :>> locationURL =
                "https://drive.google.com/drive/folders/1Ngr1SpzuJ0gaTZlJnZlnFDw20FWqY_7T?usp=drive_link";
        }

        // 후속 액션 아이템 인스턴스
        action ai1_setupChannels : ActionItemTask {
            ref :>> owner = ChapterMembers::'추수호';
            :>> taskDescription =
                "카카오톡 단체방 개설 및 미참석 3명 동의 후 초대, 구글 워크스페이스 및 GitHub 세팅";
            :>> dueDate = "Immediate";
        }
        action ai2_selectTargetSoI : ActionItemTask {
            ref :>> owner = (
                ChapterMembers::'추수호', ChapterMembers::'최성열', ChapterMembers::'이수',
                ChapterMembers::'박홍석',
            );
            :>> taskDescription =
                "각자 모델링할 대상 시스템(Engineering Question & SoI) 선정 및 1차 웹 미팅 발표 준비";
            :>> dueDate = "2026-10-23 (Sprint 1)";
        }
    }

    // =========================================================================
    // 2. SE 블랙박스 정의 및 운용시나리오(ConOps) 개발 과제 실무 가이드 아티팩트 및 교수님 피드백 반영 과제 정의
    // =========================================================================
    item blackBoxConOpsGuide_PDF : ChapterArtifact {
        :>> title = "SE 블랙박스 정의 및 운용시나리오(ConOps) 개발 실무 가이드";
        :>> category = ArtifactCategoryKind::assignmentGuide;
        :>> owner = "추수호 / 학술자문단";
        :>> locationURL =
            "https://drive.google.com/file/d/1QX67QduPw5aJVv79QpfobkCHERMwHphw/view?usp=drive_link";
    }

    action assignment2_BlackBoxAndConOps : ModelingAssignment {
        :>> assignmentNo = 2;
        :>> stage = SEAssignmentStageKind::Stage2_BlackBoxAndConOps;
        ref :>> guideArtifact = blackBoxConOpsGuide_PDF;
        :>> scaffoldPackageName = "LV1_BlackBox_ConOps_Scaffold";

        ref :>> owner = (
            ChapterMembers::'추수호', ChapterMembers::'최성열', ChapterMembers::'구정모',
            ChapterMembers::'이수', ChapterMembers::'박승훈', ChapterMembers::'김다운',
            ChapterMembers::'박홍석',
        );
        :>> taskDescription =
            "LV1_BlackBox_ConOps_Scaffold를 상속받아 워킹그룹별 대상시스템(SoI)의 임무/MOE, 운용시점 인프라 가정, 3대 외부환경 컨텍스트 및 5-Tuple 블랙박스 ConOps 시나리오 작성";
        :>> dueDate = "2026-Q4 Sprint 2";

        :>> mandatoryCheckpoints = (
            "1. [교수님 피드백 1] 운용 개념(ConOps)이 대상시스템의 존재목적(임무 또는 사업목표)을 달성하는 모습을 표현하고 satisfy 관계로 연결할 것",
            "2. [교수님 피드백 2] 임무/사업 목표 서술(What/Why) 및 달성 판정용 운용효과성측정지표(MOE) 정의 시 목표값(Target)/한계값(Threshold)/단위(Unit)를 지정할 것",
            "3. [교수님 피드백 3] 운용 시점의 인프라 가정을 명시하고, 블랙박스 SoI가 외부 환경(조직/물리/자연)과 상호작용하는 것에 초점을 두고 시나리오를 작성할 것",
            "4. [실무 가이드 6대 Gate] Whole-System(Gate 1), Solution-Free 블랙박스(Gate 2), 시점 4대 전제 연계(Gate 3), ODD 3대 장소 그룹핑(Gate 4), 3대 외부 범위 각 2개 이상 및 외란 아이템화(Gate 5), 고립 액터 방지(Gate 6) 준수",
        );

        // 교수님 피드백 정식 레코드
        part profFeedback_202610 : AdvisoryFeedback :> advisoryFeedbacks {
            ref :>> reviewers = (ChapterMembers::'이중윤', ChapterMembers::'서은석',);
            :>> feedbackDate = "2026-10";
            :>> feedbackPoints = (
                "1. 운용 개념은 대상시스템의 존재목적(임무 또는 사업목표)을 달성하는 모습을 표현해야 함.",
                "2. 임무/사업 목표에 대한 서술 및 달성 여부에 대한 운용효과성측정지표(MOE) 정의 및 목표값/한계값/단위 지정 (수치 자체는 정확할 필요 없음).",
                "3. 운용 시나리오 작성 시 블랙박스 개념 강조 -> 블랙박스 대상시스템이 외부 환경과 상호작용하는 것에 초점을 두고 운용 시나리오 작성 (이 외부 환경에 대한 가정은 운용 시점의 인프라에 대한 가정임).",
            );
            :>> isResolvedInModel = false;
        }
    }

    // =========================================================================
    // 3. 워킹그룹별 SE 블랙박스 정의 및 운용시나리오(ConOps) 개발 과제 제출물 트래킹 슬롯
    // =========================================================================

    // 아래는 Example 인스턴스들
    item automotiveWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment2_BlackBoxAndConOps;
        :>> workingGroupName = "Automotive SDV Working Group";
        ref :>> submitters = (ChapterMembers::'추수호', ChapterMembers::'최성열',);
        :>> status = SubmissionStatusKind::inProgress;

        part :>> submittedModel : ReferenceModelArtifact {
            :>> title = "Automotive SDV Black-Box & ConOps Reference Model";
            :>> owner = "Automotive SDV WG";
            :>> locationURL = "3_ASELCM_LV1_Target_Reference_Models/1_Automotive_SDV_WG/";
            :>> domainName = "Automotive & Smart Mobility";
            :>> targetSoIName = "TBD (Whole-System SDV / Autonomous Mobility System)";
            :>> modelVersion = "v0.1-Draft";
            :>> inheritsCommonScaffold = true;
            :>> isSecurityCleared = true;
            :>> isGateApproved = false;
        }
    }

    item spaceWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment2_BlackBoxAndConOps;
        :>> workingGroupName = "Space Mission System Working Group";
        ref :>> submitters = (
            ChapterMembers::'이수', ChapterMembers::'박승훈', ChapterMembers::'김다운',
        );
        :>> status = SubmissionStatusKind::inProgress;

        part :>> submittedModel : ReferenceModelArtifact {
            :>> title = "Space Mission System Black-Box & ConOps Reference Model";
            :>> owner = "Space Mission WG";
            :>> locationURL = "3_ASELCM_LV1_Target_Reference_Models/2_Space_Mission_WG/";
            :>> domainName = "Defense & Aerospace";
            :>> targetSoIName = "TBD (Whole-System Orbital Transport / Exploration Mission System)";
            :>> modelVersion = "v0.1-Draft";
            :>> inheritsCommonScaffold = true;
            :>> isSecurityCleared = true;
            :>> isGateApproved = false;
        }
    }
} // package ChapterActivityLogs_2026_Q4
