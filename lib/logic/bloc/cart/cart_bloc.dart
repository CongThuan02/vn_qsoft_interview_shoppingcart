import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vn_qsoft_interview_shoppingcart/data/models/item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<ItemModel> listItemInCart = [];
  int totalItem = 0;
  double totalAmount = 0;
  CartBloc() : super(const CartState()) {
    on<AddProductToggle>(_itemAddWithToggle);
    on<AddItemForCart>(_itemCounter);
    on<DeleteItemInCart>(_itemDelete);
    on<RemoveItemForCart>(_itemRemove);
    on<UpdateItemQuantity>(_updateItemQuantity);
    on<Order>(_order);
  }

  void _itemAddWithToggle(AddProductToggle event, Emitter<CartState> emit) {
    bool isExist = listItemInCart.any((element) => element.id == event.item.id);
    if (isExist) {
      int index = listItemInCart.indexWhere((element) => element.id == event.item.id);
      listItemInCart[index] = listItemInCart[index].copyWith(quantity: listItemInCart[index].quantity + event.quantity);
    } else {
      var item = event.item.copyWith(quantity: event.quantity);
      listItemInCart.add(item);
    }
    totalItems();
    totalAmounts();
    emit(CartState(
      listItemInCart: listItemInCart,
      totalItem: totalItem,
      totalAmount: totalAmount,
    ));
  }

  void totalItems() {
    totalItem = 0;
    for (var item in listItemInCart) {
      totalItem = totalItem + item.quantity;
    }
  }

  void totalAmounts() {
    totalAmount = 0;
    for (var item in listItemInCart) {
      totalAmount = totalAmount + item.price * item.quantity;
    }
  }

  FutureOr<void> _itemCounter(AddItemForCart event, Emitter<CartState> emit) {
    bool isExist = listItemInCart.any((element) => element.id == event.item.id);
    if (isExist) {
      int index = listItemInCart.indexWhere((element) => element.id == event.item.id);
      listItemInCart[index] = listItemInCart[index].copyWith(quantity: listItemInCart[index].quantity + 1);
    } else {
      var item = event.item.copyWith(quantity: 1);
      listItemInCart.add(item);
    }
    totalItems();
    totalAmounts();
    emit(CartState(
      listItemInCart: listItemInCart,
      totalItem: totalItem,
      totalAmount: totalAmount,
    ));
  }

  FutureOr<void> _itemDelete(DeleteItemInCart event, Emitter<CartState> emit) {
    listItemInCart.removeWhere((element) => element.id == event.item.id);
    totalItems();
    totalAmounts();
    emit(CartState(
      listItemInCart: listItemInCart,
      totalItem: totalItem,
      totalAmount: totalAmount,
    ));
  }

  FutureOr<void> _itemRemove(RemoveItemForCart event, Emitter<CartState> emit) {
    bool isExist = listItemInCart.any((element) => element.id == event.item.id);
    if (isExist) {
      int index = listItemInCart.indexWhere((element) => element.id == event.item.id);
      if (listItemInCart[index].quantity > 1) {
        listItemInCart[index] = listItemInCart[index].copyWith(quantity: listItemInCart[index].quantity - 1);
      } else {
        listItemInCart.removeWhere((element) => element.id == event.item.id);
      }
    }
    totalItems();
    totalAmounts();
    emit(CartState(
      listItemInCart: listItemInCart,
      totalItem: totalItem,
      totalAmount: totalAmount,
    ));
  }

  FutureOr<void> _updateItemQuantity(UpdateItemQuantity event, Emitter<CartState> emit) {
    bool isExist = listItemInCart.any((element) => element.id == event.item.id);
    if (isExist) {
      int index = listItemInCart.indexWhere((element) => element.id == event.item.id);
      listItemInCart[index] = listItemInCart[index].copyWith(quantity: event.quantity);
    }
    totalItems();
    totalAmounts();
    emit(CartState(
      listItemInCart: listItemInCart,
      totalItem: totalItem,
      totalAmount: totalAmount,
    ));
  }

  FutureOr<void> _order(Order event, Emitter<CartState> emit) {
    listItemInCart.clear();
    totalItems();
    totalAmounts();
    emit(CartState(
      listItemInCart: listItemInCart,
      totalItem: totalItem,
      totalAmount: totalAmount,
    ));
  }
}
