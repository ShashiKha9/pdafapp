import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
     home: DetailsScreenPage()));
}

class DetailsScreenPage extends StatelessWidget{

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final companyController = TextEditingController();
  final itemController = TextEditingController();

  Future<void> generateInvoice() async{
    final PdfDocument document = PdfDocument();
    final PdfLayoutResult layoutResult = PdfTextElement(
        text: "duighuih",
        font: PdfStandardFont(PdfFontFamily.helvetica, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)))
        .draw(
        page: ,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate))!;
// Draw the next paragraph/content.
    page.graphics.drawLine(
        PdfPen(PdfColor(255, 0, 0)),
        Offset(0, layoutResult.bounds.bottom + 10),
        Offset(page.getClientSize().width, layoutResult.bounds.bottom + 10));
    document.pages.add().graphics.drawString(
       "${nameController.text},${phoneNoController.text}" ,PdfStandardFont(PdfFontFamily.helvetica, 12));

    List<int> bytes= document.save();

    document.dispose();
    saveandLaunchFile(bytes,"Invoice.pdf");

  }

  Future<void> saveandLaunchFile(List<int> bytes,String fileName) async {
    final dir=  (await getExternalStorageDirectory())!.path;
    final file = File("$dir/$fileName");
    await file.writeAsBytes(bytes,flush: true);
    OpenFile.open("$dir/$fileName");




  }

  @override
  Widget build(BuildContext context) {
return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          ClipPath(
            child: Image(image: NetworkImage("https://images.saymedia-content.com/.image/t_share/MTc1MDA5Njc1OTYzNTQxMjI0/shades-red-greensleeves.jpg")),
            clipper: MyClipper(),
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
         child: TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Name",
                isDense: true,
                border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20),

           )
            ),
         )
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                ),
              )
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: phoneNoController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "Phone No",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                ),
              )
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: companyController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Company Name",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                ),
              )
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: itemController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Item Details",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                ),
              )
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(onPressed: generateInvoice,

            

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            color: Colors.red,
          child: Text("Generate",
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),)
        ],
      ),

    ));
  }
}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    // path.lineTo(size.width, size.height / 1.5);
    // path.lineTo(size.width, 0.0);
    var cp = Offset(90,size.height );
    var ep = Offset(size.width,size.height/2);
    path.quadraticBezierTo(cp.dx,cp.dy,ep.dx,ep.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> false;




}