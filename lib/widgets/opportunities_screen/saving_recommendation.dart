import 'package:flutter/material.dart';

class SavingRecommendation extends StatelessWidget {
  final String recommendationDescription;
  final String recommendationTitle;
  final String buttonText;
  final String imagePath;
  final VoidCallback? onPressed; // callback when user taps the link

  const SavingRecommendation({
    super.key,
    required this.buttonText,
    required this.recommendationDescription,
    required this.recommendationTitle,
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color teal = Theme.of(context).primaryColor;
    const Color subtitleGrey = Color(0xFF9EA7AB);
    const Color panelBorder = Color(0xFFDFF3F4);

    return Container(
      width: double.infinity,
      // approximate min height from screenshot
      constraints: const BoxConstraints(minHeight: 86),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: panelBorder, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(18, 0, 0, 0),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon box
          Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.contain),
          const SizedBox(width: 12),
          // content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  recommendationTitle,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    color: Color(0xFF232323),
                  ),
                ),
                const SizedBox(height: 6),
                // Description (allowing multiple lines)
                Text(
                  recommendationDescription,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: subtitleGrey,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                // bottom-right action link
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: onPressed,
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      buttonText,
                      style:  TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: teal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
