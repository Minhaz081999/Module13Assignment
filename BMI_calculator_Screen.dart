import 'package:flutter/material.dart';
import 'package:flutter_widget/module_13/BMI_calculator/widget/AppInputField.dart';

// Enum
enum HeightType{cm, inch, metre}
enum WeightType{kg, lb}

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {

  HeightType ? heightType = HeightType.cm;
  WeightType weightType = WeightType.kg;
  TextEditingController _weightController = TextEditingController();
  TextEditingController _lbController = TextEditingController();
  TextEditingController _cmController = TextEditingController();
  TextEditingController metreController = TextEditingController();

  TextEditingController _feetController = TextEditingController();
  TextEditingController _inchController = TextEditingController();

  String? BMIresult;

  String? BMIcategory;

  Color categoryColor = Colors.transparent;

  late double metre = double.parse(metreController.text.trim());


  // LB to kg
  double? lbtokg(){
    double lb = double.parse(_lbController.text.trim());
    if(lb == null || lb <= 0 ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid kg number")));
      return null;
    }
    return lb*0.45359237;
  }
  // kg to kg
  double? kgtokg(){
    double kg = double.parse(_weightController.text.trim());
    if(kg == null || kg <= 0 ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid kg number")));
      return null;
    }
    return kg;
  }
  // metre to metre
  double? metretometre(){
    double m = double.parse(metreController.text.trim());
    if(m == null || m <= 0 ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid metre number")));
      return null;
    }
    return m;
  }
  // Convert from CM to Metre
  double? CMtoMetre(){

    double cm = double.parse(_cmController.text.trim());
    double CMtoMetre;

    if(cm == null || cm < 0) return null;
    else{
      CMtoMetre = cm/100;
      return CMtoMetre;
    }
  }
// Convert from  feetinch to metre
  double? FeetInch(){
    double feet = double.parse(_feetController.text.trim());
    double inch = double.parse(_inchController.text.trim());

    if(feet == null || feet < 0 || inch == null || inch < 0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid number")));
      return null;
    }
    if (inch >= 12) {
      int extraFeet = (inch / 12).floor();
      feet += extraFeet;
      inch = inch % 12;
      _feetController.text = feet.toString();
      _inchController.text = inch.toString();
    }


    double totalInch = feet*12 + inch;
    double result = totalInch*0.0254;

    if(totalInch <= 0 ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid number")));
      return null;
    }
    return result;
  }
  // calculation
  void BMIcalculation(){


    double? KGresult;

    if(weightType == WeightType.kg){ KGresult = kgtokg();}
    else{ KGresult = lbtokg();}


    if (KGresult == null || KGresult<=0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid kg number")));
      return null;
    }

    // double weight = double.parse(_weightController.text.trim());

    // if(weight == null || weight <=0){
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid WEIGHT number")));
    //   return null;
    // }


     // double? Metreresult = heightType == HeightType.cm ? CMtoMetre()  : FeetInch();
    double? Metreresult;
    if(heightType == HeightType.cm){ Metreresult = CMtoMetre();}
    else if (heightType == HeightType.inch){Metreresult = FeetInch();}
    else{Metreresult = metretometre();}


    if (Metreresult == null || Metreresult<=0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("invalid METER number")));

      return null;
    }
     double bmi = KGresult/(Metreresult*Metreresult);


    String category = categoryResult(bmi);

    setState(() {
      BMIresult = bmi.toStringAsFixed(1);
      BMIcategory = category;


    });

  }

  String categoryResult(double bmi){
    if(bmi<18.5){
      categoryColor = Colors.blue;
      return "Underweight";
    }
    if(bmi<24.9){
      categoryColor = Colors.green;
      return "Normal";
    }
    if(bmi<29.9){
      categoryColor = Colors.orange;
      return "OverWeight";
    }
    categoryColor = Colors.red;
    return 'Obese';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: [
          SizedBox(height: 10,),

          Text("WEIGHT TYPE"),
          // gap
          SizedBox(height: 10,),
          SegmentedButton<WeightType>(
            segments: [
              ButtonSegment(
                  label: Text("KG"),
                  value: WeightType.kg,
                  icon: Icon(Icons.check)
              ),
              ButtonSegment(
                  label: Text("LB(Pounds)"),
                  value: WeightType.lb,
                  icon: Icon(Icons.present_to_all)
              ),

            ],
            selected: {weightType!},
            onSelectionChanged: (value){
              setState(() {
                weightType = value.first;
              });
            },
          ),
          // gap
          SizedBox(height: 10,),
          if(weightType == WeightType.kg )...[
            AppInputField(
                labelText: "Enter weight in kg",
                controller: _weightController,
                textInputType: TextInputType.number
            )

          ]else if(weightType == WeightType.lb)...[
            AppInputField(
                labelText: "Enter weight in lb(pounds)",
                controller: _lbController,
                textInputType: TextInputType.number
            )

          ],

          // gap
          SizedBox(height: 10,),
          // Weight
          // AppInputField(
          //   labelText: "Enter your weight in KG",
          //   controller: _weightController,
          //   textInputType: TextInputType.number ,
          // ),

          Text("HEIGHT TYPE"),
          // gap
          SizedBox(height: 10,),
          // SEGMENT button
          SegmentedButton<HeightType>(
              segments: [
                ButtonSegment(
                    label: Text("CM"),
                    value: HeightType.cm,
                    icon: Icon(Icons.monitor_weight_outlined)
                ),
                ButtonSegment(
                    label: Text("FeetInch"),
                    value: HeightType.inch,
                    icon: Icon(Icons.present_to_all)
                ),
                ButtonSegment(
                    label: Text("Metre"),
                    value: HeightType.metre,
                    icon: Icon(Icons.electric_meter)
                ),
              ],
              selected: {heightType!},
            onSelectionChanged: (value){
                setState(() {
                  heightType = value.first;
                });
            },
          ),

          Text("HEIGHT UNIT"),

          // gap
          SizedBox(height: 10,),

          if(heightType == HeightType.cm )...[
            AppInputField(
                labelText: "Enter height in CM",
                controller: _cmController,
                textInputType: TextInputType.number
            )

          ]else if(heightType == HeightType.metre)...[
            AppInputField(
                labelText: "Enter height in Metre",
                controller: metreController,
                textInputType: TextInputType.number
            )

          ]
          else...[
            Row(

              children: [
                Expanded(
                  child: AppInputField(
                      labelText: "Enter height in Feet",
                      controller: _feetController,
                      textInputType: TextInputType.number
                  ),
                ),

                // gap
                SizedBox(width: 10,),

                Expanded(
                  child: AppInputField(
                      labelText: "Enter height in Inch",
                      controller: _inchController,
                      textInputType: TextInputType.number
                  ),
                ),
              ],
            )
          ],

          //gap
          SizedBox(height: 10,),

          // BMIcalculatioon Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.black,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
              onPressed: (){
                BMIcalculation();
              },
              child: Text("Calculation")
          ),

          // GAP
          SizedBox(height: 10,),
        // Text("bmi result = $BMIresult"),
        //   Text("bmi category = $BMIcategory")
          BMIresult == null
              ?
          Container(
            height: 100,
            child: Card(
              color: categoryColor ,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your BMI Result Will Be Shown Here....",
                      style: TextStyle(
                        fontSize: 25
                      ),),
                    ),

                  ],
                ),
              ),

            ),
          )
              :
          Container(
            height: 100,
            child: Card(
              color: categoryColor ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("BMI Result = $BMIresult",
                    style: TextStyle(
                      fontSize: 20
                    ),),
                    Text("BMI Category = $BMIcategory",
                    style: TextStyle(
                      fontSize: 18
                    ),)
                  ],
                ),
              ),

            ),
          )

          // BMIcategory != null ? Text("BMI Category = $BMIcategory") : Text("invalid number")

        ],
      ),


    );
  }
}