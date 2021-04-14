class Cart {
  String token;
  String itemId;
  String size;
  String color;
  String qut;
  int id;

  Cart({this.token, this.itemId, this.size, this.color, this.qut, this.id});

  Cart.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    itemId = json['item_id'];
    size = json['size'];
    color = json['color'];
    qut = json['qut'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['item_id'] = this.itemId;
    data['size'] = this.size;
    data['color'] = this.color;
    data['qut'] = this.qut;
    data['id'] = this.id;
    return data;
  }
}


