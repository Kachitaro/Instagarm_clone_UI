import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mid/screens/add_post_screen.dart';
import 'package:instagram_mid/screens/feed_screen.dart';
import 'package:instagram_mid/screens/notifications_screen.dart';
import 'package:instagram_mid/screens/profile_screen.dart';
import 'package:instagram_mid/screens/search_screen.dart';

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const NotificationsScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
