
import 'package:customer/bloc/inbox_bloc.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/data/source/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      CupertinoPageScaffold(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<Resource<String>>(
                    stream: Provider.of<InboxBloc>(context).testStream,
                    builder: (context, snapshot) {
                      final AsyncSnapshot<Resource<String>> finalSnapshot = snapshot;
                      print("finalSnapshot=$finalSnapshot");
                      return Text('Inbox');
                    }
                ),
                CupertinoButton(
                  child: Text('Check'),
                  onPressed: () {
                    Provider.of<InboxBloc>(context, listen: false).updateTest();
                  },
                )
              ],
            ),
          )
      );
}