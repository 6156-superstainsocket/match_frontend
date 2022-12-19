import 'dart:convert';

import 'package:demo/models/account.dart';
import 'package:demo/models/tag.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const double progressIndicatorSize = 40.0;

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

const double tagMiniWidth = 25;
const double tagMiniHeight = 25;
const TextStyle tagMiniRedTextStyle =
    TextStyle(fontSize: 15, color: pinkHeavyColor);
const TextStyle tagMiniBlackTextStyle =
    TextStyle(fontSize: 15, color: greyHeavyColor);

const TextStyle textLargeSize = TextStyle(fontSize: 20);
const TextStyle textMiddleSize = TextStyle(fontSize: 15);
const TextStyle textSmallSize = TextStyle(fontSize: 10);

const double imgWidth = 50.0;
const double imgHeight = 50.0;

const double profileImgWidth = 200;
const double profileImgHeight = 200;

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

const totalUserSvg = 12;
const String assetUserPath = "assets/images/user/";

final List<Widget> allUserIcons = [
  for (var i = 1; i <= totalUserSvg; i += 1)
    Image.asset(
      "$assetUserPath${i.toString()}.png",
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
  Icons.photo_camera_outlined,
  Icons.forest_outlined,
  Icons.bedtime_outlined,
  Icons.medical_services_outlined,
  Icons.pets_outlined,
  Icons.directions_run_outlined,
  Icons.hiking_outlined,
  Icons.fitness_center_outlined,
  Icons.downhill_skiing_outlined,
  Icons.pool_outlined,
  Icons.sports_basketball_outlined,
  Icons.sports_football_outlined,
  Icons.directions_bike_outlined,
  Icons.golf_course_outlined,
  Icons.local_cafe_outlined,
  Icons.local_bar_outlined,
  Icons.holiday_village_outlined,
  Icons.festival_outlined,
  Icons.music_note_outlined,
  Icons.theater_comedy_outlined,
  Icons.shopping_cart_outlined,
];

const double dialogWidth = 320;
const double dialogHeight = 400;

final List<Tag> defaultTags = [
  Tag(
    name: 'dinner',
    description: 'I want to have dinner with her/him/they',
    iconId: 0,
  ),
  Tag(
    name: 'date',
    description: 'I want to date her/him/they',
    iconId: 1,
  ),
  Tag(
    name: 'study',
    description: 'I want to study with her/him/they',
    iconId: 2,
  ),
];

const double visualDensityNum = 3.0;

// number of groups returned per request
const int groupsLoadNum = 20;
// number of users returned per request
const int groupUsersLoadNum = 20;

Color getBackGroundColor(bool hasRead, bool hasAccept) {
  if (!hasRead) {
    return pinkLightColor;
  }

  if (!hasAccept) {
    return pinkHeavyColor;
  }

  return greenColor;
}

var userDio = Dio(
  BaseOptions(
    baseUrl: 'https://ecmyhc1u8f.execute-api.us-east-1.amazonaws.com',
    headers: {'Access-Control-Allow-Origin': '*'},
  ),
);

GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: '246328411502-hje0geis0508eq3r4h9hlh6k891v4pk2',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

FirebaseOptions firebaseOptions = const FirebaseOptions(
  apiKey: "AIzaSyByMbF2VRN8ZCOGmLqfMYmnjYNXhUokNko",
  authDomain: "match-70b31.firebaseapp.com",
  projectId: "match-70b31",
  storageBucket: "match-70b31.appspot.com",
  messagingSenderId: "246328411502",
  appId: "1:246328411502:web:eeaca6a571234d4a086d7f",
  measurementId: "G-8RY2N0GVCE",
);

Future<Account?> loadUser() async {
  final prefs = await SharedPreferences.getInstance();
  String userStr = prefs.getString('userStr') ?? '';
  if (userStr != '') {
    Map<String, dynamic> userJson = jsonDecode(userStr);
    Account user = Account.fromJson(userJson);
    return user;
  }
  return null;
}

Future<int?> loadUserId() async {
  final prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userId') ?? -1;
  if (userId != -1) {
    return userId;
  }
  return null;
}

var groupDio = Dio(
  BaseOptions(
      baseUrl:
          'http://match-group-microservice-dev.us-east-1.elasticbeanstalk.com/api',
      headers: {'Access-Control-Allow-Origin': '*'}),
);
