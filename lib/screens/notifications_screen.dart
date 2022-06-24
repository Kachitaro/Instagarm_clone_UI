import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_mid/utils/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jiffy/jiffy.dart';


class NotificationsScreen extends StatefulWidget{
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen>{
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: const Text(
          'Notifications',
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseDatabase.instance.ref('notifications/$_uid').onValue,
          builder: (context, snapshot){
            final notificationsList = <ListTile>[];
            if(snapshot.hasData){
              DatabaseEvent notifications = snapshot.data! as DatabaseEvent;
              if(notifications.snapshot.exists){
                final notificationsData = Map<String, dynamic>.from(
                    notifications.snapshot.value as Map<dynamic, dynamic>);
                var sortByValue = SplayTreeMap<String, dynamic>.from(
                    notificationsData, (key2, key1) => notificationsData[key1]['datePublished'].compareTo(notificationsData[key2]['datePublished']));
                sortByValue.forEach((key, value) {
                  final nextNoti = Map<String, dynamic>.from(value);
                  final notiTile = ListTile(
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(nextNoti['userImg']),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: RichText(
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: nextNoti['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: " "+ nextNoti['text']),
                                      TextSpan(text: " ${Jiffy(DateTime
                                          .fromMillisecondsSinceEpoch(
                                          nextNoti['datePublished'])).fromNow()}", style: const TextStyle(fontWeight: FontWeight.w500)),
                                    ]
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  );
                  notificationsList.add(notiTile);
                });
              }
            }

            return ListView(
              children: notificationsList,
            );
          }
      ),
    );
  }
}