package KickOff_Meeting_20261009 {
    doc
    /* INCOSE Korea Chapter 킥오프 미팅 (2026-10-09) 결정사항 반영 모델 */

    private import ScalarValues::*;
    private import Time::*;

    // -----------------------------------------------------------
    // [Organization] 챕터 운영 조직 체계 및 R&R
    // -----------------------------------------------------------
    part def ChapterRole {
        attribute roleName : String;
        attribute assignee : String; // 미팅 후 확정된 담당자 이름을 업데이트하는 속성
    }

    part def ChapterOrganization {
        part chapterLeader : ChapterRole {
            :>> roleName = "Chapter Representative";
            :>> assignee = "이종윤 교수";
            doc
            /* 챕터 전체 비전 제시 및 운영 총괄 */
        }
        part secretary : ChapterRole {
            :>> roleName = "Secretary (총무 및 운영 담당)";
            :>> assignee = "추수호 책임";
            doc
            /* 모임 일정 조율, 카카오톡/구글 워크스페이스 인프라 세팅 및 회의록 공유 */
        }
        part wgLead_Auto : ChapterRole {
            :>> roleName = "Working Group Lead (Automotive)";
            :>> assignee = "TBD";
            doc
            /* 자동차 도메인 워킹그룹 리딩 */
        }
        part wgLead_Space : ChapterRole {
            :>> roleName = "Working Group Lead (Space)";
            :>> assignee = "이수 연구원";
            doc
            /* 우주 도메인 워킹그룹 리딩 */
        }
    }

    enum def CommunicationChannel {
        KakaoTalk;
        GoogleWorkspace;
        GitHub;
        Slack;
        Discord;
        IncosePlatform;
    }

    enum def MeetingFrequency {
        BiWeekly;
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
            attribute attendees : String :=
                "이종윤 교수, 서은석 교수, 추수호 책임, 최성열 책임, 이수 연구원, 박홍석 연구원";
            attribute coreValue : String =
                "싱크탱크(Think-Tank)가 아닌 실제 산출물을 만드는 도탱크(Do-Tank) 지향";
        }

        item agenda1_ReferenceModelGoal {
            doc
            /* 실용적 레퍼런스 모델 개발 방향성 합의 */
            attribute approach : String =
                "이론적 스터디를 넘어 현장 적용 가능한 실용적 레퍼런스 및 아티팩트 제작";
            attribute targetScope_Auto : String =
                "자동차 도메인: 부품 단위가 아닌 SDV 및 섀시를 포함한 비히클(Vehicle) 전체 수준";
            attribute targetScope_Space : String =
                "우주 도메인: 단일 소프트웨어가 아닌 궤도 수송 임무 시스템(Mission System) 전체";
            attribute modelingStandard : String =
                "Operational Stakeholder Requirement 기준 하향식 설계 및 SysML v2 기반 End-to-End 추적성(Simulink 오토코드 제너레이션까지) 연계";
        }
        item agenda2_SecurityAndData {
            doc
            /* 기업 내부 보안 가이드라인 */
            attribute securityGuideline : String =
                "기업 내부 민감 데이터 문서화 금지, AI 및 인터넷 공개 데이터를 기반으로 모델링 수행";
        }

        item agenda3_CommunicationChannels {
            doc
            /* 소통 채널 합의 결과 */
            attribute officialChannel : CommunicationChannel = CommunicationChannel::KakaoTalk;
            attribute repository : CommunicationChannel = CommunicationChannel::GoogleWorkspace;
            attribute wgInternalComms : String =
                "워킹그룹 내부 소통은 합의에 따라 Slack 또는 Discord 도입 검토";
        }

        item agenda4_MeetingSchedule {
            doc
            /* 모임 일정 및 리듬 합의 결과 */
            attribute webMeeting : MeetingFrequency = MeetingFrequency::BiWeekly; // 2주 간격 웹 미팅
            attribute offlineMeeting : MeetingFrequency = MeetingFrequency::Quarterly; // 분기 1회 오프라인 산출물 점검
        }

        // -----------------------------------------------------------
        // [Action Items] 회의 결과 파생된 후속 조치
        // -----------------------------------------------------------
        action nextSteps {
            action setupCommunicationChannel {
                attribute assignee : String = "추수호 책임";
                attribute task : String =
                    "카카오톡 단체방 개설 및 미참석 3명등 동의 후 초대, 구글 워크스페이스 리포지토리 세팅";
            }

            action defineTargetSystem {
                attribute assignee : String = "전체 참여자";
                attribute task : String =
                    "2주 내(10월 23일경) 각자가 모델링할 대상 시스템 선정 및 다음 웹 미팅 발표 준비";
            }

            action organizeWorkingGroups {
                attribute assignee : String = "전체 참여자";
                attribute task : String =
                    "자동차 도메인과 우주 도메인 중심의 워킹그룹 구성 및 활동 범위 정의";
            }
        }
    }
} // package KickOff_Meeting_20261009
