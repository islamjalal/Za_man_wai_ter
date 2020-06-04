import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });


      await Future.wait([
        Provider.of<Orders>(context, listen: false).getDeliveryOrders(),
        Provider.of<Orders>(context, listen: false).getZamanOrders()
      ]).catchError((error) {
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
                      'تحقق من وجود انترنت أولا',
                      textAlign: TextAlign.center,
                    ),
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
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor:  const Color(0xffD5BE9F),
      body: isLoading
          ? Center(
              child:  const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            )
          : Container(
              width: totalWidth,
              height: totalHeight,
              decoration:  const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/notifications.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 0.34 * totalHeight,
                ), //  bottom: 0.3 * totalHeight
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed('ZamanOrdersScreen');
                          },
                          child: Container(
                              height: 0.36 * totalHeight,
                              width: 0.438 * totalWidth,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: 0.018 * totalHeight,
                                    left: 0.07 * totalWidth,
                                    bottom: 0.3 * totalHeight,
                                    right: 0.28 * totalWidth),
                                child: Consumer<Orders>(
                                  builder: (context, orders, child) => Center(
                                    child: Text(
                                      '${orders.zamanOrders.length}',
                                      style: const TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  child: null,
                                ),
                              )),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('DeliveryOrdersScreen');
                            },
                            child: Container(
                              height: 0.36 * totalHeight,
                              width: 0.438 * totalWidth,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0176 * totalHeight,
                                      left: 0.1 * totalWidth,
                                      bottom: 0.3 * totalHeight,
                                      right: 0.24 * totalWidth),
                                  child: Consumer<Orders>(
                                    builder: (context, orders, child) {
                                      return Center(
                                        child: Text(
                                          '${orders.deliveryOrders.length}',
                                          style:  const TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    },
                                    child: null,
                                  )),
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.08*totalHeight),
                      child: FlatButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, 'NotificationsScreen');
                        },
                        child:  const Icon(Icons.refresh , size: 70, color: Color(0xffA65D30), ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
