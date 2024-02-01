import 'package:dolycoffee/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../consts/global_constants.dart';
import '../../controllers/coffee_controller.dart';
import '../widgets/greatday_widget.dart';
import '../widgets/drawer_widget.dart';
import 'package:dolycoffee/models/drink_model.dart';

class CoffeeScreen extends StatefulWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  @override
  State<CoffeeScreen> createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  final String title = "Coffee";
  late CoffeeController _coffeeController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _coffeeController = Get.find<CoffeeController>();
    OrderController _ordercontroller = Get.put(OrderController());
    return Scaffold(
      backgroundColor: authbackcolor,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: authbackcolor,
        elevation: 0.0,
        bottomOpacity: 0.0,
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          icon: Icon(
            Icons.sort,
            size: 35.0,
            color: Colors.black,
          ),
        ),
        actions: [
          // AnimatedSearchBar(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Coffee",
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontSize: 36.0,
                  ),
            ),
            kSizedBox,
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemBuilder: (ctx, i) => ListTile(
                    onTap: () {
                      _ordercontroller
                          .getCoffeeArgs(_coffeeController.getCoffeeList[i]);
                      _coffeeController.navigateToOrderScreen(i);
                    },
                    title: Text(
                      _coffeeController.getCoffeeList[i].name,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 24.0,
                                letterSpacing: 2.0,
                              ),
                    ),
                    subtitle: Text(
                      '${_coffeeController.getCoffeeList[i].price.toString()} vnđ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown,
                      child: Text(
                        '${i + 1}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: _coffeeController.getCoffeeList.length,
                ),
              ),
            ),
          ],
        ),
      ),
      drawerScrimColor: Colors.black54,
      drawer: MyDrawer(),
    );
  }
}
