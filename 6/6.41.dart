class PurchaseHistory {
  final int totalAmount;
  final int purchaseFrequencyPerMonth;
  final double returnRate;

  PurchaseHistory(
      {required this.totalAmount,
      required this.purchaseFrequencyPerMonth,
      required this.returnRate});
}

bool isGoldCustomer(PurchaseHistory purchaseHistory) {
  // [BAD]
  // if文がネストしていて条件分岐を見落とす可能性が高い
  if (10000 <= purchaseHistory.totalAmount) {
    if (10 <= purchaseHistory.purchaseFrequencyPerMonth) {
      if (purchaseHistory.returnRate <= 0.001) {
        return true;
      }
    }
  }
  return false;
}

bool isSilverCustomer(PurchaseHistory purchaseHistory) {
  // [BAD]
  // isGoldCustomerと判定が被っている
  // おそらくここの条件が変わればisGoldCustomerも変えないといけない
  // GoldとSilver以外にあと10タイプあったら10箇所ロジックを揃えながら変更する可能性が高い
  if (10 <= purchaseHistory.purchaseFrequencyPerMonth) {
    if (purchaseHistory.returnRate <= 0.001) {
      return true;
    }
  }
  return false;
}
