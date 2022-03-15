import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:tubera/cubit/home_states.dart';
import 'package:tubera/models/link_model.dart';
import 'package:tubera/models/search_model.dart';
import 'package:tubera/models/trends_model.dart';
import 'package:tubera/modules/browser.dart';
import 'package:tubera/modules/trends.dart';
import 'package:tubera/modules/video_link.dart';
import 'package:tubera/shared/remote/dio_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HomeCubit extends Cubit<HomeStates> {
  List<Widget> bottomScreens = [ Trends(),VideoLink(), Browser()];
  var searchController = TextEditingController();

  HomeCubit() : super(HomeInitState());
  static HomeCubit get(contaxt) => BlocProvider.of(contaxt);
  int currentIndex = 0;
  WebViewController? controllerr;
  bool showDownloadButton = false;
  String? searchValue;
  var yt=YoutubeExplode();
  
 
  

  Future<void> downloadVideo(String youtubeVideo, int tag,String title) async {
    // var storageperm = Permission.storage;
    // storageperm.request().then((value) {
      final result = FlutterYoutubeDownloader.downloadVideo(
          youtubeVideo, title='.mp4', tag);
      print(result);
    // });
     
    
     
     
  }

  void changeBottomNavBar(int index) {
    currentIndex = index;
    print(index);
    emit(ChangeBottomNavBarState());
  }

  void onCreated(WebViewController controller) {
    controllerr = controller;
    emit(OnChangeState());
  }

  // void checkUrl() async {
  //   if (await controllerr!.currentUrl() == "https://www.youtube.com") {
  //     showDownloadButton = false;
  //     emit(SameUrlState());
  //   } else {
  //     showDownloadButton = true;
  //     emit(ChangeUrlState());
  //   }
  // }
  void searchChange(String value) {
    searchValue = value;
    getSearchData();
    emit(GetSearchChangeState());
  }

  SearchModel? searchModel;
  LinkModel?linkModel;
  bool isLink=false;
  void getSearchData()async {
    emit(GetLoadingState());

    if(searchValue!.startsWith('https://www.youtube.com/')&&searchValue!.length>43){
      //print(searchValueY!.substring(32,43));
         DioHelper.getDta(query: {
      'part': 'snippet',
      'id': searchValue!.substring(32,43),//'Zaz8xx2_znY,
      'key':'AIzaSyDvbgwrHBLpMa-kbHZGRSONiWyvtUAvO9g' //'AIzaSyCXlruCqs7g06IXGeWrn1tErHqbZrJx5bs'
    }, url: 'youtube/v3/videos')
        .then((value)async {
          
      linkModel = LinkModel.fromJson(value.data);
      isLink=true;
      
      print(linkModel!.items[0].id);
      print('https://www.youtube.com/watch?v=' +
          linkModel!.items[0].id.toString());
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState());
    });


    }else{
       DioHelper.getDta(query: {
      'part': 'snippet',
      'maxResults': '50',
      'q': searchValue ?? 'songs',
      'type': 'video',
      'key': 'AIzaSyDvbgwrHBLpMa-kbHZGRSONiWyvtUAvO9g'//'AIzaSyCXlruCqs7g06IXGeWrn1tErHqbZrJx5bs'
    }, url: 'youtube/v3/search')
        .then((value)async {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.toString());
      print('https://www.youtube.com/watch?v=' +
          searchModel!.items[0].id!.videoId.toString());
          isLink=false;
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState());
    });

    }
    
   
  }


  void downloadSearchVideo(String key, int myTag,String videoTitle) {
    downloadVideo('https://www.youtube.com/watch?v=' + key, myTag,videoTitle)
        .then((value) {
      emit(GetSearchNameSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchNameErrorState());
    });
  }
 
  TrendsModel? trendsModel;
    void getTrendsData()async {
      var mv= yt.
       //channels.get('https://www.youtube.com/c/NewMediaAcademy');
       
       videos.get('https://www.youtube.com/watch?v=Zaz8xx2_znY&list=PLD0gjrY4-xfEHdNom1SC2buj2X_4Tru2Y');
      // playlists.getVideos('PLD0gjrY4-xfEHdNom1SC2buj2X_4Tru2Y');

       
    emit(GetTrendsLoadingState());
    DioHelper.getDta(query: {
      'part': 'snippet',
      'chart': 'mostPopular',
      'regionCode': 'eg',
      'key': 'AIzaSyDvbgwrHBLpMa-kbHZGRSONiWyvtUAvO9g'//'AIzaSyCXlruCqs7g06IXGeWrn1tErHqbZrJx5bs',
    }, url: 'youtube/v3/videos')
        .then((value) {
       trendsModel= TrendsModel.fromJson(value.data);
      print(searchModel!.toString());
      // print('https://www.youtube.com/watch?v=' +
      //     searchModel!.items[0].id!.videoId.toString());
      emit(GetTrendsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTrendsErrorState());
    });
  }

}


//https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=3&q=songs&type=video&key=AIzaSyBFAaeNhayEJH-hStQOd3opwwTsassOBvY

//144=17
//240=5
//720=22
//1080=46
// 5	flv	audio/video	240p	-	-	-
// 6	flv	audio/video	270p	-	-	-
// 17	3gp	audio/video	144p	-	-	-
// 18	mp4	audio/video	360p	-	-	-
// 22	mp4	audio/video	720p	-	-	-
// 34	flv	audio/video	360p	-	-	-
// 35	flv	audio/video	480p	-	-	-
// 36	3gp	audio/video	180p	-	-	-
// 37	mp4	audio/video	1080p	-	-	-
// 38	mp4	audio/video	3072p	-	-	-
// 43	webm	audio/video	360p	-	-	-
// 44	webm	audio/video	480p	-	-	-
// 45	webm	audio/video	720p	-	-	-
// 46	webm	audio/video	1080p	-	-	-