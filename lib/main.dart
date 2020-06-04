import 'package:flutter/material.dart';
import './screens/notifications_screen.dart';
import './screens/delivery_orders_screen.dart';
import 'package:provider/provider.dart';
import './providers/orders.dart';
import './screens/zaman_orders_screen.dart';
import './screens/zaman_details.dart';
import './screens/delivery_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NotificationsScreen(),
        routes: {
          'DeliveryDetails': (context) => DeliveryDetails(),
          'ZamanDetails': (context) => ZamanDetails(),
          'NotificationsScreen': (context) => NotificationsScreen(),
          'DeliveryOrdersScreen': (context) => DeliveryOrdersScreen(),
          'ZamanOrdersScreen': (context) => ZamanOrdersScreen(),
        },
      ),
    );
  }
}


