package ChapterSprint {
    private import ChapterMembers::*;
    private import Time::*;
    private import ChapterBehavior::ConOps::*;
    private import ScalarValues::*;

    // 격주 스프린트 및 킥오프 회의의 공통 템플릿 정의
    action def ChapterSprintMeeting :> KnowledgeExchangeSession {
        attribute meetingDate : Iso8601DateTimeStructure;
        attribute location : String;
        ref attendees : IncoseKoreaChapterMember [1..*];
        attribute keyDecisions : String [0..*];
    }

    action def ActionItemTask {
        ref owner : IncoseKoreaChapterMember [1..*];
        attribute taskDescription : String;
        attribute dueDate : String;
    }
} // package ChapterSprint
