# SamplePageViewController
UIPageViewController에서 발생하는 에러를 재현하기 위한 프로젝트

## 주의사항
시뮬레이터에서는 발생하지 않습니다.  
실제 기기에서 확인해 주세요.

## 재현 시나리오
1. 다음페이지로 넘겨서 마지막 페이지까지 이동합니다.
2. 마지막 페이지에서 "오른쪽 위에서 왼쪽 아래" 방향으로 드래그합니다.
3. viewControllerAfter 메서드가 비정상적으로 많이 호출되며 크래시가 발생합니다.

## 영상

https://github.com/user-attachments/assets/9ef8680f-2594-4b8b-8a96-904081c2cb2a

