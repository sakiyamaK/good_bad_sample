//後ほど説明 (*1)
enum Currency { yen, dollar }

//[BAD]
//そもそもビルドができないようにされている
//パラメータを初期化しないといけない
class Money {
  int amount;
  Currency currency;
}

void main() {
  final money = Money();
}
