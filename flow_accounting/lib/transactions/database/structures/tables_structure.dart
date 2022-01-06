class TransactionsData {

  final int id;

  final String sourceCardNumber;
  final String targetCardNumber;

  final String sourceBankName;
  final String targetBankName;

  final String sourceUsername;
  final String targetUsername;

  final String amountMoney;
  /// Transaction Time In Millisecond
  final String transactionTime;

  /// Reminder Time In Millisecond
  final String reminderTime;

  TransactionsData({
    required this.id,

    required this.sourceCardNumber,
    required this.targetCardNumber,

    required this.sourceBankName,
    required this.targetBankName,

    required this.sourceUsername,
    required this.targetUsername,

    required this.amountMoney,
    required this.transactionTime,
    required this.reminderTime,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,

      'sourceCardNumber': sourceCardNumber,
      'targetCardNumber': targetCardNumber,

      'sourceBankName': sourceBankName,
      'targetBankName': targetBankName,

      'sourceUsername': sourceUsername,
      'targetUsername': targetUsername,

      'amountMoney': amountMoney,
      'transactionTime': transactionTime,

      'reminderTime': reminderTime,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'TransactionsData{id: $id, '
        'sourceCardNumber: $sourceCardNumber, '
        'targetCardNumber: $targetCardNumber'

        'sourceBankName: $sourceBankName,'
        'targetBankName: $targetBankName,'

        'sourceUsername: $sourceUsername,'
        'targetUsername: $targetUsername,'

        'amountMoney: $amountMoney,'
        'transactionTime: $transactionTime,'
        'reminderTime: $reminderTime,'
        'reminderTime: $reminderTime,'
        '}';
  }
}
