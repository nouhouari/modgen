import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modgensample/model/page.model.dart';
import 'package:modgensample/screens/event_details_screen.dart';

class EventListItemWidget extends StatelessWidget {
  final Event event;
  EventListItemWidget(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('Tapped ${event.id}');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventDetailsScreen(event.id)),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://api.lorem.space/image/movie?w=100&h=100&r=' +
                              Random.secure().nextInt(10000).toString(),
                      width: 100,
                      height: 100,
                      // errorBuilder: (context, error, stackTrace) =>
                      //     Center(child: Icon(Icons.image)),
                      fit: BoxFit.cover,
                      // loadingBuilder: (context, child, loadingProgress) {
                      //   if (loadingProgress == null) {
                      //     return child;
                      //   } else {
                      //     return Center(
                      //       child: CircularProgressIndicator(
                      //         value: loadingProgress.expectedTotalBytes != null
                      //             ? loadingProgress.cumulativeBytesLoaded /
                      //                 loadingProgress.expectedTotalBytes!
                      //             : null,
                      //       ),
                      //     );
                      //   }
                      // },
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          //event.createdDate.toString(),
                          DateFormat('EEEE, MMMM d, h:mm a').format(
                              DateTime.parse(event.createdDate.toString())),
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        event.name!,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        Text(
                          'Radius Gallery',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                        SizedBox(width: 3),
                        Text('•',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600])),
                        SizedBox(width: 3),
                        Text('Santa Cruz, CA',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600]))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
