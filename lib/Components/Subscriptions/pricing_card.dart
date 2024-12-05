import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final String label;
  final String planName;
  final String price;
  final String iconUrl;
  final String selectedItem;

  const PricingCard({
    Key? key,
    required this.label,
    required this.planName,
    required this.price,
    required this.iconUrl, required this.selectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF095DEC),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(15, 23, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF095DEC),
                      fontSize: 14,
                      height: 1,
                      letterSpacing: -0.28,
                    ),
                    semanticsLabel: '$label plan',
                  ),
                  Text(
                    planName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      height: 1,
                    ),
                  ),
                ],
              ),
              planName == selectedItem?
              cachedImage(
                iconUrl,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ) : SizedBox(),
            ],
          ),
          sizeHeight15,
          Text(
            price,
            style: const TextStyle(
              color: Color(0xFF393939),
              fontSize: 16,
              letterSpacing: -0.32,
            ),
          ),
        ],
      ),
    );
  }
}