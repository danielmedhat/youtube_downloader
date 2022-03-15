import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubera/cubit/home_cubit.dart';
import 'package:tubera/cubit/home_states.dart';
import 'package:tubera/modules/drawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(Icons.new_releases), label: 'Link'),
      BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Link'),
      BottomNavigationBarItem(
          icon: Icon(Icons.search), label: 'Search'),
    ];

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
         // drawer: MyDrawer(),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: HomeCubit.get(context).currentIndex,
                items: items,
                onTap: (index) {
                  HomeCubit.get(context).changeBottomNavBar(index);
                }),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              
              title: Text('Tubera',style:TextStyle(color: Colors.black), ),
            ),
            body: HomeCubit.get(context)
                .bottomScreens[HomeCubit.get(context).currentIndex]);
      },
    );
  }
}
