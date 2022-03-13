import 'dart:math';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen(String? id, {Key? key}) : super(key: key);

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
      child: Column(
        children: [
          buildEventImage(),
          buildEventDetails(),
        ],
      ),
    );
  }

  Padding buildEventDetails() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'International Band Mucic Concert',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          buildEventDate(),
          SizedBox(
            height: 10,
          ),
          buildEventPlace(),
          SizedBox(
            height: 10,
          ),
          buildOrganizer(),
          SizedBox(
            height: 15,
          ),
          buildEventDescription(),
        ],
      ),
    );
  }

  ClipRRect buildEventImage() {
    return ClipRRect(
      child: Image.network(
        'https://api.lorem.space/image/movie?h=320&w=640&r=' +
            Random.secure().nextInt(10000).toString(),
        width: double.infinity,
        height: 200,
        errorBuilder: (context, error, stackTrace) =>
            Center(child: Icon(Icons.image)),
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[50],
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildEventDate() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0x5669FF).withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.calendar_today_outlined,
            size: 32,
            color: Color(0xFF5669FF),
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
              '14 December, 2021',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Text('Tuesday, 4:00PM - 9:00PM',
                style: TextStyle(color: Colors.grey[700]))
          ],
        )
      ],
    );
  }

  Widget buildEventPlace() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0x5669FF).withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(5),
          child: Icon(
            Icons.pin_drop,
            size: 32,
            color: Color(0xFF5669FF),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Gala Convention Center',
                style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(
              height: 5,
            ),
            Text('36 Guild Street London, UK',
                style: TextStyle(color: Colors.grey[700]))
          ],
        )
      ],
    );
  }

  Widget buildOrganizer() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0x5669FF).withAlpha(30),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(7),
          child: Icon(
            Icons.person,
            size: 32,
            color: Color(0xFF5669FF),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ashfak Sayem', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(
              height: 5,
            ),
            Text('Organizer', style: TextStyle(color: Colors.grey[700]))
          ],
        )
      ],
    );
  }

  Widget buildEventDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'About Event',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        SizedBox(height: 10),
        ExpandableText(
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
          expandText: 'show more',
          collapseText: 'show less',
          maxLines: 3,
          animation: true,
          animationDuration: Duration(seconds: 2),
          linkColor: Color(0xB05669FF),
        ),
      ],
    );
  }
}
