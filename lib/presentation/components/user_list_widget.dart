import 'package:flutter/material.dart';
import 'package:talk_a_tive/core/app_colors.dart';
import 'package:talk_a_tive/core/sizes.dart';

class ConversationList extends StatelessWidget {
  final String name;
  final String? messageText;
  final String imageUrl;
  final String? time;
  final GestureTapCallback onTap;
  const ConversationList({
    super.key,
    required this.name,
    this.messageText,
    required this.imageUrl,
    this.time,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _openCustomDialog(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: NetworkImage(imageUrl),
                      maxRadius: 27,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          messageText == null
                              ? AppSizes.width10
                              : Text(
                                  messageText ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time ?? "",
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCustomDialog(context) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: SizedBox(
                height: 295,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 250,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              color: AppColors.black.withAlpha(80),
                              child: const Icon(Icons.chat,size: 30,color: AppColors.white,),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return const Text("");
      },
    );
  }
}
