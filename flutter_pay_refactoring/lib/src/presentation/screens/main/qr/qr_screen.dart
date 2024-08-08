import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/detail_layout.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    // context.go(PaymentRoute.path);
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      log(scanData.toString());
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DetailLayout(
      appBarTitle: "QR VIEW",
      onLeadingPressed: () => context.go(HomeRoute.path),
      child: Column(
        children: <Widget>[
          Expanded(
            // flex: 12,
            child: _buildQRView(
              context,
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Container(
            color: AppColor.black,
            // height: ,
            child: Row(
              children: [
                TextButton(
                  // onPressed: () async => controller?.pauseCamera(),
                  onPressed: () {
                    context.go(PaymentRoute.path);
                  },
                  child: const Text(" || "),
                ),
                TextButton(
                  onPressed: () async => controller?.resumeCamera(),
                  child: const Text(" > "),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRView(
    BuildContext context, {
    required GlobalKey key,
    required void Function(QRViewController) onQRViewCreated,
  }) {
    var scanArea = context.width * 0.7;
    return QRView(
      key: key,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: AppColor.primary,
        borderRadius: 16,
        borderLength: scanArea / 8,
        borderWidth: 8,
        cutOutSize: scanArea,
      ),
      // onPermissionSet: ,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
