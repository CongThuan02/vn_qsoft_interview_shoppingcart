part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class AddProductToggle extends CartEvent {
  final ItemModel item;

  final int quantity;

  const AddProductToggle({
    required this.item,
    required this.quantity,
  });

  AddProductToggle copyWith({
    int? totalItem,
    ItemModel? item,
    int? quantity,
  }) {
    return AddProductToggle(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [item, quantity];
}

class AddItemForCart extends CartEvent {
  final ItemModel item;

  const AddItemForCart({
    required this.item,
  });

  AddItemForCart copyWith({
    int? totalItem,
    ItemModel? item,
    int? quantity,
  }) {
    return AddItemForCart(
      item: item ?? this.item,
    );
  }

  @override
  List<Object?> get props => [item];
}

class RemoveItemForCart extends CartEvent {
  final ItemModel item;

  const RemoveItemForCart({
    required this.item,
  });

  RemoveItemForCart copyWith({
    ItemModel? item,
  }) {
    return RemoveItemForCart(
      item: item ?? this.item,
    );
  }

  @override
  List<Object?> get props => [item];
}

class DeleteItemInCart extends CartEvent {
  final ItemModel item;

  const DeleteItemInCart({
    required this.item,
  });

  DeleteItemInCart copyWith({
    ItemModel? item,
  }) {
    return DeleteItemInCart(
      item: item ?? this.item,
    );
  }

  @override
  List<Object?> get props => [item];
}

class UpdateItemQuantity extends CartEvent {
  final ItemModel item;
  final int quantity;

  const UpdateItemQuantity({
    required this.item,
    required this.quantity,
  });

  UpdateItemQuantity copyWith({
    ItemModel? item,
    int? quantity,
  }) {
    return UpdateItemQuantity(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [item, quantity];
}

class Order extends CartEvent {
  const Order();

  @override
  List<Object> get props => [];
}
