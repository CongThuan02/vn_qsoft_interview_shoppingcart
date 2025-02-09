part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<ItemModel>? listItemInCart;

  final double totalAmount;
  final int? totalItem;

//<editor-fold desc="Data Methods">
  const CartState({
    this.totalAmount = 0,
    this.totalItem,
    this.listItemInCart,
  });

  CartState copyWith({
    List<ItemModel>? listItemInCart,
    bool? isLoading,
    int? totalItem,
    double? totalAmount,
  }) {
    return CartState(
      listItemInCart: listItemInCart ?? this.listItemInCart,
      totalItem: totalItem ?? this.totalItem,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => [listItemInCart, totalItem, totalAmount];

//</editor-fold>
}
