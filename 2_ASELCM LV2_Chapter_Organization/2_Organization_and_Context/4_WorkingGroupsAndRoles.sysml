package WorkingGroupsAndRoles {
    private import ScalarValues::*;
    private import StakeholderDefinitions::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;

    doc
    /* 챕터 논리 조직(역할과 워킹그룹) 정의 및 인스턴스.
     *
     * [새 WG 추가 절차 - def는 수정하지 않는다]
     * 1) DomainKind: 새 도메인이 StakeholderDefinitions::DomainKind 에 없으면 값을 추가한다.
     * 2) 폴더: ChapterSystemContext::KnowledgeRepository 의 도메인 폴더 아래에
     *    'part <이름> : DirectoryFolder :> subFolders' usage를 추가하고 relativePath를 '상위 폴더 경로 + "/" + folderName' 으로 지정한다.
     * 3) WG usage: 아래 chapterOrganization 안에 'part <이름> :> workingGroups { ... }' usage를 추가한다.
     * 4) 제출 트래커: WG_Submissions_Tracker 에 'item <이름> : AssignmentSubmission' usage를 추가하고
     *    workingGroup 을 위 WG로 지정한다. (도메인, SoI, 폴더, 제출자 기본값은 WG에서 파생된다.)
     */

    part def ChapterRole {
        attribute roleTitle : String;
        ref assignee : IncoseKoreaChapterMember [0..*];
        attribute responsibilities : String [0..*];
    }

    part def WorkingGroup {
        doc
        /* 워킹그룹 정의. 이 WG가 제출한 과제는 AssignmentSubmission.workingGroup 이 이 WG를 참조하는 방식으로 연결된다.
         * 역방향(WG -> 제출 건) 목록은 중복 정의가 되므로 두지 않는다(트래커/TableView에서 조회).
         */
        attribute wgName : String;
        attribute targetSystemScope : String;
        attribute domain : DomainKind [0..*];
        ref targetFolder : DirectoryFolder [0..1]; // KnowledgeRepository 내 '6. Projects/1. Domains' 하위 폴더
        // LV1 루트 폴더명은 한 곳에서만 정의하고, 경로는 루트 + WG 폴더명으로 파생한다.
        attribute lv1RootPath : String default "3_ASELCM_LV1_Target_Reference_Models";
        attribute lv1PackageFolderName : String;
        attribute targetSysmlPackagePath : String = lv1RootPath + "/" + lv1PackageFolderName; // SysML v2 모델 내 LV1 패키지 경로
        part lead : ChapterRole;
        ref participants : IncoseKoreaChapterMember [1..*];
    }

    part def ChapterLogicalOrganization {
        doc
        /* 챕터 논리 조직의 순수 구조 정의 (Definition). 구체 회원/WG 바인딩은 chapterOrganization(Usage)에서 수행.
         * 워킹그룹은 workingGroups 컬렉션에 usage로만 추가한다.
         */
        part representative : ChapterRole;
        part secretary : ChapterRole;
        part academicAdvisors : ChapterRole;
        part workingGroups : WorkingGroup [1..*];
    }

    // ---- 챕터 논리 조직 인스턴스 (Usage) ----
    part chapterOrganization : ChapterLogicalOrganization {
        part :>> representative {
            :>> roleTitle = "Chapter Representative (챕터 대표)";
            ref :>> assignee = '이중윤';
            :>> responsibilities = (
                "챕터 비전(Do-Tank) 수립 및 운영 총괄",
                "국내외 SE 학회(KOSSE/KCOSE) 및 INCOSE 본부/섹터 대외 협력 대표",
            );
        }

        part :>> secretary {
            :>> roleTitle = "General Secretary (총무 및 운영 담당)";
            ref :>> assignee = '추수호';
            :>> responsibilities = (
                "격주 웹 스프린트 및 분기 오프라인 모임 운영",
                "Google Workspace 및 GitHub 저장소(KnowledgeRepository) 형상 관리 및 보안 점검 승인",
                "INCOSE Asia-Oceania Sector 정기 활동 보고(SectorReporting) 수행",
            );
        }

        part :>> academicAdvisors {
            :>> roleTitle = "Academic Advisors (학술자문단)";
            ref :>> assignee = ('이중윤', '서은석',);
            :>> responsibilities = (
                "모델링 방법론 및 피드백 검증 (ModelReviewProcess::reviewByAcademicAdvisors)",
            );
        }

        // [1. Aerospace WG]
        part aerospaceWG :> workingGroups {
            :>> wgName = "1. Aerospace Working Group";
            :>> targetSystemScope =
                "2035 다목적 쿼드콥터 드론 시스템 (감시정찰/공격/보급 임무 체계 전체)";
            :>> domain = DomainKind::defenseAndAerospace;
            ref :>> targetFolder =
                incoseKoreaChapterContext.chapter.repository.folder6_Projects.sub1_Domains.dom1_Aerospace;
            :>> lv1PackageFolderName = "1_Aerospace_WG";
            part :>> lead {
                :>> roleTitle = "Aerospace WG Lead";
                ref :>> assignee = '이수';
            }
            ref :>> participants = ('이수', '박승훈', '김다운', '박홍석',);
        }

        // [2. Automotive WG]
        part automotiveWG :> workingGroups {
            :>> wgName = "2. Automotive Working Group";
            :>> targetSystemScope =
                "2035 소프트웨어 중심 자동차(SDV) 및 섀시를 포함한 Vehicle 전체 시스템";
            :>> domain = DomainKind::automotiveAndMobility;
            ref :>> targetFolder =
                incoseKoreaChapterContext.chapter.repository.folder6_Projects.sub1_Domains.dom2_Automotive;
            :>> lv1PackageFolderName = "2_Automotive_WG";
            part :>> lead {
                :>> roleTitle = "Automotive WG Lead";
                ref :>> assignee = '추수호';
            }
            ref :>> participants = ('추수호', '최성열', '이의범',);
        }

        // [3. IT 폴더 매핑]
        part itSwWG :> workingGroups {
            :>> wgName = "3. IT & Robotics Working Group";
            :>> targetSystemScope = "2035 재난 탐색 및 구조 지원 로봇 시스템 전체";
            :>> domain = DomainKind::itAndSoftware;
            ref :>> targetFolder =
                incoseKoreaChapterContext.chapter.repository.folder6_Projects.sub1_Domains.dom3_IT;
            :>> lv1PackageFolderName = "3_IT_WG";
            part :>> lead {
                :>> roleTitle = "IT & Robotics WG Lead";
                ref :>> assignee = '박홍석';
            }
            ref :>> participants = ('심정환', '박홍석', '최지원', '구정모',);
        }

        // [4. Semiconductor 폴더 매핑]
        part semiconductorWG :> workingGroups {
            :>> wgName = "4. Semiconductor Working Group";
            :>> targetSystemScope =
                "2035 EUV 제니스 반도체 장비 시스템 (Level 0 리소그래피/타 공정 컨텍스트 및 Fab 베리에이션 포함)";
            :>> domain = DomainKind::semiconductor;
            ref :>> targetFolder =
                incoseKoreaChapterContext.chapter.repository.folder6_Projects.sub1_Domains.dom4_Semiconductor;
            :>> lv1PackageFolderName = "4_Semiconductor_WG";
            part :>> lead {
                :>> roleTitle = "Semiconductor WG Lead";
                ref :>> assignee = '김희재';
            }
            ref :>> participants = '김희재';
        }
    }
} // package WorkingGroupsAndRoles
