import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'create_screen.dart';
import 'feed_screen.dart';
import 'library_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState()=>_HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int index=0;
  final pages=const[CreateScreen(),FeedScreen(),LibraryScreen()];
  final titles=const['Studio','Explorar','Minha biblioteca'];

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        toolbarHeight:74,
        title:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          Text(titles[index],style:const TextStyle(fontSize:21,fontWeight:FontWeight.w800)),
          Text('AI Creator',style:TextStyle(fontSize:12,color:Colors.white.withOpacity(.42)))
        ]),
        actions:[
          Container(margin:const EdgeInsets.only(right:8),padding:const EdgeInsets.symmetric(horizontal:12,vertical:7),
            decoration:BoxDecoration(color:const Color(0xFF171827),borderRadius:BorderRadius.circular(20),border:Border.all(color:Colors.white.withOpacity(.06))),
            child:const Row(children:[Icon(Icons.bolt,size:16,color:Color(0xFFFBBF24)),SizedBox(width:5),Text('100')]),
          ),
          IconButton(onPressed:()=>AuthService.signOut(),icon:const Icon(Icons.logout_outlined)),
          const SizedBox(width:6)
        ],
      ),
      body:IndexedStack(index:index,children:pages),
      bottomNavigationBar:NavigationBar(
        height:78,
        selectedIndex:index,
        onDestinationSelected:(v)=>setState(()=>index=v),
        destinations:const[
          NavigationDestination(icon:Icon(Icons.auto_awesome_outlined),selectedIcon:Icon(Icons.auto_awesome),label:'Criar'),
          NavigationDestination(icon:Icon(Icons.explore_outlined),selectedIcon:Icon(Icons.explore),label:'Explorar'),
          NavigationDestination(icon:Icon(Icons.folder_outlined),selectedIcon:Icon(Icons.folder),label:'Biblioteca'),
        ],
      ),
    );
  }
}
