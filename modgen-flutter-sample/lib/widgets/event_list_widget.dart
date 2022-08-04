import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modgensample/api/media-api.dart';
import 'package:modgensample/constants.dart';
import 'package:modgensample/model/event.dart';
import 'package:modgensample/model/media.dart';
import 'package:modgensample/screens/event_details_screen.dart';

class EventListItemWidget extends StatelessWidget {
  final Event event;
  final MediaAPI api = MediaAPI(BACKEND_URL);
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
                  builder: (context) => EventDetailsScreen(event: event)),
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
                    child: FutureBuilder(
                      future: api.getFirstMediaByEvenId(event.id),
                      builder: (context, AsyncSnapshot<Media> snapshot) {
                        if (snapshot.hasData) {
                          return CachedNetworkImage(
                            imageUrl: BACKEND_URL +
                                'file?fileName=' +
                                snapshot.data!.filePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        } else
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                            ),
                          );
                      },
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
                          DateFormat('EE, MMM d, h:mm a').format(
                              DateTime.parse(event.startDate.toString())),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        event.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        Text(
                          event.venueEvent.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(width: 3),
                        Text('•',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600])),
                        SizedBox(width: 3),
                        Text(event.venueEvent.city,
                            style: Theme.of(context).textTheme.bodyText1)
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
