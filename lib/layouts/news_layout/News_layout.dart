import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/news_layout/cubit/cubit.dart';
import 'package:news_app/layouts/news_layout/cubit/states.dart';
import 'package:news_app/modules/search/searchscreen.dart';
import 'package:news_app/shared/componants/componants.dart';

class NewsLayouts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit= NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'News',
              ),
              actions: [
                IconButton(
                  icon:Icon(Icons.search),
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBarr(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
