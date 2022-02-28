import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const PizzaCalc());
}
class PizzaCalc extends StatefulWidget {
  const PizzaCalc({Key? key}) : super(key: key);

  @override
  _PizzaCalcState createState() => _PizzaCalcState();
}
enum sauce {cheese, sweet, hot}



class _PizzaCalcState extends State<PizzaCalc> {
  bool _testo=false;
  bool _twoChees=false;
  double _cost=0;
  double _size=40;
  sauce? _sauce = sauce.hot;



  double _calcPrice(){

    if (_testo) {
      _cost=300;
    } else {
      _cost=400;
    }
    switch (_sauce){
      case sauce.hot:
        _cost += 30;
        break;
      case sauce.sweet:
        _cost += 40;
        break;
      case sauce.cheese:
        _cost += 55;
        break;
    }

    if (_twoChees) _cost += 70;

    _cost+=_size*10;

    return _cost;
  }

  void _sauceChange(sauce? val)
  {
    setState(() {
      _sauce = val;
      _calcPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          //appBar: AppBar(),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 123,
                    child: Row(
                      children: const [
                        Expanded(flex: 4, child: SizedBox()),
                        Expanded(flex: 7, child: Image(image: AssetImage('assets/pizza.png'),fit: BoxFit.cover, )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children:  [
                        const SizedBox(height: 10,),
                        const Text("Калькулятор пиццы",style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                        const SizedBox(height: 5,),
                        const Text("Выберите параметры:",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10,),

                        SlidingSwitch(
                            height: 30,
                            value: _testo,
                            animationDuration: const Duration(milliseconds: 200),
                            textOn: "Тонкое тесто",
                            textOff: "Обычное тесто",
                            colorOn : const Color(0xffFFFFFF),
                            colorOff : const Color(0xffFFFFFF),
                            background : const Color(0xffECEFF1),
                            buttonColor : const Color(0xff0079D0),
                            inactiveColor : const Color(0x7d000000),
                            onChanged: (bool val){
                              setState(() {
                                _testo=val;
                                _calcPrice();
                                });
                            },
                            onTap: (){},
                            onDoubleTap: (){},
                            onSwipe: (){}),
                        const SizedBox(height: 15,),
                        Container(alignment: Alignment.centerLeft, child: const Text("Размер:",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                        SfSlider(
                          min: 20.0,
                          max: 80.0,
                          value: _size,
                          interval: 20,
                          stepSize: 20,
                          showTicks: true,
                          showLabels: true,
                          showDividers: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 0,
                          numberFormat: NumberFormat('## см'),
                          onChanged: (dynamic value){
                          setState(() {
                            _size=value;
                            _calcPrice();
                          });
                          },
                        ),
                        const SizedBox(height: 15,),
                        Container(alignment: Alignment.centerLeft, child: const Text("Соус:",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                        RadioListTile<sauce>(
                            title:const Text("Острый"),
                            value: sauce.hot,
                            groupValue: _sauce,
                            onChanged: _sauceChange,
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),

                        ),
                        RadioListTile<sauce>(
                          title:const Text("Сырный"),
                          value: sauce.cheese,
                          groupValue: _sauce,
                          onChanged: _sauceChange,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),

                        ),
                        RadioListTile<sauce>(
                          title:const Text("Кисло-сладкий"),
                          value: sauce.sweet,
                          groupValue: _sauce,
                          onChanged: _sauceChange,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        ),
                        SizedBox(
                          height: 60,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Card(
                              color: const Color(0xFFF0F0F0),

                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Image(image: AssetImage('assets/chees.png'),fit: BoxFit.cover, ),
                                    ),
                                  ),
                                  const Expanded(flex:4, child: Text("Дополнительный сыр",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,))),
                                  Expanded(
                                    flex:1,
                                    child: Switch(value: _twoChees, onChanged: (val){
                                      setState(() {
                                        _twoChees=val;
                                        _calcPrice();
                                      });
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(alignment: Alignment.centerLeft, child: const Text("Стоймость:",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: SizedBox(
                            height: 60,
                            child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                color: const Color(0xFFF0F0F0),
                                child: Container(alignment: Alignment.center, child: Text("${_cost} руб.",style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)))),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
                        child: ElevatedButton(onPressed: (){}, child: const Text("Заказать"), ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}



