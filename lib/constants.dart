import 'package:demo/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const pinkColor = Color(0xFFF2C6C2);
const pinkLightColor = Color(0xFFF2E8DF);
const pinkHeavyColor = Color(0xFFF28585);
const orangeColor = Color(0xFFF2B263);
const greenColor = Color(0xFF86A69D);
const greyColor = Color(0xFFC0C0C0);
const greyHeavyColor = Color(0xFF8a8a8a);
const greyBackground = Color(0xFFF5F5F5);

const logoTitleFont =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Cute');

const double defaultPadding = 16.0;
const border = BorderRadius.all(Radius.circular(10.0));

const double topMenuBarHeight = 75.0;
const double popContainerHeightFactor = 0.9;

const double tagWidth = 35.0;
const double tagHeight = 35.0;
const TextStyle tagRedTextStyle =
    TextStyle(fontSize: 15, color: pinkHeavyColor);
const TextStyle tagBlackTextStyle =
    TextStyle(fontSize: 15, color: greyHeavyColor);

const TextStyle textLargeSize = TextStyle(fontSize: 20);
const TextStyle textMiddleSize = TextStyle(fontSize: 15);
const TextStyle textSmallSize = TextStyle(fontSize: 10);

const double imgWidth = 50.0;
const double imgHeight = 50.0;

const totalGroupSvg = 32;
const String assetGroupPath = "assets/svgs/group/";

final List<Widget> allGroupIcons = [
  for (var i = 1; i <= totalGroupSvg; i += 1)
    SvgPicture.asset(
      "$assetGroupPath${i.toString()}.svg",
      width: imgWidth,
      height: imgHeight,
      fit: BoxFit.scaleDown,
    )
];

final List<IconData> defaultTagIcons = [
  Icons.restaurant_outlined,
  Icons.favorite_outline,
  Icons.import_contacts_outlined,
];

final List<IconData> allTagIcons = [
  Icons.restaurant_outlined,
  Icons.favorite_outline,
  Icons.import_contacts_outlined,
  Icons.photo_camera_outlined
];

const double dialogWidth = 320;
const double dialogHeight = 400;

final List<Tag> defaultTags = [
  Tag(
    name: 'dinner',
    description: 'I want to have dinner with her/him',
    iconId: 0,
  ),
  Tag(
    name: 'date',
    description: 'I want to date her/him',
    iconId: 1,
  ),
  Tag(
    name: 'study',
    description: 'I want to study with her/him',
    iconId: 2,
  ),
];

const double visualDensityNum = 3.0;

// number of groups returned per request
const int groupsLoadNum = 10;
// number of users returned per request
const int groupUsersLoadNum = 20;
