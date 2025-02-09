import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/models/item.dart';
import 'item_add.dart';

class ItemWidget extends StatefulWidget {
  final ItemModel itemModel;

  const ItemWidget({super.key, required this.itemModel});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ItemAdd(
          // numberItemController: numberItemController,
          itemModel: widget.itemModel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.33,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 2.0, // Độ dày của viền
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    widget.itemModel.urlImage,
                  ),
                  widget.itemModel.isHost == true
                      ? Positioned(
                          top: 5,
                          left: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.white),
                              width: 30,
                              height: 30,
                              child: const Icon(
                                Icons.local_fire_department_outlined,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemModel.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${NumberFormat('#,###').format(widget.itemModel.price)} ",
                              style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.deepOrangeAccent),
                            ),
                            const TextSpan(
                              text: "đ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
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
                  GestureDetector(
                    onTap: () => _showBottomSheet(context),
                    child: const Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
