import 'package:campus_mart/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key, required this.index, required this.callback})
      : super(key: key);

  final int index;
  final Function callback;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      width: size.width,
      height: size.height * .07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                widget.callback(1);
              },
              icon: widget.index == 1
                  ? const FaIcon(FontAwesomeIcons.house, color: primary, size: 20,)
                  : const FaIcon(FontAwesomeIcons.house, color: Colors.black, size: 20,)),
          IconButton(
              onPressed: () {
                widget.callback(2);
              },
              icon: widget.index == 2
                  ? const FaIcon(
                FontAwesomeIcons.solidHeart,
                color: primary,
                size: 20,
              )
                  : const FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.black,
                        size: 20,
                    )),
          Container(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                widget.callback(3);
              },
              icon: widget.index == 3
                  ? const FaIcon(FontAwesomeIcons.solidBell, color: primary)
                  : const FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: Colors.black,
                      size: 20,
                    )),
          IconButton(
              onPressed: () {
                widget.callback(4);
              },
              icon: widget.index == 4
                  ? const Icon(
                      Icons.person,
                color: primary,
                size: 27,
                    )
                  : const Icon(
                      Icons.person,
                      size: 27,
                    ))
        ],
      ),
    );
  }
}