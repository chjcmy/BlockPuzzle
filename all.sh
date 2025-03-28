#!/bin/bash

# 출력 파일 생성
output_file="score_dummy_data.txt"
echo "-- Score 테이블 더미 데이터 (유저 71명 x 시즌 12개)" > $output_file
echo "-- 생성일: $(date)" >> $output_file
echo "" >> $output_file

# 트랜잭션 시작
echo "BEGIN;" >> $output_file

# 유저 ID (1-71)
user_ids=($(seq 1 71))

# 시즌 ID
season_ids=(1 2 3 4 9 10 11 12 13 14 15 16)

# 각 시즌과 유저별로 점수 생성
for season_id in "${season_ids[@]}"; do
  # 시즌별 월 범위와 연도 정의
  case $season_id in
    1) # 2023 봄
      year=2023
      months=(3 4 5)
      ;;
    2) # 2023 여름
      year=2023
      months=(6 7 8)
      ;;
    3) # 2023 가을
      year=2023
      months=(9 10 11)
      ;;
    4) # 2023 겨울 (2023년 12월 - 2024년 2월)
      months=(12 1 2)
      years=(2023 2024 2024)
      ;;
    9) # 2024 봄
      year=2024
      months=(3 4 5)
      ;;
    10) # 2024 여름
      year=2024
      months=(6 7 8)
      ;;
    11) # 2024 가을
      year=2024
      months=(9 10 11)
      ;;
    12) # 2024 겨울 (2024년 12월 - 2025년 2월)
      months=(12 1 2)
      years=(2024 2025 2025)
      ;;
    13) # 2025 봄
      year=2025
      months=(3 4 5)
      ;;
    14) # 2025 여름
      year=2025
      months=(6 7 8)
      ;;
    15) # 2025 가을
      year=2025
      months=(9 10 11)
      ;;
    16) # 2025 겨울 (2025년 12월 - 2026년 2월)
      months=(12 1 2)
      years=(2025 2026 2026)
      ;;
  esac
  
  echo "-- 시즌 ID: $season_id" >> $output_file
  
  for user_id in "${user_ids[@]}"; do
    # 0~3000 사이의 랜덤 점수 생성
    score=$((RANDOM % 3001))
    
    # 시즌 내의 랜덤 날짜 생성
    if [[ "$season_id" == 4 || "$season_id" == 12 || "$season_id" == 16 ]]; then
      # 겨울 시즌은 두 해에 걸침
      month_index=$((RANDOM % 3))
      month=${months[$month_index]}
      random_year=${years[$month_index]}
    else
      # 일반 시즌은 한 해 내에서 처리
      month=${months[$((RANDOM % 3))]}
      random_year=$year
    fi
    
    # 선택된 월의 최대 일수 결정
    case $month in
      4|6|9|11) max_day=30 ;; # 4, 6, 9, 11월
      2) # 2월 - 윤년 체크
        if [ $((random_year % 4)) -eq 0 ] && [ $((random_year % 100)) -ne 0 ] || [ $((random_year % 400)) -eq 0 ]; then
          max_day=29  # 윤년
        else
          max_day=28  # 평년
        fi
        ;;
      *) max_day=31 ;; # 기타 모든 월
    esac
    
    # 랜덤 일, 시, 분, 초 생성
    day=$((RANDOM % max_day + 1))
    hour=$((RANDOM % 24))
    minute=$((RANDOM % 60))
    second=$((RANDOM % 60))
    
    # 앞에 0 붙이기 포맷팅
    formatted_month=$(printf "%02d" $month)
    formatted_day=$(printf "%02d" $day)
    formatted_hour=$(printf "%02d" $hour)
    formatted_minute=$(printf "%02d" $minute)
    formatted_second=$(printf "%02d" $second)
    
    # 최종 날짜시간
    date_time="$random_year-$formatted_month-$formatted_day $formatted_hour:$formatted_minute:$formatted_second"
    
    # INSERT 문 작성 (충돌 처리 포함)
    echo "INSERT INTO \"Score\" (score, \"dateTime\", \"userId\", \"seasonId\")" >> $output_file
    echo "VALUES ($score, '$date_time', $user_id, $season_id)" >> $output_file
    echo "ON CONFLICT (\"userId\", \"seasonId\") DO UPDATE SET" >> $output_file
    echo "  score = EXCLUDED.score," >> $output_file
    echo "  \"dateTime\" = EXCLUDED.\"dateTime\";" >> $output_file
    echo "" >> $output_file
  done
  
  echo "" >> $output_file
done

# 트랜잭션 커밋
echo "COMMIT;" >> $output_file

echo "SQL 쿼리가 $output_file 파일에 생성되었습니다."
