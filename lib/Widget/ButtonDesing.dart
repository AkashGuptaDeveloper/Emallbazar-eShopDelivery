import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Helper/color.dart';
import '../Helper/constant.dart';

class SimBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onBtnSelected;
  final double sizePercentage;

  const SimBtn(
      {Key? key, this.title, this.onBtnSelected, required this.sizePercentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBtnAnimation(context);
  }

  Widget _buildBtnAnimation(BuildContext context) {
    return CupertinoButton(
      child: Container(
        width: MediaQuery.of(context).size.width * sizePercentage,
        height: 35,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [grad1Color, grad2Color],
            stops: [0, 1],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(circularBorderRadius10),
          ),
        ),
        child: Text(
          title!,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: white,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
      onPressed: () {
        onBtnSelected!();
      },
    );
  }
}

class AppBtn extends StatelessWidget {
  final String? title;
  final AnimationController? btnCntrl;
  final Animation? btnAnim;
  final VoidCallback? onBtnSelected;
  final double? width;
  final Color? color;
  final Color? textcolor;

  const AppBtn(
      {Key? key,
      this.title,
      this.btnCntrl,
      this.btnAnim,
      this.onBtnSelected,
      this.color,
      this.textcolor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildBtnAnimation,
      animation: btnCntrl!,
    );
  }

  Widget _buildBtnAnimation(BuildContext context, Widget? child) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          // width: btnAnim!.value,
          width: width != null ? width : MediaQuery.of(context).size.width,
          height: 45,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            color: color != null ? color : primary,
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [grad1Color, grad2Color],
            //   stops: [0, 1],
            // ),
            border: Border.all(
                color: textcolor != null ? black : Colors.transparent),
            borderRadius: BorderRadius.all(
              const Radius.circular(circularBorderRadius10),
            ),
          ),
          child: btnAnim!.value > 75.0
              ? Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: textcolor != null ? textcolor : white,
                        fontWeight: FontWeight.normal,
                      ),
                )
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(white),
                ),
        ),
        onPressed: () {
          onBtnSelected!();
        },
      ),
    );
  }
}
