import 'package:dolycoffee/consts/global_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../consts/app_constants.dart';

class MyDrawer extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    void _logout() {
      box.erase();
      Get.offAllNamed(Appconstants.splashroute);
    }
    return Drawer(
      width: size.width * .7,
      backgroundColor: homescafold_color,
      child: Column(
        children: [
          Container(
              height: size.height * .35,
              child: Image.asset(
                'images/cats/coffe_ic.jpg',
                fit: BoxFit.fill,
              )),
          kSizedBox,
          kSizedBox,
          InkWell(
              onTap: () => Get.toNamed(Appconstants.homeroute),
              child: buildrawertile(context, "Trang chủ", Icons.home_filled)),
          InkWell(
              onTap: () => Get.toNamed(Appconstants.contactroute),
              child: buildrawertile(context, "Liên hệ với chúng tôi", Icons.contact_page)),
          InkWell(
              onTap: () => Get.toNamed(Appconstants.cartroute),
              child: buildrawertile(context, "Giỏ hàng", Icons.shopping_cart)),
          InkWell(
              onTap: () => _logout(),
              child: buildrawertile(context, "Đăng xuất", Icons.logout)),
        ],
      ),
    );
  }
}

Widget buildrawertile(BuildContext context, String title, IconData title_ic) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
    //  color: Colors.brown.shade100,
    margin: EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
        ),
        Icon(title_ic)
      ],
    ),
  );
}
