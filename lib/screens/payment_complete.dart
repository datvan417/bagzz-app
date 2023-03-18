import '../screens/my_orders_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class PaymentComplete extends StatelessWidget {
  static const routeName = '/payment-complete';
  const PaymentComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7 -
              MediaQuery.of(context).padding.top,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 62.0),
                child:
                    Image.asset('assets/images/complete_payment/Payment.png'),
              ),
              Text(
                'Payment Completed',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: const Color(0XFF383838),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 0)),
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonNav(
                        context,
                        const Color(0XFFDFB23F),
                        Colors.white,
                        () => Navigator.pushReplacementNamed(
                              context,
                              HomePage.routeName,
                            ),
                        'Home',
                        const Icon(Icons.home)),
                    const SizedBox(width: 15.0),
                    buttonNav(
                      context,
                      Colors.white,
                      const Color(0XFFDFB23F),
                      () => Navigator.pushReplacementNamed(
                        context,
                        MyOrdersScreen.routeName,
                      ),
                      'History',
                      const Icon(
                        Icons.history,
                        color: Color(0XFFDFB23F),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

ElevatedButton buttonNav(BuildContext context, Color backgroundColor,
    Color textColor, Function fct, String label, Icon icon) {
  return ElevatedButton(
    style:
        ButtonStyle(backgroundColor: MaterialStatePropertyAll(backgroundColor)),
    onPressed: fct as Function(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10.0),
          Text(
            label,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: textColor, fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
