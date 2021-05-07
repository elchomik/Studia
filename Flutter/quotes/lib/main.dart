import 'package:flutter/material.dart';
import 'quote.dart';

void main() {
  runApp(MaterialApp(
    home:QuoteList(),
  ));
}

class QuoteList extends StatefulWidget {
  const QuoteList({Key key}) : super(key: key);

  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {

  List<Quote> quotes=[
    Quote(author: 'Oscar Wilde',text:'Określać się znaczy ograniczać'),
    Quote(author: "Oscar Wilde",text:"Celem życia jest rozwój własnej indywidualności"),
    Quote(author: "Oscar Wilde",text:"Jeden pocałunek mężczyzny może złamać całe życie kobiety"),
    Quote(author:"Oscar Wilde",text: "Kłamstwo nie staje się prawdą tylko dlatego, że wierzy w nie więcej osób"),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Awesome Quotes"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body:Column(
        children:quotes.map((quote)=>Text('${quote.text} -${quote.author}')).toList(),
      )
    );
  }
}



