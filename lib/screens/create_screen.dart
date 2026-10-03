import 'package:flutter/material.dart';
import '../services/creator_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});
  @override State<CreateScreen> createState()=>_CreateScreenState();
}
class _CreateScreenState extends State<CreateScreen> {
  final prompt=TextEditingController();
  String type='Imagem'; bool busy=false;
  final examples=['Um dragão colossal em uma cidade futurista','Uma floresta mágica cinematográfica','Retrato de um astronauta em Marte'];

  Future<void> create() async {
    if(prompt.text.trim().isEmpty)return;
    setState(()=>busy=true);
    try{
      await CreatorService.saveProject(type:type,prompt:prompt.text.trim());
      if(mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Criação adicionada à sua biblioteca.')));
      prompt.clear();
    }catch(e){
      if(mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Erro: $e')));
    }finally{if(mounted)setState(()=>busy=false);}
  }

  @override Widget build(BuildContext context){
    return ListView(padding:const EdgeInsets.fromLTRB(18,8,18,28),children:[
      _hero(),
      const SizedBox(height:20),
      const Text('O que você quer criar?',style:TextStyle(fontSize:18,fontWeight:FontWeight.w800)),
      const SizedBox(height:12),
      SegmentedButton<String>(
        style:ButtonStyle(shape:WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(18)))),
        segments:const[
          ButtonSegment(value:'Imagem',icon:Icon(Icons.image_outlined),label:Text('Imagem')),
          ButtonSegment(value:'Vídeo',icon:Icon(Icons.movie_creation_outlined),label:Text('Vídeo')),
        ],
        selected:{type},onSelectionChanged:(v)=>setState(()=>type=v.first)),
      const SizedBox(height:14),
      Container(
        decoration:BoxDecoration(color:const Color(0xFF11121E),borderRadius:BorderRadius.circular(24),border:Border.all(color:Colors.white.withOpacity(.07))),
        padding:const EdgeInsets.all(6),
        child:Column(children:[
          TextField(controller:prompt,maxLines:7,decoration:const InputDecoration(border:InputBorder.none,filled:false,hintText:'Descreva sua ideia com detalhes...',contentPadding:EdgeInsets.all(14))),
          Row(children:[
            IconButton(onPressed:()=>_pick('Use uma imagem de referência'),icon:const Icon(Icons.add_photo_alternate_outlined)),
            IconButton(onPressed:()=>_pick('Crie um estilo cinematográfico'),icon:const Icon(Icons.tune)),
            const Spacer(),
            FilledButton.icon(onPressed:busy?null:create,icon:const Icon(Icons.auto_awesome,size:18),label:Text(busy?'Criando...':'Gerar'))
          ])
        ])
      ),
      const SizedBox(height:24),
      const Text('Inspire-se',style:TextStyle(fontSize:18,fontWeight:FontWeight.w800)),
      const SizedBox(height:10),
      SizedBox(height:48,child:ListView.separated(scrollDirection:Axis.horizontal,itemCount:examples.length,separatorBuilder:(_,__)=>const SizedBox(width:8),itemBuilder:(_,i)=>ActionChip(
        onPressed:()=>setState(()=>prompt.text=examples[i]),
        label:Text(examples[i]),avatar:const Icon(Icons.auto_awesome,size:16)))),
      const SizedBox(height:28),
      Row(children:[
        _stat(Icons.image_outlined,'Imagens','∞'),
        const SizedBox(width:10),_stat(Icons.movie_outlined,'Vídeos','∞'),const SizedBox(width:10),_stat(Icons.public_outlined,'Publicar','1 toque')
      ]),
    ]);
  }
  void _pick(String s){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(s)));}
  Widget _stat(IconData icon,String a,String b)=>Expanded(child:Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:const Color(0xFF11121E),borderRadius:BorderRadius.circular(20)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:const Color(0xFFA78BFA)),const SizedBox(height:8),Text(a,style:const TextStyle(fontWeight:FontWeight.bold)),Text(b,style:TextStyle(fontSize:12,color:Colors.white.withOpacity(.45)))])));
  Widget _hero()=>Container(
    height:190,padding:const EdgeInsets.all(22),
    decoration:BoxDecoration(
      borderRadius:BorderRadius.circular(30),
      gradient:const LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight,colors:[Color(0xFF251451),Color(0xFF10152D),Color(0xFF10111D)]),
      border:Border.all(color:Colors.white.withOpacity(.08)),
    ),
    child:Stack(children:[
      Positioned(right:-35,top:-50,child:Container(width:170,height:170,decoration:BoxDecoration(shape:BoxShape.circle,color:const Color(0xFF8B5CF6).withOpacity(.13)))),
      Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Container(padding:const EdgeInsets.symmetric(horizontal:10,vertical:6),decoration:BoxDecoration(color:Colors.white.withOpacity(.08),borderRadius:BorderRadius.circular(30)),child:const Text('✦ STUDIO DE IA',style:TextStyle(fontSize:11,fontWeight:FontWeight.bold))),
        const Spacer(),
        const Text('Sua próxima\nideia começa aqui.',style:TextStyle(fontSize:28,fontWeight:FontWeight.w900,height:1.02)),
        const SizedBox(height:7),
        Text('Crie. Edite. Publique.',style:TextStyle(color:Colors.white.withOpacity(.55)))
      ])
    ])
  );
}
