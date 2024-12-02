import 'package:calliverse/Constants/paths.dart';
import 'package:calliverse/Constants/textStyle.dart';
import 'package:calliverse/Widgets/button.dart';
import 'package:flutter/material.dart';

import '../../utils/app_common.dart';

class CallListItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String timeAgo;

  const CallListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          CircleAvatar(
            radius: 29.5,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        txtStyle16AndBold.copyWith(
                  
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.asset(
                           missCallIcon,
                            width: 17,
                            height: 14,
                          ),
                          const SizedBox(width: 9),
                          Text(
                            timeAgo,
                            style: txtStyle12.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    CustomIconButton(
                      onPressed: (){},
                      icon: cachedImage(
                       videoCallIcon,
                        width: 25,
                        height: 25
                      ),
                    ),
                    // const SizedBox(width: 20),
                    CustomIconButton(
                      icon: cachedImage(
                        voiceCallIcon,
                        width: 25,
                        height: 25,
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}