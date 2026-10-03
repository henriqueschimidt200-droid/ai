import 'package:flutter/material.dart';
import '../services/creator_service.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  @override Widget build(BuildContext context){
    return StreamBuilder(
      stream:CreatorService.myProjects(),
      builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
        final docs=snapshot.data?.docs??[];
        if(docs.isEmpty)return _empty();
        return GridView.builder(
          padding:const EdgeInsets.all(14),itemCount:docs.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,crossAxisSpacing:12,mainAxisSpacing:12,childAspectRatio:.82),
          itemBuilder:(_,i){
            final d=docs[i].data();
            return Container(
              decoration:BoxDecoration(color:const Color(0xFF11121E),borderRadius:BorderRadius.circular(24),border:Border.all(color:Colors.white.withOpacity(.06))),
              child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                Expanded(child:Container(
                  width:double.infinity,
                  decoration:BoxDecoration(borderRadius:const BorderRadius.vertical(top:Radius.circular(24)),gradient:LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[const Color(0xFF39206E),const Color(0xFF101D38)])),
                  child:Center(child:Icon(d['type']=='Vídeo'?Icons.movie_outlined:Icons.image_outlined,size:42,color:Colors.white.withOpacity(.8))))),
                Padding(padding:const EdgeInsets.all(12),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                  Text(d['type']??'Criação',style:const TextStyle(fontWeight:FontWeight.bold)),
                  const SizedBox(height:4),Text(d['prompt']??'',maxLines:2,overflow:TextOverflow.ellipsis,style:TextStyle(fontSize:12,color:Colors.white.withOpacity(.5))),
                  const SizedBox(height:7),Row(children:[Icon(d['published']==true?Icons.public:Icons.lock_outline,size:15,color:Colors.white.withOpacity(.45)),const Spacer(),const Icon(Icons.more_horiz,size:18)])
                ]))
              ])
            );
          }
        );
      }
    );
  }
  Widget _empty()=>Center(child:Padding(padding:const EdgeInsets.all(30),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.folder_open_outlined,size:58,color:Color(0xFFA78BFA)),const SizedBox(height:15),const Text('Nada criado ainda',style:TextStyle(fontSize:22,fontWeight:FontWeight.w800)),const SizedBox(height:7),Text('Suas imagens e vídeos aparecerão aqui.',style:TextStyle(color:Colors.white54))])));
}
