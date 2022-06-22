// どうしても可変な設計にする場合

class HitPoint {
  // [BAD]
  // 可変であることが前提なのでfinalじゃないことはBADではないが
  // amountがマイナスもありえたりするなど
  // 可変なら可変で「正しい値しか」状態を保てないようにしていないことがBAD
  int amount;
  HitPoint(int this.amount);
}

enum State { alive, death, poison }

class Member {
  final HitPoint hitPoint;
  final List<State> states;

  Member(HitPoint this.hitPoint, List<State> this.states);

  void damege(int damegeAmount) {
    hitPoint.amount -= damegeAmount;
  }
}

void main() {
  final Member member = Member(HitPoint(10), [State.alive]);

  member.damege(20);

  // [BAD]
  // hitPointがマイナスになっている
  // statesが何も切り替わってない
  print(member.hitPoint.amount);
  print(member.states);
}
