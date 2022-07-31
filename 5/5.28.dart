// 5.28~5.29

import 'dart:math';

class MagicPoint {
  // [GOOD]
  // 5.23.dartでパラパラだった引数のパラメータたちがMagicPointというひとつのクラスに関連付けられた
  // つまりこの３つは常に関わりのあるパラメータであることが分かる
  late int _currentAmount;
  late final int _originalMaxAmount;
  late List<int> _maxIncrements;

  MagicPoint(final int currentAmount, final int originalMaxAmount,
      final List<int> maxIncrements)
      : this._currentAmount = currentAmount,
        this._originalMaxAmount = originalMaxAmount,
        this._maxIncrements = maxIncrements;

  int get current => _currentAmount;
  int get maxAmount {
    return _originalMaxAmount +
        _maxIncrements.reduce((acc, element) => acc + element);
  }

  // [GOOD]
  // 5.23.dartで複数あったパラメータの数がひとつになった
  void recover(final int recoverAmount) {
    _currentAmount = min(_currentAmount + recoverAmount, maxAmount);
  }
}

void main() {
  final magicPoint = MagicPoint(100, 1000, [100, 20, 30, 40]);
  print(magicPoint.current);
  magicPoint.recover(1000000);
  print(magicPoint.current);
}
