import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/card_item2.dart';

class ZamanOrdersScreen extends StatefulWidget {
  @override
  _ZamanOrdersScreenState createState() => _ZamanOrdersScreenState();
}

class _ZamanOrdersScreenState extends State<ZamanOrdersScreen> {
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Orders>(context).getZamanOrders().catchError((error) {
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    backgroundColor: const Color(0xffECC53C),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text(
                      'تحقق من وجود انترنت أولا' , textAlign: TextAlign.center, ),
                    content: null,
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 600),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
      });
    }
    setState(() {
      isLoading = false;
    });
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context,listen: true);
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:  const Color(0xffD5BE9F),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Container(
              width: totalWidth,
              height: totalHeight,
              padding: EdgeInsets.only( right: 0.04*totalWidth , left: 0.03*totalWidth ),
              decoration:  const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/notificationlist2.png',
                    ),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 0.18 * totalHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('NotificationsScreen');
                          },
                          child: SizedBox(
                            height: 0.13 * totalHeight,
                          ),
                          padding: EdgeInsets.all(0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.80 * totalHeight,
                    child: ListView.builder(
                      itemCount: ordersData.zamanOrders.length,
                      itemBuilder: (_, i) => Column(
                        children: <Widget>[
                          CardItem2(
                            rating: ordersData.zamanOrders[i].rating,
                            noOfOrders: ordersData.zamanOrders[i].noOfOrders,
                            date: ordersData.zamanOrders[i].orderDate,
                            time: ordersData.zamanOrders[i].orderTime,
                            userName: ordersData.zamanOrders[i].userName,
                            orderName: ordersData.zamanOrders[i].orderName,
                            mobileNumber: ordersData.zamanOrders[i].userMobileNumber,
                            orderPrice: ordersData.zamanOrders[i].orderPrice,
                            orderId: ordersData.zamanOrders[i].orderId,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
