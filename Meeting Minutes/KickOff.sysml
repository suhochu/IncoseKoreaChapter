package IncoseKoreaChapter_KickOff {
    doc
    /* INCOSE Korea Chapter 킥오프 미팅 아젠다 (Do-Tank 운영 구체화 발제안) */

    private import ScalarValues::*;
    private import Time::*;

    // -----------------------------------------------------------
    // [Agenda 2] 챕터 운영 조직 체계 및 R&R 분담 모델링
    // -----------------------------------------------------------
    part def ChapterRole {
        attribute roleName : String;
        attribute assignee : String; // 미팅 후 확정된 담당자 이름을 업데이트하는 속성
    }

    part def ChapterOrganization {
        part chapterLeader : ChapterRole {
            :>> roleName = "Chapter Leader";
            :>> assignee = "이종윤 교수";
            doc
            /* 챕터 전체 비전 제시 및 외부 커뮤니케이션/대표성 확보 */
        }
        part secretary : ChapterRole {
            :>> roleName = "Secretary";
            :>> assignee = "추수호 책임";
            doc
            /* 모임 일정 조율, 협업 인프라 세팅 및 행정 인프라 유지 */
        }
        part projectCoordinator : ChapterRole {
            :>> roleName = "Project Coordinator";
            :>> assignee = "TBD"; // [회의록 통합] 회의 후 자원자가 나오면 이름 업데이트
            doc
            /* Do-Tank 엔진 역할, Task 진척도 모니터링 및 정합성 조율 */
        }
        part knowledgeAssetManager : ChapterRole {
            :>> roleName = "Knowledge Asset Manager";
            :>> assignee = "TBD";
            doc
            /* 산출물 공용 저장소 구조화, 템플릿 관리, 데이터 비식별화 검수 */
        }
        part wgLead : ChapterRole {
            :>> roleName = "Working Group Lead";
            :>> assignee = "TBD";
            doc
            /* 워킹그룹 리더로 특정 도메인/세부 주제 소모임 진도 자율 리딩 */
        }
    }

    enum def CommunicationChannel {
        KakaoTalk;
        Slack;
        Discord;
        GoogleWorkspace;
        GitHub;
        Notion;
        Zoom;
        Teams;
        GoogleMeet;
        Jira;
        IncosePlatform;
    }

    enum def MeetingFrequency {
        Weekly;
        BiWeekly;
        Monthly;
        Quarterly;
    }

    // -----------------------------------------------------------
    // 킥오프 미팅 본 회의 모델링 (아젠다 템플릿 및 회의록 결합)
    // -----------------------------------------------------------
    action def KickOffMeeting {
        doc
        /* [사용법] 
         * 회의 진행 중 또는 종료 후, 각 attribute의 `=` 우측에 
         * 합의된 결과값이나 Enum 값을 입력하여 회의록(Minutes)으로 형상관리합니다.
         */

        item meetingInfo {
            doc
            /* 미팅일자, 장소, 참석자 정보 기록 */
            attribute targetTimeStructure : Iso8601DateTimeStructure {
                :>> year = 2026;
                :>> month = 10;
                :>> day = 9;
                :>> hour = 18;
                :>> minute = 0;
                :>> second = 0;
                :>> hourOffset = 9; // KST 시차 (UTC+9)
                :>> minuteOffset = 0;
            }

            attribute meetingLocation : String := "사당역 주변, 셀스스토리  8인 회의실, 우담정";
            attribute attendees : String := "이종윤 교수, 서은석 교수, 추수호, 최성열, 이수";
        }

        // [Agenda 1] 단기 목표(Quick Win) 및 마일스톤 논의
        item agenda1_quickWinAndMilestones {
            attribute phase1 : String :=
                "1개월 차: 협업 기반 다지기(인프라 세팅) 및 공동 작업 주제 확정";
            attribute phase2 : String :=
                "3개월 차: 첫 번째 오프라인 Show & Tell (진척도 툴 시연 및 아키텍처 초안)";
            attribute phase3 : String :=
                "6개월 차: 첫 번째 Reference Asset 내부 릴리즈 및 교훈(Lessons Learned) 요약";
        }

        // [Agenda 3] 운영 방법: Task 선정 및 일정 관리 체계 논의
        item agenda3_operationMethods {
            attribute agreeOnTaskSelection : String :=
                "킥오프 2주 이내(~10월 말) Task 선정 동의 여부";
            attribute agreeOnDirection : String :=
                "A안(통합형 타겟 시스템) vs B안(독립형 도메인 진행) 방향성 합의";
            attribute agreeOnScheduleManagement : String :=
                "칸반 보드(To Do -> In Progress -> Done) 도입 실효성 논의";
        }

        // [Agenda 4] 산출물 공유 및 자산화 방식 논의
        item agenda4_assetizationAndSharing {
            attribute defineTaskCharter : String :=
                "Task 시작 시 현업 컨텍스트에 대한 가치 정의 (What to gain)";
            attribute decideShowAndTellFormat : String :=
                "단순 PPT 지양, 실제 엔지니어링 툴 구동 시연 방식 합의";
        }

        // [Agenda 5] 소통 채널 및 인프라 명확화 (회의 중 결정된 Enum 값 매핑)
        item agenda5_communicationChannels {
            attribute casualInfo : CommunicationChannel := CommunicationChannel::KakaoTalk;
            attribute asyncComms : CommunicationChannel := CommunicationChannel::Slack; // 예시: 슬랙으로 합의됨
            attribute taskManagement : CommunicationChannel := CommunicationChannel::Jira; // 예시: 지라로 합의됨
            attribute repository : CommunicationChannel := CommunicationChannel::GoogleWorkspace;
            attribute formalChannel : CommunicationChannel := CommunicationChannel::IncosePlatform;
            attribute onlineMeeting : CommunicationChannel := CommunicationChannel::Zoom; // 예시: 줌으로 합의됨
        }

        // [Agenda 6] 모임 일정 및 리듬 논의
        item agenda6_meetingSchedule {
            attribute onlineChapterMeeting : MeetingFrequency := MeetingFrequency::Monthly; // 온라인 챕터 정기 모임: 월 1회 또는 격주 (전체 진척도 리뷰)
            attribute onlineWgMeeting : MeetingFrequency := MeetingFrequency::BiWeekly; // 각 WG 자율 조율
            attribute offlineNetworking : MeetingFrequency := MeetingFrequency::Quarterly; // 오프라인 정기 네트워킹: 분기 1회 성과 릴리즈 중심
        }

        // -----------------------------------------------------------
        // [추가] 회의 결과 파생된 후속 조치 (Action Items)
        // -----------------------------------------------------------
        action nextSteps {
            doc
            /* 회의록을 바탕으로 즉각 실행해야 할 넥스트 스텝 (이후 Jira 등의 Task로 연계) */

            action setupWorkspace {
                doc
                /* 담당자: 추수호, 기한: 10/15 까지 Slack 및 Google Workspace 초기 세팅 */
            }
            action recruitProjectCoordinator {
                doc
                /* 담당자: 이종윤 교수, 기한: 10월 말까지 엔진 역할을 해줄 코디네이터 섭외 */
            }
        }
    }
} // package IncoseKoreaChapter_KickOff
