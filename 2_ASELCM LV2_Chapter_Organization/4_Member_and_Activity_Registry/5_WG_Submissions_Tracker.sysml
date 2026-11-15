package WG_Submissions_Tracker {
    doc
    /* [6. Projects/1. Domains 하위 도메인 폴더 매핑]
     * 워킹그룹별 과제 제출물 및 Gate 통과 현황 트래킹.
     * 새 워킹그룹의 제출은 'item <이름> : AssignmentSubmission' usage 1개만 추가한다.
     * 도메인, SoI, 저장 폴더, 소유자, 제출자 기본값은 workingGroup(WorkingGroup)에서 파생되므로 여기서 다시 적지 않는다.
     */
    private import ScalarValues::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSprint::*;
    private import WorkingGroupsAndRoles::*;
    private import ModelingAssignments_and_Feedbacks::*;

    // =========================================================================
    // 1. [1. Aerospace] 우주항공/방산 워킹그룹 제출물 트래커
    // =========================================================================
    item aerospaceWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        ref :>> workingGroup = chapterOrganization.aerospaceWG;
        :>> status = SubmissionStatusKind::inProgress;

        item :>> submittedModel {
            :>> title =
                "Multi-Purpose Quadcopter Drone System (Surveillance, Strike, Logistics) Reference Model";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> isSecurityCleared = true;
        }
    }

    // =========================================================================
    // 2. [2. Automotive] 자동차 SDV 워킹그룹 제출물 트래커
    // =========================================================================
    item automotiveWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        ref :>> workingGroup = chapterOrganization.automotiveWG;
        :>> status = SubmissionStatusKind::inProgress;
        // TODO(확인 필요): Automotive WG 참여자('추수호', '최성열', '이의범')와 제출자 목록이 달라 재정의로 남겼다.
        //   '이의범'이 제출에 참여한다면 이 재정의를 삭제하고(기본값 = WG 참여자), 아니면 WG 참여자 목록을 정정한다.
        ref :>> submitters = ('추수호', '최성열',);

        item :>> submittedModel {
            :>> title = "2035 Software-Defined Vehicle (SDV) Whole-System Reference Model";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> isSecurityCleared = true;
        }
    }

    // =========================================================================
    // 3. [3. IT] IT/로봇 시스템 워킹그룹 제출물 트래커
    // =========================================================================
    item itRoboticsWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        ref :>> workingGroup = chapterOrganization.itSwWG;
        :>> status = SubmissionStatusKind::inProgress;

        item :>> submittedModel {
            :>> title = "Disaster Search and Rescue Support Robot System Reference Model";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> isSecurityCleared = true;
        }
    }

    // =========================================================================
    // 4. [4. Semiconductor] 반도체 장비 시스템 워킹그룹 제출물 트래커
    // =========================================================================
    item semiconductorWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        ref :>> workingGroup = chapterOrganization.semiconductorWG;
        :>> status = SubmissionStatusKind::inProgress;

        item :>> submittedModel {
            :>> title = "EUV Zenith Semiconductor Equipment Fab-Context Reference Model";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> isSecurityCleared = true;
        }
    }
} // package WG_Submissions_Tracker
