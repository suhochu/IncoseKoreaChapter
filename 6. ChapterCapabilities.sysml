package ChapterCapabilities {
    doc
    /* KOSSE/KCOSE 등 동위 시스템(Peer System) 대비 챕터 고유 역량.
     * 개별 응답 간 공통분모 추출은 킥오프 이후 별도 취합 분석 필요.
     */

    private import ScalarValues::*;

    part def ChapterCapability {
        attribute descriptionText : String;
    }

    part globalStandardFastAdoption : ChapterCapability {
        doc
        /* 예시 인스턴스 — 취합 분석 이전의 가상 예시 */
        attribute :>> descriptionText =
            "해외 SE 표준/트렌드의 빠른 국내 도입 및 영어 원문 해독 네트워크";
    }

    part handsOnToolPractice : ChapterCapability {
        doc
        /* 예시 인스턴스 — 취합 분석 이전의 가상 예시 */
        attribute :>> descriptionText =
            "MBSE 툴(Cameo, SysML v2 등)을 직접 실습해볼 수 있는 유일한 채널";
    }
} // package ChapterCapabilities
