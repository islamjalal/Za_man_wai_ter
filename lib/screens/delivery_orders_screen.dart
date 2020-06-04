import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/card_item1.dart';


class DeliveryOrdersScreen extends StatefulWidget {
  @override
  _DeliveryOrdersScreenState createState() => _DeliveryOrdersScreenState();
}

class _DeliveryOrdersScreenState extends State<DeliveryOrdersScreen> {
 var isInit = true ;
 var isLoading = false ;

  @override
  void didChangeDependencies()async {
    if(isInit){
      setState(() {
        isLoading = true;
      });
      await Provider.of<Orders>(context).getDeliveryOrders().catchError((error){
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
    isInit = false ;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
   final ordersData = Provider.of<Orders>(context,listen: true);
   final totalWidth = MediaQuery.of(context).size.width ;
   final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:  const Color(0xffD5BE9F),
      body: isLoading ?  const Center(child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),) : Container(
        width: totalWidth,
        height: totalHeight,
        padding: EdgeInsets.only( right: 0.04*totalWidth , left: 0.03*totalWidth ),
        decoration:  const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/notificationlist1.png',),
            fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 0.18*totalHeight,
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('NotificationsScreen');
                    },
                    child: SizedBox(
                      height: 0.13*totalHeight,
                    ),
                    padding: EdgeInsets.all(0),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.80*totalHeight,
              child: ListView.builder(
                itemCount: ordersData.deliveryOrders.length ,
                itemBuilder: (_, i) => Column(
                  children: <Widget>[
                    CardItem1(
                      noOfOrders: ordersData.deliveryOrders[i].noOfOrders,
                      rating: ordersData.deliveryOrders[i].rating,
                      date: ordersData.deliveryOrders[i].orderDate ,
                      time: ordersData.deliveryOrders[i].orderTime,
                      userName: ordersData.deliveryOrders[i].userName ,
                      orderName: ordersData.deliveryOrders[i].orderName,
                      mobileNumber: ordersData.deliveryOrders[i].userMobileNumber,
                      orderPrice: ordersData.deliveryOrders[i].orderPrice,
                      orderId: ordersData.deliveryOrders[i].orderId,
                    ),
                    Divider(),
                  ],
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
