import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:intl/intl.dart';
import 'package:modgensample/api/media-api.dart';
import 'package:modgensample/constants.dart';
import 'package:modgensample/model/event.dart';
import 'package:modgensample/model/media.dart';

class EventDetailsScreen extends StatefulWidget {
  Event event;
  EventDetailsScreen({required this.event, Key? key}) : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen>
    with OSMMixinObserver {
  MediaAPI api = MediaAPI(BACKEND_URL);

  late MapController controller;

  @override
  Future<void> mapIsReady(bool isReady) {
    print('Map ready');
    var position = GeoPoint(
        latitude: widget.event.venueEvent.location.coordinates[1],
        longitude: widget.event.venueEvent.location.coordinates[0]);
    controller.addMarker(position,
        markerIcon: MarkerIcon(
            icon: Icon(
          Icons.business,
          size: 128,
          color: Theme.of(context).primaryColor,
        )));
    return Future.value();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var position = GeoPoint(
        latitude: widget.event.venueEvent.location.coordinates[1],
        longitude: widget.event.venueEvent.location.coordinates[0]);

    controller = MapController(
      initMapWithUserPosition: false,
      initPosition: position,
    );

    controller.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          title: Text(
            'Events Details',
            style: TextStyle(color: Colors.black87),
          )),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          buildEventImage(context),
          buildEventDetails(context),
        ],
      ),
    );
  }

  Padding buildEventDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            widget.event.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 20,
          ),
          buildEventDate(context),
          SizedBox(
            height: 10,
          ),
          buildEventVenue(context),
          SizedBox(
            height: 10,
          ),
          buildOrganizer(context),
          SizedBox(
            height: 15,
          ),
          buildEventDescription(context),
          SizedBox(
            height: 15,
          ),
          buildEventVenueDetails(context),
        ],
      ),
    );
  }

  Widget buildEventImage(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: FutureBuilder(
          future: api.getMediaListByEvenId(widget.event.id),
          builder: (context, AsyncSnapshot<List<Media>> snap) {
            if (snap.hasData) {
              final content = snap.data!;
              return ImageSlideshow(
                  isLoop: true,
                  width: double.infinity,
                  height: 200,
                  indicatorColor: Theme.of(context).primaryColorDark,
                  indicatorBackgroundColor: Theme.of(context).primaryColorLight,
                  // autoPlayInterval: 3000,
                  children: content
                      .map((e) => BACKEND_URL + 'file?fileName=' + e.filePath)
                      .map((url) => Image.network(
                            url,
                            height: 200,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                          ))
                      .toList());
            } else {
              return Text('');
            }
          }),
    );
  }

  Widget buildEventDate(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).textTheme.caption?.color?.withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.calendar_today_outlined,
            size: 32,
            color: Theme.of(context).textTheme.caption?.color,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EE, MMM d, h:mm a')
                  .format(DateTime.parse(widget.event.startDate.toString())),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              DateFormat('EE, MMM d, h:mm a')
                  .format(DateTime.parse(widget.event.endDate.toString())),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        )
      ],
    );
  }

  Widget buildEventVenue(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).textTheme.caption?.color?.withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.pin_drop,
            size: 32,
            color: Theme.of(context).textTheme.caption?.color,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.event.venueEvent.name,
                style: Theme.of(context).textTheme.bodyText1),
            SizedBox(
              height: 5,
            ),
            Text(
                widget.event.venueEvent.city +
                    ', ' +
                    widget.event.venueEvent.country,
                style: Theme.of(context).textTheme.bodyText1)
          ],
        )
      ],
    );
  }

  Widget buildOrganizer(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).textTheme.caption?.color?.withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(7),
          child: Icon(
            Icons.person,
            size: 32,
            color: Theme.of(context).textTheme.caption?.color,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                widget.event.organizerEvent.firstName +
                    ' ' +
                    widget.event.organizerEvent.lastName,
                style: Theme.of(context).textTheme.bodyText1),
          ],
        )
      ],
    );
  }

  Widget buildEventDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'About Event',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10),
        ExpandableText(
          widget.event.description,
          expandText: 'show more',
          collapseText: 'show less',
          maxLines: 3,
          animation: true,
          animationDuration: Duration(seconds: 2),
          linkColor: Theme.of(context).primaryColorDark,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget buildEventVenueDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Venue',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 10),
        Text(
          'Address',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 5),
        Text(widget.event.venueEvent.name),
        Text(widget.event.venueEvent.address +
            ', ' +
            widget.event.venueEvent.city),
        Text(widget.event.venueEvent.country),
        SizedBox(height: 20),

        Text(
          'Contact',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: Theme.of(context).textTheme.caption?.color,
            ),
            SizedBox(
              width: 5,
            ),
            Text(widget.event.venueEvent.contactNumber),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.email,
              color: Theme.of(context).textTheme.caption?.color,
            ),
            SizedBox(
              width: 5,
            ),
            Text(widget.event.venueEvent.contactEmail),
          ],
        ),

        SizedBox(height: 20),
        Container(
          height: 200,
          child: OSMFlutter(
            trackMyPosition: false,
            initZoom: 12,
            minZoomLevel: 8,
            controller: controller,
            markerOption: MarkerOption(
                defaultMarker: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            )),
          ),
        )
        //
      ],
    );
  }
}
