class PurchaseHistory {
  final int totalAmount;
  final int purchaseFrequencyPerMonth;
  final double returnRate;

  PurchaseHistory(
      {required this.totalAmount,
      required this.purchaseFrequencyPerMonth,
      required this.returnRate});
}

abstract class ExcellentCustomerRule {
  // 条件を満たすかどうか判断するパラメータだけある
  bool ok(PurchaseHistory purchaseHistory);
}

// ゴールド会員の購入金額だけのルール
class GoldCustomerPurchaseAmountRule extends ExcellentCustomerRule {
  @override
  bool ok(PurchaseHistory purchaseHistory) => 100000 <= purchaseHistory.totalAmount;
}

// 購入頻度だけのルール
class PurchaseFrequencyRule extends ExcellentCustomerRule {
  @override
  bool ok(PurchaseHistory purchaseHistory) => 10 <= purchaseHistory.purchaseFrequencyPerMonth;
}

// 返品率だけのルール
class ReturnRateRule extends ExcellentCustomerRule {
  @override
  bool ok(PurchaseHistory purchaseHistory) => purchaseHistory.returnRate <= 0.001;
}

abstract class ExcellentCustomerPolicy {
  List<ExcellentCustomerRule> get rules;

  bool complyWithAll(PurchaseHistory purchaseHistory) => rules.every((rule) => rule.ok(purchaseHistory));  
}

// extension ExcellentCustomerPolicyExtension on ExcellentCustomerPolicy {
//   bool complyWithAll(PurchaseHistory purchaseHistory)
// }

class GoldCustomerPolicy implements ExcellentCustomerPolicy {
  // ゴールド会員が満たすべきルールを配列で定義
  @override
  List<ExcellentCustomerRule> get rules {
    return [
      GoldCustomerPurchaseAmountRule(),
      PurchaseFrequencyRule(),
      ReturnRateRule()
    ];
  }
  @override
  bool complyWithAll(PurchaseHistory purchaseHistory) => rules.every((rule) => rule.ok(purchaseHistory));  
}

class SilverCustomerPolicy implements ExcellentCustomerPolicy {
  // シルバー会員が満たすべきルールを配列で定義
  @override
  List<ExcellentCustomerRule> get rules {
    return [
      PurchaseFrequencyRule(),
      ReturnRateRule()
    ];
  }
  @override
  bool complyWithAll(PurchaseHistory purchaseHistory) => rules.every((rule) => rule.ok(purchaseHistory));  
}

void main() {
  var purchaseHistory = PurchaseHistory(totalAmount: 199, purchaseFrequencyPerMonth: 20, returnRate: 0.1);

  var isGoldCustomer = GoldCustomerPolicy().complyWithAll(purchaseHistory);
  var isSilverCustomer = SilverCustomerPolicy().complyWithAll(purchaseHistory);

  print('Is gold customer: $isGoldCustomer');
  print('Is silver customer: $isSilverCustomer');
}
