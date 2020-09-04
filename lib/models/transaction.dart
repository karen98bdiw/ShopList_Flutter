class Transaction {
  final String id = DateTime.now().toString();
  final String title;
  final double price;
  final DateTime date;

  Transaction(this.title, this.price, this.date);
}
