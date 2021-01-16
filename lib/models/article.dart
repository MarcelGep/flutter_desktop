class Article {
  String id;
  String name;
  double price;
  int amount;
  String unit;

  Article(this.id, this.name, this.price, this.amount, this.unit);

  Article.fromMap(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.price = obj['price'];
    this.amount = obj['amount'];
    this.unit = obj['unit'];
  }

  Map<String, dynamic> toMap() {
    var obj = new Map<String, dynamic>();
    obj['id'] = id;
    obj['name'] = name;
    obj['price'] = price;
    obj['amount'] = amount;
    obj['unit'] = unit;
    return obj;
  }

  Article.emptyArticle() {
    this.id = "";
    this.name = "";
    this.price = 0.0;
    this.amount = 1;
    this.unit = "";
  }
}
