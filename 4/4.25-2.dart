import 'dart:math';

// どうしても可変な設計にする場合

class HitPoint {
  static final _MIN = 0;

  // 可変であることが前提なのでfinalじゃないことはBADではない
  // [GOOD]
  // privateなので外部から変更できない
  late int _amount;
  //getterだけ用意してamountにアクセスだけできるようにする
  int get amount {
    return _amount;
  }

  HitPoint(int amount) {
    if (amount < _MIN) {
      throw Exception();
    }
    this._amount = amount;
  }

  void damege(final int damegeAmount) {
    final nextAmount = _amount - damegeAmount;
    _amount = max(_MIN, nextAmount);
  }

  bool get isMin {
    return this._amount == _MIN;
  }
}

enum State { alive, death, poison }

class Member {
  final HitPoint hitPoint;
  // [注意]
  // Dartの場合finalだとして配列は中身を変えることができてしまう
  // [BAD]
  // 外部から変更できてしまう
  // Dartの配列は参照を渡すだけなのでHitPoint.amountのような対応もできない
  // 言語仕様上、注意がいる
  final List<State> states; //List.unmodifiable(states);

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

  // [GOOD]
  // member.amountが外部から修正できない(ビルドが通らない)
  member.hitPoint.amount = -20;
  print(member.hitPoint.amount);
  // [BAD]
  // member.stateが外部に公開されているかつListのため、外部からも変更できてしまう
  member.states.add(State.alive);
  print(member.states);
}
