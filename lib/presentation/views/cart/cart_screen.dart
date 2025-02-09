import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vn_qsoft_interview_shoppingcart/logic/bloc/cart/cart_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/views/home_screen/home_screen.dart';

import '../../../widgets/button_widget.dart';
import '../../../widgets/item_add.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController numberItemController = TextEditingController();

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(
        child: Text(
          "Order successfully!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return ButtonWidget(
            onTap: () {
              context.read<CartBloc>().add(const Order());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            title: "Back to Home",
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 40),
      top: true,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total price"),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${NumberFormat('#,###').format(state.totalAmount)} ",
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
                  ButtonWidget(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    title: 'Order',
                  )
                ],
              ),
            ),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    'Cart ${(state.totalItem != null && state.totalItem != 0) ? "( ${state.totalItem} )" : ""}  ',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  if (state.totalItem == null)
                    ...{}
                  else ...{
                    for (int i = 0; i < state.listItemInCart!.length; i++) ...{
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ItemAdd(
                            totalItem: state.listItemInCart![i].quantity,
                            itemModel: state.listItemInCart![i],
                            isCart: true,
                            // numberItemController: numberItemController,
                          ),
                        ),
                      )
                    }
                  }
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
