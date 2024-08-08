import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sketch_pay/src/presentation/screens/main/home/widgets/point_card.dart';
import 'package:sketch_pay/src/presentation/screens/main/payment/widgets/monetary_info_card.dart';
import 'package:sketch_pay/src/presentation/screens/main/payment/widgets/product_info_card.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/detail_layout.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      color: AppColor.backGround,
      onLeadingPressed: () => context.go(HomeRoute.path),
      appBarTitle: context.currentPath.toString().replaceAll('/', ''),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: <Widget>[
            _pointCard(context, constraints),
            _productInfoCard(context, constraints),
            _paymentButton(context, constraints,
                onPressed: () => context.go(PinCheckRoute.path)),
          ],
        ),
      ),
    );
  }

  ConstrainedBox _pointCard(BuildContext context, BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight / 4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(constraints.minWidth / 16),
          bottomRight: Radius.circular(constraints.minWidth / 16),
        ),
        child: Container(
          color: AppColor.black,
          child: const MonetaryInfoCard(),
        ),
      ),
    );
  }

  ConstrainedBox _productInfoCard(
      BuildContext context, BoxConstraints constraints) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight -
            (constraints.minHeight / 4) -
            (constraints.minHeight / 9),
      ),
      child: ProductInfoCard(
        constraintHeight: constraints.minHeight -
            (constraints.minHeight / 4) -
            (constraints.minHeight / 9),
        constraintWidth: constraints.minWidth,
      ),
    );
  }

  ConstrainedBox _paymentButton(
    BuildContext context,
    BoxConstraints constraints, {
    VoidCallback? onPressed,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: constraints.minHeight / 9,
      ),
      child: AppButton(
        label: "결제하기",
        labelColor: AppColor.black,
        onPressed: onPressed,
      ),
    );
  }
}
