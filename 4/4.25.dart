import 'dart:math';

// どうしても可変な設計にする場合

class HitPoint {
  static final _MIN = 0;

  // 可変であることが前提なのでfinalじゃないことはBADではない
  // [BAD]
  // 外部から変更できてしまうためまだマイナスになりうる
  late int amount;

  HitPoint(int amount) {
    // [GOOD]
    // amountに_MINより小さい値が入らないようにしている
    if (amount < _MIN) {
      throw Exception();
    }
    this.amount = amount;
  }

  void damege(final int damegeAmount) {
    final nextAmount = amount - damegeAmount;
    // [GOOD]
    // amountに_MINより小さい値が入らないようにしている
    amount = max(_MIN, nextAmount);
  }

  // [GOOD]
  // 本ではisZeroというメソッドだった
  // しかし内部は_MINとの比較であり,_MINは仕様変更でどう値が変わるか分からない
  // パラメータがないためメソッドにする必要もない
  bool get isMin {
    return this.amount == _MIN;
  }
}

enum State { alive, death, poison }

class Member {
  final HitPoint hitPoint;
  // [注意]
  // Dartの場合finalだとして配列は中身を変えることができてしまう
  // [BAD]
  // 外部から変更できてしまう
  final List<State> states;

  Member(HitPoint this.hitPoint, List<State> this.states);

  void damege(int damegeAmount) {
    hitPoint.damege(damegeAmount);
    if (hitPoint.isMin) {
      states.remove(State.alive);
      states.add(State.death);
      // [おまけ]
      // こうやって..とするとメソッドチェーンみたいに書ける
//       states.remove(State.alive)
//         ..add(State.death);

    }
  }
}

void main() {
  final Member member = Member(HitPoint(10), [State.alive]);

  member.damege(20);

  // [GOOD]
  // hitPointがマイナスにならない
  // statesが切り替わっている
  print(member.hitPoint.amount);
  print(member.states);

  // [BAD]
  // member.amountが外部に公開されているためdamege()以外からも変更できてしまう
  // member.stateが外部に公開されているかつListのため、外部からも変更できてしまう

  // 本の対応だけではまだバグが入り込む余地があるぐらい
  // 変数の利用は気をつけないといけない
  member.hitPoint.amount = -20;
  member.states.add(State.alive);
  print(member.hitPoint.amount);
  print(member.states);
}
