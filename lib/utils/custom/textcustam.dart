import 'package:flutter/material.dart';

class Textcustom extends StatelessWidget {
  final String text;
  final Color? col;
  final FontWeight? weight;
  final double? size;
  final TextAlign? align;
  final bool? maxline;
  Textcustom(
      {required this.text,
      this.weight,
      this.col, // Colors.black,
      this.size,
      this.align,
      this.maxline = false});
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxline == true ? 1 : 5,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      '$text',
      style: TextStyle(color: col, fontSize: size, fontWeight: weight),
    );
  }
}
