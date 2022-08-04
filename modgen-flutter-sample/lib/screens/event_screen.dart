import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modgensample/cubit/event-cubit.dart';
import 'package:modgensample/state/event-state.dart';
import 'package:modgensample/widgets/event_list_widget.dart';
import 'package:modgensample/widgets/error_widget.dart';

class EventScreen extends StatefulWidget {
  EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    EventCubit eventCubit = context.read<EventCubit>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore(eventCubit);
        print('Loading more!!!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    EventCubit eventCubit = context.read<EventCubit>();
    eventCubit.load();

    return Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Events',
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: [
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.black87,
            //     )),
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(Icons.more_vert, color: Colors.black87))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: BlocBuilder<EventCubit, EventState>(
              builder: (context, state) {
                switch (state.loading) {
                  case LoadingStatus.loading:
                    return Center(child: CircularProgressIndicator());
                  case LoadingStatus.success:
                  case LoadingStatus.loading_partial:
                    return buildList(state, eventCubit);
                  default:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomErrorWidget(),
                          Text(
                            'Unknown status `${state.loading}`',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                          ElevatedButton(
                              onPressed: () => eventCubit.load(),
                              child: Text('Reload'))
                        ],
                      ),
                    );
                }
              },
            )));
  }

  Widget buildList(EventState state, EventCubit cubit) {
    return RefreshIndicator(
      onRefresh: () => refreshResult(cubit),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
        child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 7,
            );
          },
          itemCount: state.allEvents!.length,
          itemBuilder: (context, index) {
            if (index < state.allEvents!.length) {
              return EventListItemWidget(state.allEvents![index]);
            } else if (index == state.allEvents!.length && state.lastPage!) {
              return Text('End');
            } else {
              return EventListItemWidget(state.allEvents![index]);
            }
          },
        ),
      ),
    );
  }

  Future<void> refreshResult(EventCubit cubit) async {
    cubit.load();
  }

  void loadMore(EventCubit cubit) {
    print('Loading more');
    cubit.loadNexPage();
  }
}
