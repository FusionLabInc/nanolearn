import 'package:flutter/widgets.dart';

void changeFocuNode({
  FocusNode? from,
  FocusNode? to,
  required BuildContext context,
}) {
  from!.unfocus();
  FocusScope.of(context).requestFocus(to);
}
