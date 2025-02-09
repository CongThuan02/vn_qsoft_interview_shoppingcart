import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:vn_qsoft_interview_shoppingcart/logic/bloc/cart/cart_bloc.dart';
import 'package:vn_qsoft_interview_shoppingcart/presentation/views/cart/cart_screen.dart';

import '../../../data/fake_data.dart';
import '../../../widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InfiniteScrollController controller = InfiniteScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(top: 40),
      top: true,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
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
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                    title: const Text(
                      'Home ',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
                        },
                        child: SizedBox(
                          width: 50,
                          height: 35,
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              (state.totalItem != null && state.totalItem != 0)
                                  ? Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.deepOrangeAccent,
                                            border: Border.all(color: Colors.white),
                                            // borderRadius: BorderRadius.circular(50.0),
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: Text(
                                          "${state.totalItem}",
                                          style: const TextStyle(fontSize: 12, color: Colors.white),
                                        )),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "HOT Products",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: FakeData().data.length,
                          itemBuilder: (context, index) {
                            return FakeData().data[index].isHost == true
                                ? Row(
                                    children: [
                                      ItemWidget(
                                        itemModel: FakeData().data[index],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "ALL Products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: FakeData().data.length,
                          itemBuilder: (context, index) {
                            return ItemWidget(
                              itemModel: FakeData().data[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
