import 'package:flutter/widgets.dart';
import 'package:sketch_pay/src/shared/utils/image_util.dart';
import 'package:sketch_pay/src/shared/utils/path_util.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageUtil.showImage('assets/images/loading.json');
  }
}
