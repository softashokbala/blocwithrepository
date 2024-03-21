import 'package:blocwithrepository/model/usermodel.dart';
import 'package:blocwithrepository/provider/userprovider.dart';
import 'package:blocwithrepository/repository/user_repository.dart';
import 'package:blocwithrepository/user_bloc/user_bloc.dart';
import 'package:blocwithrepository/user_bloc/user_event.dart';
import 'package:blocwithrepository/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: RepositoryProvider(
          create: (context) => UserRepository(UserProvider()),
          child: BlocProvider(
              create: (context) => UserBloc(context.read<UserRepository>()),
              child: MyHomePage()),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        bloc:   BlocProvider.of<UserBloc>(context)..add(LoadUserEvent()),
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserErrorState) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is UserSuccessState) {
            List<User> userList = state.userModel.data;
            return userList.isNotEmpty
                ? ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                        child: Card(
                            child: ListTile(
                          title: Text(
                              "${userList[index].firstName}  ${userList[index].lastName}"),
                          subtitle: Text("${userList[index].email}"),
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage("${userList[index].avatar}")),
                        )),
                      );
                    },
                  )
                : const Center(child: Text("No data Found"));
          }
          return SizedBox();
        },
        
      ),
      
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<UserBloc>().add(LoadUserEvent());
          },
          child: Icon(Icons.replay)),
    );
  }
}
