class Dice {
  final int size;
  late List<int> dice = [];

  Dice({required this.size}) {
    init();
  }

  void init() {
    //다시 원래 크기로 만들기
    //배열 초기화
    dice.clear();
    for (int i = 1; i <= size; i++) {
      dice.add(i);
    }
  }

  void shake() {
    dice.shuffle();
  }

  int pick() {
    int res = dice.first;
    dice.removeAt(0);
    return res;
  }
}
