import os
import re
from pathlib import Path
from typing import List, Tuple, Union


def get_natural_sort_key(path_str: str) -> List[Union[int, str]]:
    """
    경로 문자열에 포함된 숫자를 실제 정수(int)로 변환하여 자연 정렬(Natural Sort)을 수행하기 위한 키를 생성합니다.
    예: '2. Views.sysml'이 '10. Extra.sysml'보다 앞에 오도록 보장합니다.
    """
    # 경로를 슬래시(/) 기준으로 분리하여 상위 폴더부터 순차적으로 비교하도록 처리
    parts = path_str.replace('\\', '/').split('/')
    key = []
    for part in parts:
        # 문자열과 숫자를 분리 (예: '01. View' -> ['', 1, '. view'])
        sub_parts = [
            int(text) if text.isdigit() else text.lower()
            for text in re.split(r'(\d+)', part)
        ]
        key.append(sub_parts)
    return key


def collect_and_sort_sysml_files(root_dir: Path) -> List[Tuple[str, Path]]:
    """
    루트 디렉토리 및 하위 폴더에서 모든 .sysml 파일을 찾아 자연 정렬된 리스트로 반환합니다.
    반환 형태: [(상대경로_문자열, 실제_파일_Path객체), ...]
    """
    sysml_files = []

    # os.walk를 사용하여 루트 포함 모든 하위 디렉토리 탐색
    for current_root, dirs, files in os.walk(root_dir):
        for file in files:
            # 대소문자 구분 없이 .sysml 확장자 확인
            if file.lower().endswith('.sysml'):
                full_path = Path(current_root) / file
                # 루트 기준 상대 경로 계산 후 경로 구분자를 '/'로 통일 (POSIX 스타일)
                rel_path = full_path.relative_to(root_dir).as_posix()
                sysml_files.append((rel_path, full_path))

    # 상대 경로 문자열을 기준으로 자연 정렬 수행
    sysml_files.sort(key=lambda item: get_natural_sort_key(item[0]))
    return sysml_files


def merge_sysml_to_txt(root_dir: Path, output_filename: str = "merged_sysml.txt") -> None:
    """
    정렬된 .sysml 파일들의 내용을 읽어 하나의 텍스트 파일로 병합합니다.
    """
    output_path = root_dir / output_filename
    sorted_files = collect_and_sort_sysml_files(root_dir)

    if not sorted_files:
        print(f"[알림] '{root_dir}' 및 하위 폴더에서 .sysml 파일을 찾을 수 없습니다.")
        return

    print(f"총 {len(sorted_files)}개의 .sysml 파일을 찾았습니다. 병합을 시작합니다...\n")

    try:
        with open(output_path, 'w', encoding='utf-8') as outfile:
            for index, (rel_path, full_path) in enumerate(sorted_files, start=1):
                print(f"[{index}/{len(sorted_files)}] 병합 중: {rel_path}")

                # 1. 헤더 기입: ##directories/filename##
                outfile.write(f"##{rel_path}##\n")

                # 2. 파일 내용 읽기 (인코딩 호환성 고려: utf-8 우선 시도 후 cp949 폴백)
                content = ""
                try:
                    with open(full_path, 'r', encoding='utf-8') as infile:
                        content = infile.read()
                except UnicodeDecodeError:
                    try:
                        with open(full_path, 'r', encoding='cp949') as infile:
                            content = infile.read()
                    except Exception as e:
                        content = f"// [오류] 파일을 읽을 수 없습니다: {e}\n"
                except Exception as e:
                    content = f"// [오류] 파일을 읽는 중 예외 발생: {e}\n"

                # 3. 본문 내용 기입
                outfile.write(content)

                # 파일 내용 끝에 줄바꿈이 없는 경우를 대비해 줄바꿈 보정 및 파일 간 간격 추가
                if content and not content.endswith('\n'):
                    outfile.write('\n')
                outfile.write('\n')

        print(f"\n[완료] 모든 파일이 성공적으로 병합되었습니다!")
        print(f"저장 위치: {output_path}")

    except Exception as e:
        print(f"\n[치명적 오류] 결과 파일을 생성하는 중 문제가 발생했습니다: {e}")


if __name__ == "__main__":
    # 스크립트가 실행되는 현재 작업 디렉토리(CWD)를 루트로 설정
    # 만약 실행 위치와 상관없이 '파이썬 파일이 있는 위치'를 무조건 루트로 하려면:
    # current_working_dir = Path(__file__).resolve().parent 로 변경하시면 됩니다.
    current_working_dir = Path.cwd()
    
    # 결과 파일명 지정
    OUTPUT_FILE = "merged_sysml.txt"
    
    merge_sysml_to_txt(current_working_dir, OUTPUT_FILE)