import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;
  final TextStyle? textStyle;
  final Color? seeMoreColor;

  const ExpandableText({
    Key? key,
    required this.text,
    this.trimLength = 150,
    this.textStyle,
    this.seeMoreColor,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final fullText = widget.text;
    final trimmedText = fullText.length > widget.trimLength
        ? fullText.substring(0, widget.trimLength)
        : fullText;

    final style = widget.textStyle ??
        TextStyle(
          fontSize: 14.sp,
          color: Colors.white70,
          height: 1.4,
        );

    final seeMoreColor = widget.seeMoreColor ?? Color(0xFFC4CDD5);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _isExpanded
                ? fullText
                : fullText.length > widget.trimLength
                ? "$trimmedText..."
                : fullText,
            style: style,
          ),
          if (fullText.length > widget.trimLength)
            TextSpan(
              text: _isExpanded ? " See Less" : " See More",
              style: style.copyWith(
                color: seeMoreColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
            ),
        ],
      ),
    );
  }
}
