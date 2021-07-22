
import 'package:customer/bloc/login_bloc.dart';
import 'package:customer/data/model/resource.dart';
import 'package:customer/data/source/repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProxyProvider<Repository, LoginBloc>(
        update: (_, repository, __) => LoginBloc(repository),
        child: Builder(
            builder: (context) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                          image: AssetImage('graphics/icon_transparent.png')
                      ),
                      StreamBuilder<Resource<void>>(
                        stream: Provider.of<LoginBloc>(context).testStream(),
                        builder: (context, snapshot) {
                          final Resource<void> resource = snapshot.data;
                          if (resource is Success<void>) {
                            return Text('fdfdd');
                          } else{
                            return Text('...');
                          }
                        },
                      ),
                      RaisedButton(
                        onPressed: () {
                          Provider.of<LoginBloc>(context).requestSubject.add(null);
//                          Navigator.pushAndRemoveUntil(
//                              context,
//                              PageRouteBuilder(
//                                pageBuilder: (c, a1, a2) => CategoriesScreen(),
//                                transitionsBuilder: (c, anim, a2, child) =>
//                                    FadeTransition(opacity: anim, child: child),
//                                transitionDuration: Duration(milliseconds: 250),
//                              ), (Route<dynamic> route) => false);
                        },
                        child: Text('Login'),
                      )
                    ],
                  ),
                ),
              );
            }
        )
    );
  }
}