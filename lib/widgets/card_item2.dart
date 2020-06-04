import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem2 extends StatefulWidget {
  CardItem2(
      {this.date,
      this.time,
      this.userName,
      this.mobileNumber,
      this.orderPrice,
      this.orderName,
      this.rating,
      this.noOfOrders,
      this.orderId,
      });
  final String rating;
  final String noOfOrders;
  final String userName;
  final String time;
  final String date;
  final String mobileNumber;
  final String orderName;
  final String orderPrice;
  final String orderId;

  @override
  _CardItem2State createState() => _CardItem2State();
}

class _CardItem2State extends State<CardItem2> {
  var isDone = false;

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 0.24 * totalHeight,
      decoration:  const BoxDecoration(
        color: Color(0xffE1DBCB),
        borderRadius: BorderRadius.all(Radius.circular(50)),),
        child: Container(
          padding: EdgeInsets.only(top: 0.02 * totalWidth , left: 0.09 * totalWidth , right: 0.09 * totalWidth , bottom: 0.04 * totalWidth),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child:  const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.person,
                    color: Color(0xff5B392D),
                    size: 35,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            style: const TextStyle(
                                color: Color(0xff5B392D),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            text: 'Name: ${widget.userName}'),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Date: ${widget.date}',
                      style:  const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff5B392D),
                      ),
                    ),
                    Text(
                      'Time: ${widget.time}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff5B392D),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'ZamanDetails', arguments: {
                      'userName' :  widget.userName,
                      'mobileNumber' : widget.mobileNumber,
                      'orderName' : widget.orderName,
                      'orderPrice' : widget.orderPrice,
                      'noOfOrders' : widget.noOfOrders,
                      'rating' : widget.rating,
                      'orderId' : widget.orderId,
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                        color: Colors.red, width: 3), // Color(0xff5B392D)
                  ),
                  child: const Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
