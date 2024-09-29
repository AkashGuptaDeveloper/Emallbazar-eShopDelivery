import 'package:deliveryboy_multivendor/Helper/color.dart';
import 'package:deliveryboy_multivendor/Helper/constant.dart';
import 'package:flutter/material.dart';

class CommanButton extends StatelessWidget {
  final bool selected;
  final String title;
  const CommanButton({
    Key? key,
    required this.selected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    );
  }
}
