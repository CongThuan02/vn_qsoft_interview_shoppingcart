class ItemModel {
  final int id;
  final String name;
  final double price;
  final bool isHost;
  final String urlImage;
  final int quantity;

//<editor-fold desc="Data Methods">
  const ItemModel({
    this.quantity = 0,
    required this.id,
    required this.name,
    required this.price,
    required this.isHost,
    required this.urlImage,
  });

  ItemModel copyWith({
    final int? id,
    final String? name,
    final double? price,
    final bool? isHost,
    final String? urlImage,
    final int? quantity,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isHost: isHost ?? this.isHost,
      urlImage: urlImage ?? this.urlImage,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      quantity: map['quantity'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      isHost: map['isHost'] as bool,
      urlImage: map['urlImage'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'id': id,
      'name': name,
      'price': price,
      'isHost': isHost,
      'urlImage': urlImage,
    };
  }

//</editor-fold>
}
