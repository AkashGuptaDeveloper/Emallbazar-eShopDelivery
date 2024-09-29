import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Helper/color.dart';
import '../../../Helper/constant.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/parameterString.dart';

class GetHeading extends StatelessWidget {
  final Function update;
  GetHeading({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Container(
      decoration: DesignConfiguration.back(),
      padding:
          const EdgeInsets.only(left: 10.0, bottom: 10, top: 40, right: 10),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                // margin: const EdgeInsets.only(top: 10, right: 20),
                height: size / 5,
                width: size / 5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.0,
                    color: white,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(circularBorderRadius100),
                  child: Container(
                    height: size / 7,
                    width: size / 7,
                    child: Icon(
                      Icons.account_circle,
                      color: white,
                      size: size / 7,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CUR_USERNAME!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      maxLines: 1,
                      softWrap: false,
                    ),
                    Text(
                      EMAILID!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      maxLines: 1,
                      softWrap: false,
                    ),
                    // Text(
                    //   getTranslated(context, WALLET_BAL)! +
                    //       ": ${DesignConfiguration.getPriceFormat(context, double.tryParse(CUR_BALANCE) ?? 0.0)!}",
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .bodySmall!
                    //       .copyWith(color: white, fontSize: 14),
                    //   softWrap: true,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xffFFFFFF).withOpacity(0.3)),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        DesignConfiguration.setSvgPath('wallet'),
                      ),
                      Text(
                        DesignConfiguration.getPriceFormat(
                            context, double.tryParse(CUR_BALANCE) ?? 0.0)!,
                        // maxLines: 1,
                        // softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
