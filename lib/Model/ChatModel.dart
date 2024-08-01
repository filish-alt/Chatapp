class ChatModel{
  String name;
  String icon;
  String status;
  bool isGroup;
  String time;
  String currentMessage;
  bool select;
  int id;
 ChatModel({
     this.name='',
     this.icon='',
     this.status='',
     this.isGroup=false,
     this.time='',
     this.currentMessage='',
     this.select=false,
     this.id=0,
  });
}