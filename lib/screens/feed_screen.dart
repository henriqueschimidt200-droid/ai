import 'package:flutter/material.dart';
import '../services/creator_service.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override Widget build(BuildContext context){
    return StreamBuilder(
      stream:CreatorService.publicFeed(),
      builder:(context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting)return const Center(child:CircularProgressIndicator());
        final docs=snapshot.data?.docs??[];
        if(docs.isEmpty)return _empty();
        return ListView.builder(
          padding:const EdgeInsets.fromLTRB(14,4,14,28),itemCount:docs.length,
          itemBuilder:(_,i){
            final d=docs[i].data();
            return Container(
              margin:const EdgeInsets.only(bottom:14),
              decoration:BoxDecoration(color:const Color(0xFF11121E),borderRadius:BorderRadius.circular(26),border:Border.all(color:Colors.white.withOpacity(.06))),
              child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                AspectRatio(aspectRatio:16/10,child:Container(
                  decoration:BoxDecoration(borderRadius:const BorderRadius.vertical(top:Radius.circular(26)),gradient:LinearGradient(colors:[Colors.deepPurple.withOpacity(.35),Colors.blue.withOpacity(.14)])),
                  child:Center(child:Icon(d['type']=='Vídeo'?Icons.play_circle_outline:Icons.auto_awesome,size:54,color:Colors.white.withOpacity(.75))))),
                Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
                  Row(children:[const CircleAvatar(radius:17,child:Icon(Icons.person_outline,size:18)),const SizedBox(width:9),Text('Criador',style:const TextStyle(fontWeight:FontWeight.bold)),const Spacer(),IconButton(onPressed:(){},icon:const Icon(Icons.more_horiz))]),
                  Text(d['prompt']??'',maxLines:3,overflow:TextOverflow.ellipsis,style:TextStyle(color:Colors.white.withOpacity(.76),height:1.4)),
                  const SizedBox(height:10),
                  Row(children:[_action(Icons.favorite_border,'Curtir'),_action(Icons.mode_comment_outlined,'Comentar'),_action(Icons.ios_share_outlined,'Enviar')])
                ]))
              ])
            );
          }
        );
      }
    );
  }
  Widget _action(IconData i,String t)=>Padding(padding:const EdgeInsets.only(right:18),child:Row(children:[Icon(i,size:19,color:Colors.white.withOpacity(.7)),const SizedBox(width:5),Text(t,style:TextStyle(fontSize:12,color:Colors.white.withOpacity(.55)))]));
  Widget _empty()=>Center(child:Padding(padding:const EdgeInsets.all(35),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(shape:BoxShape.circle,color:const Color(0xFF8B5CF6).withOpacity(.12)),child:const Icon(Icons.explore_outlined,size:42,color:Color(0xFFA78BFA))),const SizedBox(height:18),const Text('O feed está esperando você.',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold)),const SizedBox(height:8),Text('Publique sua primeira criação e ela aparecerá aqui.',textAlign:TextAlign.center,style:TextStyle(color:Colors.white.withOpacity(.5)))])));
}
