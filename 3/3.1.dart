//後ほど説明 (*1)
enum Currentry { yen, dollar }

//[BAD]
//そもそもビルドができないようにされている
//パラメータを初期化しないといけない
class Money {
  int amount;
  Currentry currentry;
}

void main() {
  final money = Money();
}
