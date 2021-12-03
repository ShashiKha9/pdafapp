import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

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
  final qunatityController = TextEditingController();
  final addController = TextEditingController();



  Future<void> generateInvoice() async{
    final PdfDocument document = PdfDocument();
    final page = document.pages.add();
    PdfTextElement elements = PdfTextElement();
    elements= PdfTextElement(text: companyController.text,font: PdfStandardFont(PdfFontFamily.helvetica,32));
    elements.brush= PdfBrushes.violet;
    elements.draw(
        page: page,bounds: Rect.fromLTWH(10, 15, 0, 0)
    );

    PdfTextElement element= PdfTextElement(
      text: "INVOICE 001",font: PdfStandardFont(PdfFontFamily.helvetica, 22)
    );




    PdfLayoutResult result = element.draw(
      page: page,
      bounds: Rect.fromLTWH(10, 60, 0, 0)
    )!;
    String currentDate = "Date"+ DateFormat.yMMMMd().format(DateTime.now());

    page.graphics.drawString(currentDate, PdfStandardFont(PdfFontFamily.timesRoman, 14,),
        brush: element.brush,
        // bounds: Offset(page.graphics.clientSize.width - 50,
        //     result.bounds.top) &
        // Size(80 + 5, 20)
      bounds: Rect.fromLTWH(370, result.bounds.top, 0, 0)
    );

    //
    element = PdfTextElement(
        text: 'BILL TO ',
        font: PdfStandardFont(PdfFontFamily.timesRoman, 14,
            style: PdfFontStyle.bold));
    element.brush = PdfSolidBrush(PdfColor(126, 155, 203));

    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 20, 0, 0))!;



    element = PdfTextElement(text:  nameController.text, font: PdfStandardFont(PdfFontFamily.timesRoman,14));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;
    // email
    element = PdfTextElement(text:  emailController.text, font: PdfStandardFont(PdfFontFamily.timesRoman,12));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;
    // phoneNo.
    element = PdfTextElement(text:  phoneNoController.text, font: PdfStandardFont(PdfFontFamily.timesRoman,12));
    element.brush = PdfBrushes.black;
    result = element.draw(
        page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 10, 0, 0))!;
    // address to


    page.graphics.drawLine(
        PdfPen(PdfColor(126, 151, 173), width: 0.7),
        Offset(0, result.bounds.bottom + 3),
        Offset(page.graphics.clientSize.width, result.bounds.bottom + 3));





    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 5);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value="Product Id";
    header.cells[1].value="Product name";
    header.cells[2].value="Price ";
    header.cells[3].value="Quantity ";
    header.cells[4].value = 'Total';




    PdfGridCellStyle headerStyle = PdfGridCellStyle();
    headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
    headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
    headerStyle.textBrush = PdfBrushes.white;
    headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
        style: PdfFontStyle.regular);
    for(int i = 0;i<header.cells.count;i++){
      if(i==0||i==1){
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        header.cells[i].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
      header.cells[i].style= headerStyle;

    }
PdfGridRow row = grid.rows.add();
    row.cells[0].value = 'CA-1098';
    row.cells[1].value = itemController.text;
    row.cells[2].value = '\$9.99';
    row.cells[3].value = qunatityController.text;
    row.cells[4].value = "\$${int.parse(qunatityController.text) * 9.99}" ;
    row = grid.rows.add();
    row.cells[0].value = 'LJ-0192';
    row.cells[1].value = "Jeans";
    row.cells[2].value = '\$49.99';
    row.cells[3].value = '3';
    row.cells[4].value = '\$149.97';
    row = grid.rows.add();
    row.cells[0].value = 'So-B909-M';
    row.cells[1].value = 'Shoes';
    row.cells[2].value = '\$9.5';
    row.cells[3].value = '2';
    row.cells[4].value = '\$19';
    row = grid.rows.add();
    row.cells[0].value = 'LJ-0192';
    row.cells[1].value = 'Bag';
    row.cells[2].value = '\$49.99';
    row.cells[3].value = '4';
    row.cells[4].value = '\$199.96';

    // cell padding
    grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);
    //grid style
    PdfGridCellStyle cellStyle = PdfGridCellStyle();
    cellStyle.borders.all = PdfPens.white;
    cellStyle.borders.bottom = PdfPen(PdfColor(217, 217, 217), width: 0.70);
    cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 12);
    cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));
    //
    for (int i = 0; i < grid.rows.count; i++) {
      PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        row.cells[j].style = cellStyle;
        if (j == 0 || j == 1) {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.left,
              lineAlignment: PdfVerticalAlignment.middle);
        } else {
          row.cells[j].stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.right,
              lineAlignment: PdfVerticalAlignment.middle);
        }
      }
    }
    PdfLayoutFormat layoutFormat =
    PdfLayoutFormat(layoutType: PdfLayoutType.paginate);
    // draw a grid

    //grand total
    PdfLayoutResult gridoutput = grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
            page.graphics.clientSize.width, page.graphics.clientSize.height - 100),
        format: layoutFormat)!;

    gridoutput.page.graphics.drawString(
        'Grand Total :                   \$386.91', PdfStandardFont(PdfFontFamily.timesRoman, 14),
        brush: PdfSolidBrush(PdfColor(126, 155, 203)),
        bounds: Rect.fromLTWH(310, gridoutput.bounds.bottom + 30, 0, 0));

    gridoutput.page.graphics.drawString(
        'Thank you for your Order!', PdfStandardFont(PdfFontFamily.timesRoman, 17),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(320, gridoutput.bounds.bottom + 80, 0, 0));



//




    List<int> bytes= document.save();
    //
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
          Row(
            children: [
              Expanded(child:
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
              ),
              Expanded(child:
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
              ),



            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: TextField(
                controller: companyController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "Company",
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),

                    )
                ),
              )
          ),

          Row(
            children: [
              Expanded(child:
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    controller: itemController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "Product",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),

                        )
                    ),
                  )
              ),
              ),
              Expanded(child:
              Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    controller: qunatityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Quantity",
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),

                        )
                    ),
                  )
              ),
              ),

            ],
          ),


          SizedBox(
            height: 35,
          ),
          RaisedButton(onPressed: generateInvoice,

            

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13)
            ),
            color: Colors.red,
          child: Text("Generate PDF",
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