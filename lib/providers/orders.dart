import 'dart:convert';
import '../models/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class Order {
  Order(
      {this.userMobileNumber,
      this.rating,
      this.orderPrice,
      this.orderName,
      this.orderDate,
      this.orderTime,
      this.noOfOrders,
      this.userName,
      this.orderId});
  final String orderDate;
  final String orderTime;
  final String orderName;
  final String orderPrice;
  final String rating;
  final String userName;
  final String userMobileNumber;
  final String noOfOrders;
  final String orderId;
}



class Orders with ChangeNotifier {


  List<Order> _deliveryOrders = [];

  List<Order> get deliveryOrders {
    return [..._deliveryOrders];
  }


  List<Order> _zamanOrders = [];

  List<Order> get zamanOrders {
    return [..._zamanOrders];
  }


  Future<void> getZamanOrders() async {
    const url = 'https://zaman-8acf7.firebaseio.com/zamanOrders.json';
    try {
      final response = await http.get(url);
     // print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Order> loadedOrders = [];

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          Order(
            orderName: orderData['orderName'],
            orderPrice: orderData['orderPrice'],
            orderDate: orderData['orderDate'],
            orderTime: orderData['orderTime'],
            userName: orderData['userName'],
            userMobileNumber: orderData['userMobilNumber'],
            rating: orderData['rating'],
            noOfOrders: orderData['noOfOrders'],
            orderId: orderId,
          ),
        );
      });

      _zamanOrders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> getDeliveryOrders() async {
    const url = 'https://zaman-8acf7.firebaseio.com/deliveryOrders.json';
    try {
      final response = await http.get(url);
      // print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Order> loadedOrders = [];

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          Order(
            orderName: orderData['orderName'],
            orderPrice: orderData['orderPrice'],
            orderDate: orderData['orderDate'],
            orderTime: orderData['orderTime'],
            userName: orderData['userName'],
            userMobileNumber: orderData['userMobilNumber'],
            rating: orderData['rating'],
            noOfOrders: orderData['noOfOrders'],
            orderId: orderId,
          ),
        );
      });

      _deliveryOrders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future <void> deleteZamanOrders(String orderId) async {
    final url = 'https://zaman-8acf7.firebaseio.com/zamanOrders/$orderId.json';
   try { final existingOrderIndex = _zamanOrders.indexWhere((order) => order.orderId == orderId);
    print(existingOrderIndex);
    var existingOrder = _zamanOrders[existingOrderIndex];
    _zamanOrders.removeAt(existingOrderIndex);
    notifyListeners();
    final response =  await http.delete(url);
    if (response.statusCode >= 400) {
      _zamanOrders.insert(existingOrderIndex, existingOrder);
      notifyListeners();
      throw HttpException('Could not delete Order.');
    }
    existingOrder = null; } catch (error){
     throw error ;
   }
  }

 Future <void> deleteDeliveryOrders(String orderId) async {
    final url = 'https://zaman-8acf7.firebaseio.com/deliveryOrders/$orderId.json';
    try { final existingOrderIndex = _deliveryOrders.indexWhere((order) => order.orderId == orderId);
    var existingOrder = _deliveryOrders[existingOrderIndex];
    _deliveryOrders.removeAt(existingOrderIndex);
    notifyListeners();
   final response =  await http.delete(url);
    if (response.statusCode >= 400) {
      _deliveryOrders.insert(existingOrderIndex, existingOrder);
      notifyListeners();
      throw HttpException('Could not delete Order.');
    }
    existingOrder = null;  } catch (error){
      throw error ;
    }
  }
}

