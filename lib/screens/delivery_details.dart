import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  var isInit = true;
  var isLoading = false;
  var checked = false;


  Future removeDialogue (context) async {
    await Future.delayed(const Duration(seconds: 0));
    Navigator.of(context).pop();
  }

  Future deleteStage (orderId , orderData) async {
    await Future.delayed(const Duration(seconds: 0));
    orderData.deleteDeliveryOrders(orderId);
  }


  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    final data = ModalRoute.of(context).settings.arguments as Map<String , dynamic>;
    return Scaffold(
      backgroundColor:  const Color(0xffD5BE9F),
      body: isLoading ?  const Center(child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      )) : Container(
        width: totalWidth,
        height: totalHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/deliverydetails.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
              top: 0.37 * totalHeight,
              right: 0.05 * totalWidth,
              left: 0.08 * totalWidth),
          child: Column(
            children: <Widget>[
              Container(
                height: 0.45 * totalHeight,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style:  const TextStyle(
                              color: Color(0xff5B392D),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Name: ',
                            ),
                            TextSpan(
                              text: '${data['userName']}',
                              style:  const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style:  const TextStyle(
                            color: Color(0xff5B392D),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mobile Number:  ',
                          ),
                          TextSpan(
                            text: '${data['mobileNumber']}',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style:  const TextStyle(
                            color: Color(0xff5B392D),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Meal:  ',
                          ),
                          TextSpan(
                            text: '${data['orderName']}',
                            style:  const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style:  const TextStyle(
                                color: Color(0xff5B392D),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Price: ',
                              ),
                              TextSpan(
                                text: '${data['orderPrice']} LE',
                                style:  const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 0.05*totalWidth,
                        ),
                        RichText(
                          text: TextSpan(
                            style:  const TextStyle(
                                color: Color(0xff5B392D),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${data['noOfOrders']}',
                              ),
                              TextSpan(
                                text: 'X',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style:  const TextStyle(
                            color: Color(0xff5B392D),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Rating:  ',
                          ),
                          TextSpan(
                            text: '${data['rating']}',
                            style:  const TextStyle(color: Colors.red),
                          ),
                          TextSpan(
                            text: '/5.0',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.09 * totalHeight,
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: 0.32 * totalWidth,
                    ),
                  ),
                  SizedBox(
                    width: 0.17 * totalWidth,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        checked = !checked;
                      });
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

                                  content:  const Text(
                                    'سيتم حذف الطلب من قائمة الإنتظار .. هل توافق ؟' , textAlign: TextAlign.center, style: TextStyle(fontSize: 22), ),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[

                                        FlatButton(
                                          child: Text('لا',style:  const TextStyle(
                                              fontSize: 20 , color: Colors.black
                                          ),),
                                          onPressed: () {
                                            setState(() {
                                              checked = !checked;
                                            });
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        SizedBox(width: 0.17*totalWidth,),
                                        Consumer<Orders>(
                                          builder:(context , orderData , _) => FlatButton(
                                            child: Text('نعم',style:  const TextStyle(
                                                fontSize: 20 , color: Colors.black
                                            ),),
                                            onPressed: () async {
                                              setState(() {
                                                isLoading = true ;
                                              });
                                              await Future.wait  ( [ removeDialogue(context) , deleteStage(data['orderId'], orderData)] ).then((_){
                                                setState(() {
                                                  isLoading = false ;
                                                });
                                              });

                                              Navigator.of(context).pushReplacementNamed('DeliveryOrdersScreen');
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.09*totalWidth,
                                        ),
                                      ],
                                    )

                                  ],
                                ),
                              ),
                            );
                          },
                          transitionDuration: Duration(milliseconds: 600),
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (context, animation1, animation2) {});
                    },
                    icon: checked
                        ? Icon(
                            Icons.check_circle,
                            size: 30,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.radio_button_unchecked,
                            size: 30,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
