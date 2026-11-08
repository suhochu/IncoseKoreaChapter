package WorkingGroupsAndRoles {
    private import ScalarValues::*;
    private import StakeholderDefinitions::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;
    private import ChapterSprint::*;

    part def ChapterRole {
        attribute roleTitle : String;
        ref assignee : IncoseKoreaChapterMember [0..*];
        attribute responsibilities : String [0..*];
    }

    part def WorkingGroup {
        attribute wgName : String;
        attribute targetSystemScope : String;
        attribute targetRepoDomainFolder : String; // '6. Projects/1. Domains' 하위 폴더 경로
        attribute targetSysmlPackagePath : String; // SysML v2 모델 내 LV1 패키지 경로
        part lead : ChapterRole;
        ref participants : IncoseKoreaChapterMember [1..*];

        ref activeSubmissions : AssignmentSubmission [0..*];
        ref managedReferenceModels : ReferenceModelArtifact [0..*];
    }

    part def ChapterLogicalOrganization {
        part representative : ChapterRole {
            :>> roleTitle = "Chapter Representative (챕터 대표)";
            ref :>> assignee = ChapterMembersDirectory::'이중윤';
            :>> responsibilities = (
                "챕터 비전(Do-Tank) 수립 및 운영 총괄",
                "국내외 SE 학회(KOSSE/KCOSE) 및 INCOSE 본부/섹터 대외 협력 대표",
            );
        }

        part secretary : ChapterRole {
            :>> roleTitle = "General Secretary (총무 및 운영 담당)";
            ref :>> assignee = ChapterMembersDirectory::'추수호';
            :>> responsibilities = (
                "격주 웹 스프린트 및 분기 오프라인 모임 운영",
                "Google Workspace 및 GitHub 저장소(KnowledgeRepository) 형상 관리 및 보안 점검 승인",
                "INCOSE Asia-Oceania Sector 정기 활동 보고(SectorReporting) 수행",
            );
        }

        // [1. Aerospace WG]
        part aerospaceWG : WorkingGroup {
            :>> wgName = "1. Aerospace Working Group";
            :>> targetSystemScope =
                "2035 다목적 쿼드콥터 드론 시스템 (감시정찰/공격/보급 3대 임무 체계 전체)";
            :>> targetRepoDomainFolder = "6. Projects/1. Domains/1. Aerospace";
            :>> targetSysmlPackagePath = "3_ASELCM_LV1_Target_Reference_Models/1_Aerospace_WG";
            part :>> lead {
                :>> roleTitle = "Aerospace WG Lead";
                ref :>> assignee = ChapterMembersDirectory::'이수';
            }
            ref :>> participants = (
                ChapterMembersDirectory::'이수', ChapterMembersDirectory::'박승훈',
                ChapterMembersDirectory::'김다운', ChapterMembersDirectory::'박홍석',
            );
        }

        // [2. Automotive WG]
        part automotiveWG : WorkingGroup {
            :>> wgName = "2. Automotive Working Group";
            :>> targetSystemScope =
                "2035 소프트웨어 중심 자동차(SDV) 및 섀시를 포함한 Vehicle 전체 시스템";
            :>> targetRepoDomainFolder = "6. Projects/1. Domains/2. Automotive";
            :>> targetSysmlPackagePath = "3_ASELCM_LV1_Target_Reference_Models/2_Automotive_WG";
            part :>> lead {
                :>> roleTitle = "Automotive WG Lead";
                ref :>> assignee = ChapterMembersDirectory::'추수호';
            }
            ref :>> participants = (
                ChapterMembersDirectory::'추수호', ChapterMembersDirectory::'최성열',
                ChapterMembersDirectory::'이의범',
            );
        }

        // [3. IT 폴더 매핑]
        part itSwWG : WorkingGroup {
            :>> wgName = "3. IT & Robotics Working Group";
            :>> targetSystemScope = "2035 재난 탐색 및 구조 지원 로봇 시스템 전체";
            :>> targetRepoDomainFolder = "6. Projects/1. Domains/3. IT";
            :>> targetSysmlPackagePath = "3_ASELCM_LV1_Target_Reference_Models/3_IT_WG";
            part :>> lead {
                :>> roleTitle = "IT & Robotics WG Lead";
                ref :>> assignee = ChapterMembersDirectory::'박홍석';
            }
            ref :>> participants = (
                ChapterMembersDirectory::'심정환', ChapterMembersDirectory::'박홍석',
                ChapterMembersDirectory::'최지원', ChapterMembersDirectory::'구정모',
            );
        }

        // [4. Semiconductor 폴더 매핑]
        part semiconductorWG : WorkingGroup {
            :>> wgName = "4. Semiconductor Working Group";
            :>> targetSystemScope =
                "2035 EUV 제니스 반도체 장비 시스템 (Level 0 리소그래피/타 공정 컨텍스트 및 Fab 베리에이션 포함)";
            :>> targetRepoDomainFolder = "6. Projects/1. Domains/4. Semiconductor";
            :>> targetSysmlPackagePath = "3_ASELCM_LV1_Target_Reference_Models/4_Semiconductor_WG";
            part :>> lead {
                :>> roleTitle = "Semiconductor WG Lead";
                ref :>> assignee = ChapterMembersDirectory::'김희재';
            }
            ref :>> participants = ChapterMembersDirectory::'김희재';
        }
    }
} // package WorkingGroupsAndRoles
