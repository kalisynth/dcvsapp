part of dcvsapp;

class SkypeWidget extends StatefulWidget{
  final SkypeItem contact;
  final VoidCallback onCall;
  final VoidCallback onDelete;

  SkypeWidget({
    Key key,
    @required this.contact,
    this.onCall,
    this.onDelete,
}) : assert(contact != null),
  super(key: key);

  @override
  State<StatefulWidget> createState() => new _SkypeWidgetState();
}

class _SkypeWidgetState extends State<SkypeWidget>{

  @override
  Widget build(BuildContext context){

    return new GestureDetector(
          child: new Row(
            children: <Widget>[
              new CircleAvatar(
                radius: 75.0,
                backgroundColor: widget.contact.serviceProvider ? Colors.blue : Colors.amberAccent,
                child: new Text(widget.contact.skypeName, style: Theme.of(context).textTheme.title),
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 10.0),
              ),
              new Text(" | ", style: Theme.of(context).textTheme.title),
              new Padding(
                padding: const EdgeInsets.only(left: 10.0),
              ),
              new Text(widget.contact.skypeId, style: Theme.of(context).textTheme.title),
              new Padding(
                padding: const EdgeInsets.only(left: 20.0),
              ),
              new Text(" | ", style: Theme.of(context).textTheme.title),
              new Padding(
                padding: const EdgeInsets.only(left: 10.0),
              ),
              new Text(
                widget.contact.serviceProvider ? "N / A" : widget.contact.serviceProviderName, style: Theme.of(context).textTheme.title
              ),
            ]
          ),
      onTap: (){
            widget.onCall();
            },
        );
  }
}