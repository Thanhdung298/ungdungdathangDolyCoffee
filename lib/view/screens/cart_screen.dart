import 'package:dolycoffee/consts/global_constants.dart';
import 'package:dolycoffee/controllers/order_controller.dart';
import 'package:dolycoffee/view/widgets/cartitem_card_widget.dart';
import 'package:dolycoffee/view/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  late CartController controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    controller = Get.find<CartController>();
    // OrderController _ordercontroller = Get.put(OrderController());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: homescafold_color,
      drawerScrimColor: Colors.black54,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: appbartitle_color,
        title: const Text("Giỏ hàng"),
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: Icon(
            Icons.sort,
            size: 35.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Obx(
              () =>
          controller.cart.isEmpty
              ? const Center(
            child: Text("Giỏ hàng của bạn đang trống"),
          )
              : Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.cart.length,
                    separatorBuilder: (_, __) => Divider(),
                    itemBuilder: (context, index) {
                      return CartItemCard(
                        drink: controller.cart[index],
                        index: index,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Tổng thanh toán : ${NumberFormat.currency(
                          decimalDigits: 0,
                          symbol: '',
                        ).format(
                          controller.grandTotal.value,
                        )} vnđ",
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _confirmationDialog();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: authbackcolor),
                        child: Center(
                          child: Text(
                            "Thanh toán",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmationDialog() {
    Get.defaultDialog(
      title: "Tổng hoá đơn",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () {
              Get.back();
            },
            child: Text("Huỷ")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow)),
            onPressed: () {
              controller.transactionCompleted();
            },
            child: Text(
              "Đồng ý",
              style: TextStyle(color: Colors.black),
            ))
      ],
      backgroundColor: Color(0xff4D4D4D),
      titleStyle: TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            height: 200,
            child: ListView.separated(
              separatorBuilder: (_, i) => Divider(),
              itemCount: controller.cart.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(controller.cart[index].icon))),
                  ),
                  title: Text(
                    controller.cart[index].name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  subtitle: Text(
                        NumberFormat.currency(decimalDigits: 0, symbol: '')
                            .format(controller.cart[index].price) + " vnđ" +
                        " x " +
                        controller.cart[index].qty.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // Text(
          //   controller.userSession["name"],
          //   style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 14),
          // ),
          // SizedBox(
          //   height: 5,
          // ),
          // Text(
          //   controller.userSession["email"],
          //   style: TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 14),
          // ),
          // SizedBox(
          //   height: 5,
          // ),
          Text(
            "Tổng tiền: " +
                NumberFormat.currency(decimalDigits: 0, symbol: '')
                    .format(controller.grandTotal.value) + " vnđ",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          )
        ],
      ),
    );
  }
}
