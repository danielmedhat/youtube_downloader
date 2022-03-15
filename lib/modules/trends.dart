import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubera/cubit/home_cubit.dart';
import 'package:tubera/cubit/home_states.dart';
import 'package:tubera/modules/browser.dart';

class Trends extends StatelessWidget {
  const Trends({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
       listener: (context,state){},
       builder: (context,state){
         var cubit =HomeCubit.get(context);
         if(cubit.trendsModel==null){
           return Center(child: CircularProgressIndicator(),);
         }
         return SingleChildScrollView(

           child: Column(
             
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: InkWell(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Browser()));
                   },
                   child: Container(
                     height: 55,
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: Colors.grey[200],
                       borderRadius: BorderRadius.circular(30)
                 
                     ),
                     child: Row(
                       children: [
                         SizedBox(width: 20,),
                         Icon(Icons.search),
                         SizedBox(width: 10,),
                         Text('Search by name or url')
                       ],
                     ),
                 
                   ),
                 ),
               ),
               SizedBox(height: 20,),
               ListView.separated(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder:(context,index)=>buildTrendItem(index,context,cubit) ,
                separatorBuilder:(context,index)=> Container(height: 2,color: Colors.grey,),
                 itemCount: cubit.trendsModel!.items.length),
             ],
           ),
         );

       },
    );
  }
  Widget buildTrendItem(int index, BuildContext context,HomeCubit cubit){
    AlertDialog? alertDialog;
    return Container(
      width: double.infinity,
      height: 330,
      child: Column(
        children: [
          Container(
            height: 230,
            width: double.infinity,
            child: Image(image: NetworkImage(cubit.trendsModel!.items[index].snippet!.thumbnails!.standard!.url.toString(),),fit: BoxFit.cover,)),
          SizedBox(
            height: 10,
            
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cubit.trendsModel!.items[index].snippet!.title.toString(),maxLines: 1, 
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,

                ),),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cubit.trendsModel!.items[index].snippet!.channelTitle.toString(),maxLines: 1, 
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[600]

                          ),),
                           Text(cubit.trendsModel!.items[index].snippet!.publishedAt.toString(),maxLines: 1, 
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey

                            ),),
                      ],
                    ),
                      Spacer(),
                         IconButton(onPressed: (){
                            alertDialog = AlertDialog(
                        title: Text(cubit.trendsModel!.items[index].snippet!.title.toString()),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            ElevatedButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .downloadSearchVideo(cubit.trendsModel!.items[index].id.toString(), 18, cubit.trendsModel!.items[index].snippet!.title.toString());
                                },
                                child: Text('360')),
                                SizedBox(width: 20,),
                         
                            ElevatedButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .downloadSearchVideo(cubit.trendsModel!.items[index].id.toString(), 22, cubit.trendsModel!.items[index].snippet!.title.toString());
                                },
                                child: Text('720')),
                            
                          ],
                        ));
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alertDialog!;
                                  });
                         }, icon:Icon (Icons.download),iconSize: 30),
                  ],
                ),
               
              ],
            ),
          ),
        ],crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}