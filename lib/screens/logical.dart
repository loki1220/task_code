import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogicalPage extends StatefulWidget {
  const LogicalPage({Key? key}) : super(key: key);

  @override
  State<LogicalPage> createState() => _LogicalPageState();
}

class _LogicalPageState extends State<LogicalPage> {

  TextEditingController valueController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  var numberList;
  var oddList;
  var evenList;



  number(){
    numberList = List.generate(int.parse(totalController.text), (index) => {
      'name': "$index",
    });
  }




  @override
  Widget build(BuildContext context) {

    //firstValue field
    final firstValue = TextFormField(
        autofocus: false,
        controller: valueController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelText: "First Value",
        ));

    //secondValue field
    final secondValue = TextFormField(
        autofocus: false,
        controller: totalController,

        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          border:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          labelText: "Second Value",
        ));

    final submitButton = Material(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 10 * MediaQuery.of(context).size.width / 4,
        height: 45,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFF28B6ED),
              Color(0xFFE063FF),
            ],
          ),
        ),
        child: MaterialButton(
          onPressed: () {
            setState(() {
              number();
            });
          },
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF)),
          ),
        ),
      ),
    );


    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          firstValue,
          const SizedBox(
            height: 30,
          ),
          secondValue,
          const SizedBox(
            height: 30,
          ),
          submitButton,
          totalController.text.isEmpty? const SizedBox():
          SizedBox(
            height: 1000,
            child: ListView.builder(
              itemCount: int.parse(totalController.text),
              itemBuilder: (context, index) {
              return numberList[index]["name"].toString().contains(valueController.text)?
              int.parse(numberList[index]["name"])%2==0?
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${numberList[index]["name"]}",style: const TextStyle(
                    color: Colors.blueAccent
                  ),),
                ],
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("${numberList[index]["name"]}", style: const TextStyle(color: Colors.red),),
                ],
              ): Container();
            },),
          ),
        ],
      ),
      
      
    );
  }
}
