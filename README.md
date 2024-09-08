# SamplePageViewController
`UIPageViewController`에서 발생하는 컴파일 에러를 재현하기 위한 프로젝트 ([포럼 문의](https://developer.apple.com/forums/thread/761662))

## 주의사항
시뮬레이터에서는 발생하지 않습니다.  
실제 기기에서 확인해 주세요.

## 재현 시나리오
1. 다음페이지로 넘겨서 마지막 페이지까지 이동합니다.
2. 마지막 페이지에서 "오른쪽 위에서 왼쪽 아래" 방향으로 드래그합니다.
3. `viewControllerAfter` 메서드가 비정상적으로 많이 호출되며 크래시가 발생합니다.
  - `The number of view controllers provided (0) doesn't match the number required (2) for the requested transition`

## 재현 영상

https://github.com/user-attachments/assets/9ef8680f-2594-4b8b-8a96-904081c2cb2a

## 해결 방법
- [관련 커밋](https://github.com/jeongju9216/SamplePageViewController/commit/fcd7912d82a64518f4cd1a890edafe1fa63532c9)
- `UIPageViewController`에 PanGesture를 등록하여 제스처를 선처리함
  - SwipeGesture는 제스처 인식 타이밍이 늦어 PanGesture 사용
- `UIPageViewController`를 사용하는 `UIViewController`에서 GestureDelegate를 준수해야 함
