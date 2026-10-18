package WorkingGroupsAndRoles {
    private import ScalarValues::*;
    private import Stakeholders::*;
    private import ChapterMembers::*;

    part def ChapterRole {
        attribute roleTitle : String;
        ref assignee : IncoseKoreaChapterMember [0..*];
    }

    part def WorkingGroup {
        attribute wgName : String;
        attribute targetSystemScope : String; // 예: "SDV 전체 비히클", "궤도 수송 임무 시스템 전체"
        part lead : ChapterRole;
        ref participants : IncoseKoreaChapterMember [1..*];

        // 워킹그룹이 관리하는 LV1 참조모델 아티팩트 및 과제 제출 이력
        ref managedModels : SystemContext::ReferenceModelArtifact [0..*];
        ref submissions : ChapterSprint::AssignmentSubmission [0..*];
    }

    part def ChapterLogicalOrganization {
        part representative : ChapterRole {
            :>> roleTitle = "Chapter Representative (챕터 대표)";
            ref :>> assignee = ChapterMembers::'이중윤'; // 실제 회원 Part와 연결
        }
        part secretary : ChapterRole {
            :>> roleTitle = "General Secretary (총무 및 운영 담당)";
            ref :>> assignee = ChapterMembers::'추수호'; // 실제 회원 Part와 연결
        }
        part academicAdvisors : ChapterRole {
            :>> roleTitle = "Academic Advisory Group (교수진 자문 및 리뷰)";
            ref :>> assignee = (ChapterMembers::'이중윤', ChapterMembers::'서은석');
        }
        part automotiveWG : WorkingGroup {
            :>> wgName = "Automotive SDV Working Group";
            :>> targetSystemScope = "부품 단위가 아닌 SDV 및 섀시를 포함한 Vehicle 전체 수준";
            part :>> lead {
                :>> roleTitle = "Automotive WG Lead";
                ref :>> assignee = ChapterMembers::'추수호';
            }
            ref :>> participants = (
                ChapterMembers::'추수호', ChapterMembers::'최성열', ChapterMembers::'구정모'
            );
        }
        part spaceWG : WorkingGroup {
            :>> wgName = "Space Mission System Working Group";
            :>> targetSystemScope = "단일 SW가 아닌 궤도 수송 임무 시스템(Mission System) 전체";
            part :>> lead {
                :>> roleTitle = "Space WG Lead";
                ref :>> assignee = ChapterMembers::'이수';
            }
            ref :>> participants = (
                ChapterMembers::'이수', ChapterMembers::'박승훈', ChapterMembers::'김다운'
            );
        }
    }
} // package WorkingGroupsAndRoles
