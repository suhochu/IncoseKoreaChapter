package WG_Submissions_Tracker {
    doc
    /* [6. Projects/1. Domains 하위 4대 도메인 폴더 매핑]
     * 1. Aerospace, 2. Automotive, 3. IT, 4. Semiconductor 워킹그룹별 과제 제출물 및 Gate 통과 현황 트래킹
     */
    private import ScalarValues::*;
    private import ChapterMembersDirectory::*;
    private import ChapterSystemContext::*;
    private import ChapterSprint::*;
    private import ModelingAssignments_and_Feedbacks::*;

    // =========================================================================
    // 1. [1. Aerospace] 우주항공/방산 워킹그룹 제출물 트래커
    // =========================================================================
    item aerospaceWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        :>> workingGroupName = "1. Aerospace Working Group (Space & Drone)";
        ref :>> submitters = (
            ChapterMembersDirectory::'이수', ChapterMembersDirectory::'박승훈',
            ChapterMembersDirectory::'김다운', ChapterMembersDirectory::'박홍석',
        );
        :>> status = SubmissionStatusKind::inProgress;

        part :>> submittedModel : ReferenceModelArtifact {
            :>> title =
                "Multi-Purpose Quadcopter Drone System (Surveillance, Strike, Logistics) Reference Model";
            :>> owner = "Aerospace WG";
            :>> repoFolderPath = "6. Projects/1. Domains/1. Aerospace";
            :>> locationURL = "6. Projects/1. Domains/1. Aerospace/";
            :>> domainName = "1. Aerospace (Defense & Space/UAV)";
            :>> targetSoIName = "2035 다목적 쿼드콥터 드론 시스템 (감시정찰/공격/보급 임무 시스템)";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> inheritsCommonScaffold = true;
            :>> isSecurityCleared = true;
            :>> isGateApproved = false;
        }
    }

    // =========================================================================
    // 2. [2. Automotive] 자동차 SDV 워킹그룹 제출물 트래커
    // =========================================================================
    item automotiveWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        :>> workingGroupName = "2. Automotive SDV Working Group";
        ref :>> submitters = (
            ChapterMembersDirectory::'추수호', ChapterMembersDirectory::'최성열',
        );
        :>> status = SubmissionStatusKind::inProgress;

        part :>> submittedModel : ReferenceModelArtifact {
            :>> title = "2035 Software-Defined Vehicle (SDV) Whole-System Reference Model";
            :>> owner = "Automotive SDV WG";
            :>> repoFolderPath = "6. Projects/1. Domains/2. Automotive";
            :>> locationURL = "6. Projects/1. Domains/2. Automotive/";
            :>> domainName = "2. Automotive (SDV & Smart Mobility)";
            :>> targetSoIName = "2035 소프트웨어 중심 자동차 (SDV Whole-System Vehicle)";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> inheritsCommonScaffold = true;
            :>> isSecurityCleared = true;
            :>> isGateApproved = false;
        }
    }

    // =========================================================================
    // 3. [3. IT] IT/로봇 시스템 워킹그룹 제출물 트래커
    // =========================================================================
    item itRoboticsWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        :>> workingGroupName = "3. IT & Robotics System Working Group";
        ref :>> submitters = (
            ChapterMembersDirectory::'구정모', ChapterMembersDirectory::'최지원',
            ChapterMembersDirectory::'박홍석', ChapterMembersDirectory::'심정환',
        );
        :>> status = SubmissionStatusKind::inProgress;

        part :>> submittedModel : ReferenceModelArtifact {
            :>> title = "Disaster Search and Rescue Support Robot System Reference Model";
            :>> owner = "IT & Robotics WG";
            :>> repoFolderPath = "6. Projects/1. Domains/3. IT";
            :>> locationURL = "6. Projects/1. Domains/3. IT/";
            :>> domainName = "3. IT (Robotics & Smart Disaster Response System)";
            :>> targetSoIName = "2035 재난 탐색 및 구조 지원 로봇 시스템";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> inheritsCommonScaffold = true;
            :>> isSecurityCleared = true;
            :>> isGateApproved = false;
        }
    }

    // =========================================================================
    // 4. [4. Semiconductor] 반도체 장비 시스템 워킹그룹 제출물 트래커
    // =========================================================================
    item semiconductorWG_Sub_Assignment2 : AssignmentSubmission {
        ref :>> targetAssignment = assignment1_2_BlackBoxAndConOps;
        :>> workingGroupName = "4. Semiconductor System Working Group";
        ref :>> submitters = ChapterMembersDirectory::'김희재';
        :>> status = SubmissionStatusKind::inProgress;

        part :>> submittedModel : ReferenceModelArtifact {
            :>> title = "EUV Zenith Semiconductor Equipment Fab-Context Reference Model";
            :>> owner = "Semiconductor WG";
            :>> repoFolderPath = "6. Projects/1. Domains/4. Semiconductor";
            :>> locationURL = "6. Projects/1. Domains/4. Semiconductor/";
            :>> domainName = "4. Semiconductor (EUV Lithography & Sub-Fab System)";
            :>> targetSoIName = "2035 EUV 제니스 반도체 장비 시스템 (Level 0 Fab Context)";
            :>> modelVersion = "v0.2-DoDAF-ConOps";
            :>> inheritsCommonScaffold = true;
            :>> isSecurityCleared = true;
            :>> isGateApproved = false;
        }
    }
} // package WG_Submissions_Tracker
