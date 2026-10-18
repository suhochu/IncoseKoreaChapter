package WorkingGroupsAndRoles {
    private import ScalarValues::*;
    private import Stakeholders::*;
    private import ChapterMembers::*;
    private import SystemContext::*;
    private import ChapterSprint::*;

    part def ChapterRole {
        attribute roleTitle : String;
        ref assignee : IncoseKoreaChapterMember [0..*];
        attribute responsibilities : String [0..*];
    }

    part def WorkingGroup {
        attribute wgName : String;
        attribute targetSystemScope : String; // 예: "SDV 전체 비히클", "궤도 수송 임무 시스템 전체"
        attribute targetLV1Folder : String; // [추가] 3_ASELCM_LV1_Target_Reference_Models 내 담당 폴더 경로
        part lead : ChapterRole;
        ref participants : IncoseKoreaChapterMember [1..*];

        // 워킹그룹이 수행 중인 과제 제출물 및 보유 참조모델 아티팩트 연결
        ref activeSubmissions : AssignmentSubmission [0..*];
        ref managedReferenceModels : ReferenceModelArtifact [0..*];
    }

    part def ChapterLogicalOrganization {
        part representative : ChapterRole {
            :>> roleTitle = "Chapter Representative (챕터 대표)";
            ref :>> assignee = ChapterMembers::'이중윤';
            :>> responsibilities = (
                "챕터 비전(Do-Tank) 수립 및 운영 총괄",
                "국내외 SE 학회(KOSSE/KCOSE) 및 INCOSE 본부/섹터 대외 협력 대표",
            );
        }

        part secretary : ChapterRole {
            :>> roleTitle = "General Secretary (총무 및 운영 담당)";
            ref :>> assignee = ChapterMembers::'추수호';
            :>> responsibilities = (
                "격주 웹 스프린트 및 분기 오프라인 모임 운영",
                "Google Workspace 및 GitHub 저장소(KnowledgeRepository) 형상 관리 및 보안 점검 승인",
                "INCOSE Asia-Oceania Sector 정기 활동 보고(SectorReporting) 수행",
            );
        }

        part academicAdvisors : ChapterRole {
            :>> roleTitle = "Academic Advisory Group (교수진 자문 및 리뷰)";
            ref :>> assignee = (ChapterMembers::'이중윤', ChapterMembers::'서은석',);
            :>> responsibilities = (
                "SE 과제 실무 가이드 감수 및 방법론적 피드백(AdvisoryFeedback) 제공",
                "LV1 참조모델의 임무/사업목표(What/Why), 정량적 MOE(목표값/한계값/단위), 블랙박스 상호작용 타당성 심사",
                "LV3 ReferenceModelAssignmentApprovalGate 최종 학술 승인",
            );
        }

        part automotiveWG : WorkingGroup {
            :>> wgName = "Automotive SDV Working Group";
            :>> targetSystemScope = "부품 단위가 아닌 SDV 및 섀시를 포함한 Vehicle 전체 수준";
            :>> targetLV1Folder = "3_ASELCM_LV1_Target_Reference_Models/1_Automotive_SDV_WG";
            part :>> lead {
                :>> roleTitle = "Automotive WG Lead";
                ref :>> assignee = ChapterMembers::'추수호';
            }
            ref :>> participants = (ChapterMembers::'추수호', ChapterMembers::'최성열',);
        }
        part IT : WorkingGroup {
            :>> wgName = "Space Mission System Working Group";
            :>> targetSystemScope = "단일 SW가 아닌 궤도 수송 임무 시스템(Mission System) 전체";
            :>> targetLV1Folder = "3_ASELCM_LV1_Target_Reference_Models/2_Space_Mission_System_WG";
            part :>> lead {
                :>> roleTitle = "Space WG Lead";
                ref :>> assignee = ChapterMembers::'이수';
            }
            ref :>> participants = (
                ChapterMembers::'이수', ChapterMembers::'박승훈', ChapterMembers::'김다운',
            );
        }
        part spaceWG : WorkingGroup {
            :>> wgName = "IT & SW System Working Group";
            :>> targetSystemScope = "단일 SW가 아닌 IT 및 SW 시스템 전체";
            :>> targetLV1Folder = "3_ASELCM_LV1_Target_Reference_Models/3_IT_and_SW_System_WG";
            part :>> lead {
                :>> roleTitle = "IT WG Lead";
                ref :>> assignee = ChapterMembers::'박홍석';
            }
            ref :>> participants = (
                ChapterMembers::'심정환', ChapterMembers::'박홍석', ChapterMembers::'최지원',
                ChapterMembers::'구정모',
            );
        }
        part Semiconductor : WorkingGroup {
            :>> wgName = "Semiconductor Related System Working Group";
            :>> targetSystemScope = "단일 SW가 아닌 반도체 관련 시스템 전체";
            :>> targetLV1Folder =
                "3_ASELCM_LV1_Target_Reference_Models/4_Semiconductor_Related_System_WG";
            part :>> lead {
                :>> roleTitle = "Semiconductor WG Lead";
                ref :>> assignee = ChapterMembers::'김희재';
            }
            ref :>> participants = ChapterMembers::'김희재';
        }
    }
} // package WorkingGroupsAndRoles
