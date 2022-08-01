import 'package:flutter/material.dart';
import 'package:netfix_ui/images.dart';
import 'package:netfix_ui/widgets/widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, this.scrollOffset = 0}) : super(key: key);
  final double scrollOffset;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        color: Colors.black
            .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
        child: Row(
          children: [
            Image.asset(Assets.netflixLogo0),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButtonCustom(
                    content: "TV Show",
                    onTap: () {},
                  ),
                  TextButtonCustom(
                    content: "Movies",
                    onTap: () {},
                  ),
                  TextButtonCustom(
                    content: "My List",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
