package ChapterActivityLogs_2026_Q4 {
    private import ScalarValues::*;
    private import Time::*;
    private import ChapterMembers::*;
    private import SystemContext::*;
    private import ChapterBehavior::ConOps::*;
    private import ChapterSprint::*;

    // [실제 인스턴스] 2026-10-09 킥오프 미팅 Usage (def가 아님!)
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

    action assignment2_BlackBoxAndConOps : ModelingAssignment {
        :>> assignmentNo = 2;
        :>> stage = SEAssignmentStageKind::Stage2_BlackBoxAndConOps;
        :>> taskDescription =
            "LV1 대상시스템(SoI) 블랙박스 정의, 임무/MOE 설정 및 5-Tuple 운용 시나리오(ConOps) 모델링";
        :>> dueDate = "2026-Q4 Sprint 2";
        :>> mandatoryCheckpoints = (
            "[피드백 1] 운용 개념(ConOps)은 대상시스템의 존재목적(임무/사업목표)을 달성하는 모습을 표현할 것",
            "[피드백 2] 임무/사업 목표 서술 및 달성 판정용 MOE 정의 시 목표값(Target)/한계값(Threshold)/단위(Unit)를 지정할 것",
            "[피드백 3] 운용 시점의 외부 인프라 가정을 명시하고, 블랙박스 SoI가 외부 환경(조직/물리/자연)과 상호작용하는 것에 초점을 둘 것",
            "[가이드 Gate 1~6] Whole-System, Solution-Free, ODD 3대 장소 그룹핑, 포트 대칭성(Type Symmetry), 고립 액터 방지 준수",
        );

        part profFeedback_202610 : AdvisoryFeedback :> feedbackHistory {
            ref :>> reviewer = ChapterMembers::'이중윤';
            :>> feedbackItems = (
                "운용 개념이 단순 기능 나열이 아니라 존재 목적(임무/사업 목표) 달성 모습을 보여주어야 함",
                "MOE에 정량적 구조(목표값/한계값/단위) 부여 필수 (수치 자체의 정확성보다 구조화가 중요)",
                "블랙박스 개념 강조: 내부 구조를 숨기고 운용 시점 인프라 가정 하의 외부 환경 상호작용에만 집중할 것",
            );
            :>> isResolved = false;
        }
    }
} // package ChapterActivityLogs_2026_Q4
