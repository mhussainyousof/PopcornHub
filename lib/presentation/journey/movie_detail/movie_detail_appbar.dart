import 'package:flutter/material.dart';

class MovieDetailAppbar extends StatelessWidget {
  const MovieDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25,
          ),
        ),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
          size: 25,
        )
      ],
    );
  }
}
