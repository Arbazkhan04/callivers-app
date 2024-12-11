import 'package:calliverse/Components/widget_extensions.dart';
import 'package:calliverse/Constants/color.dart';
import 'package:calliverse/Constants/sizedbox.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Screens/BottomBar/bottom_bar.dart';
import 'package:calliverse/Widgets/appbar.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:calliverse/utils/app_common.dart';
import 'package:flutter/material.dart';

import '../../Components/Subscriptions/pricing_card.dart';
import '../../Constants/paths.dart';
import '../../modals/subscription_modal.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final List<SubscriptionItemModalClass> subscriptionPlans = [
    SubscriptionItemModalClass(
      label: "Basic Plan",
      planName: "Basic",
      price: "\$9.99/month",

      isSelected: false,
      features: [
        "Access to basic features",
        "Standard support",
        "1 user account",
      ],
    ),
    SubscriptionItemModalClass(
      label: "Standard Plan",
      planName: "Standard",
      price: "\$19.99/month",

      isSelected: false,
      features: [
        "Access to all basic features",
        "Priority support",
        "Up to 3 user accounts",
        "Monthly analytics reports",
      ],
    ),
    SubscriptionItemModalClass(
      label: "Premium Plan",
      planName: "Premium",
      price: "\$29.99/month",
      isSelected: false,
      features: [
        "Access to all features",
        "24/7 dedicated support",
        "Unlimited user accounts",
        "Advanced analytics and insights",
        "Custom integrations",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: '',
        leadIcon: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close,color: textColor,))
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.only(top: 16,right: 20,left: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Unlock All Features with Premium',
                      style: txtStyle22AndBold,
                    ),
                    sizeHeight20,
                    const PlanSelector(),
                    sizeHeight20,
                    Text(
                      'Select a plan',
                      style: txtStyle16AndOther,
                    ),
                    sizeHeight20,
                    SizedBox(
                      width: double.maxFinite,
                      height: 180,
                      child: GridView.builder(
                          itemCount: subscriptionPlans.length,
                          shrinkWrap: true,

                          scrollDirection: Axis.horizontal,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            // crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10
                          ),
                          itemBuilder: (context,index){
                            String selectedItem= "";
                            final item = subscriptionPlans[index];
                            return GestureDetector(
                              onTap: (){
                                selectedItem = subscriptionPlans[index].planName;
                              },
                              child: PricingCard(
                                label: item.label,
                                planName: item.planName,
                                price: item.price,
                                iconUrl: checkTickIcon,
                                selectedItem: selectedItem,
                              ),
                            );
                          }),
                    ),
                    sizeHeight20,
                    const FeatureList(),
                  ],
                ),
                sizeHeight20,
                Text(
                  'By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our Terms.',
                  style: txtStyle12AndOther,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                MyButton(
                  onPressed: () {
                    BottomBar().launch(context,isNewTask: true);

                  },
                    text: 'Continue',
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      BottomBar().launch(context,isNewTask: true);

                    },
                    child: const Text(
                      'Start Free Trial',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mulish',
                        color: Color(0xFF095DEC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PlanSelector extends StatefulWidget {
  const PlanSelector({Key? key}) : super(key: key);

  @override
  State<PlanSelector> createState() => _PlanSelectorState();
}

class _PlanSelectorState extends State<PlanSelector> {
  bool isMonthly = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FC),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMonthly = true),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isMonthly ? const Color(0xFF095DEC) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Monthly',
                  style: TextStyle(
                    color: isMonthly ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isMonthly = false),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isMonthly ? const Color(0xFF095DEC) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Annually',
                  style: TextStyle(
                    color: !isMonthly ? Colors.white : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class FeatureList extends StatelessWidget {
  const FeatureList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Column(
          children: [
            sizeHeight20,
            Container(
              // width: 140,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
              color: transparentColor,
                border: Border.all(color: const Color(0xFFBFBFBF)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFeatureItem('Lorem Ipsum'),
                  const SizedBox(height: 16),
                  _buildFeatureItem('Lorem Ipsum'),
                  const SizedBox(height: 16),
                  _buildFeatureItem('Lorem Ipsum'),
                ],
              ),
            ),
          ],
        ),
        Positioned(
            right: 0,
            left: 0,
            top: 03,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 90),
                // padding: const EdgeInsets.all(24),
                padding: EdgeInsets.symmetric(vertical: 6),
                // width: 20,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: const Color(0xFFBFBFBF)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Features",textAlign: TextAlign.center,style: txtStyle14AndOther,))),

      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        cachedImage(checkTickIcon, width: 24, height: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Color(0xFF393939),
            letterSpacing: -0.32,
          ),
        ),
      ],
    );
  }
}


class SubscriptionFooter extends StatelessWidget {
  const SubscriptionFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFFDADADA)),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via App Store settings, and you agree to our Terms.',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins',
              color: Color(0xFF545454),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF095DEC),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Start Free Trial',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Mulish',
                color: Color(0xFF095DEC),
              ),
            ),
          ),
          Container(
            height: 5,
            width: 139,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1B1F),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}