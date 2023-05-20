
struct PurchaseHistory {
  let totalAmount: Int
  let purchaseFrequencyPerMonth: Int
  let returnRate: Double
}

func isGoldCustomer(purchaseHistory: PurchaseHistory) -> Bool {
  // [BAD]
  // if文がネストしていて条件分岐を見落とす可能性が高い
  if 10000 <= purchaseHistory.totalAmount  {
    if 10 <= purchaseHistory.purchaseFrequencyPerMonth {
      if purchaseHistory.returnRate <= 0.001 {
        return true
      }
    }
  }
  return false
}

func isSilverCustomer(purchaseHistory: PurchaseHistory) -> Bool {
  // [BAD]
  // isGoldCustomerと判定が被っている
  // おそらくここの条件が変わればisGoldCustomerも変えないといけない
  // GoldとSilver以外にあと10タイプあったら10箇所ロジックを揃えながら変更する可能性が高い
    if 10 <= purchaseHistory.purchaseFrequencyPerMonth {
      if purchaseHistory.returnRate <= 0.001 {
        return true
      }
    }
  return false
}
