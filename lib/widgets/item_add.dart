import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vn_qsoft_interview_shoppingcart/data/models/item.dart';
import 'package:vn_qsoft_interview_shoppingcart/logic/bloc/cart/cart_bloc.dart';

import '../logic/bloc/validate/validate_bloc.dart';
import 'button_widget.dart';

class ItemAdd extends StatefulWidget {
  final bool isCart;
  final int? totalItem;
  final ItemModel itemModel;

  const ItemAdd({super.key, this.isCart = false, required this.itemModel, this.totalItem});

  @override
  State<ItemAdd> createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
  final TextEditingController numberItemController = TextEditingController();
  int numberItemNew = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isCart == true ? numberItemController.text = widget.totalItem.toString() : numberItemController.text = "1";
  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          widget.itemModel.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: BlocBuilder<ValidateBloc, ValidateState>(
        builder: (context, state) {
          return BlocBuilder<CartBloc, CartState>(
            builder: (contextCard, stateCard) {
              return SizedBox(
                height: 150,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        context.read<ValidateBloc>().add(ValidateNumber(value));
                        if (state.isError == false) {
                          setState(() {
                            numberItemNew = int.parse(value);
                          });
                        }
                      },
                      textAlign: TextAlign.center,
                      controller: numberItemController,
                      decoration: InputDecoration(
                        errorText: state.isError == true ? state.message : null,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.orangeAccent,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ButtonWidget(
                      isEnable: !state.isError!,
                      title: "Submit",
                      onTap: () {
                        if (state.isError == false) {
                          if (widget.isCart == true) {
                            contextCard.read<CartBloc>().add(UpdateItemQuantity(item: widget.itemModel, quantity: numberItemNew));
                          }
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Removed the Expanded widget here
            children: [
              SizedBox(
                height: widget.isCart == false ? 20 : 0,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.itemModel.urlImage,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.itemModel.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.isCart == false
                                    ? Navigator.pop(context)
                                    : context.read<CartBloc>().add(
                                          DeleteItemInCart(
                                            item: widget.itemModel,
                                          ),
                                        );
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      widget.isCart == false
                                          ? setState(() {
                                              numberItemController.text = (int.parse(numberItemController.text) - 1).toString();
                                            })
                                          : context.read<CartBloc>().add(
                                                RemoveItemForCart(
                                                  item: widget.itemModel,
                                                ),
                                              );
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(border: Border(right: BorderSide(color: Colors.grey))),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                                    child: GestureDetector(
                                      onTap: () => showAlertDialog(context),
                                      child: Text(widget.isCart == false ? numberItemController.text : widget.itemModel.quantity.toString()),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.isCart == false
                                          ? setState(() {
                                              numberItemController.text = (int.parse(numberItemController.text) + 1).toString();
                                            })
                                          : context.read<CartBloc>().add(
                                                AddItemForCart(
                                                  item: widget.itemModel,
                                                ),
                                              );
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.grey))),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: NumberFormat('#,###').format(widget.itemModel.price).toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "đ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrangeAccent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.deepOrangeAccent,
                                      decorationThickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: widget.isCart == false ? 50 : 0,
              ),
              widget.isCart == false
                  ? ButtonWidget(
                      onTap: () {
                        context.read<CartBloc>().add(AddProductToggle(item: widget.itemModel, quantity: int.parse(numberItemController.text)));
                        Navigator.pop(context);
                      },
                      title: 'Add to cart',
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}
