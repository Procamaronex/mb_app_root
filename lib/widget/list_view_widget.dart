import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListaProductoWidget extends StatefulWidget {
  const ListaProductoWidget(
      {super.key,
        required this.size,
        //required this.estado,
        required this.scrollController,
        required this.cont,
        required this.listas,
        /*required this.isIngreso*/});
  final Size size;
  final ScrollController scrollController;
  final BuildContext cont;
  final List<dynamic> listas;
  /*final bool isIngreso;*/
  @override
  State<ListaProductoWidget> createState() => _ListaProductoWidgetState();
}

class _ListaProductoWidgetState extends State<ListaProductoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size.width,
        height: widget.size.height / 2,
        child: ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.listas!.length,
            itemBuilder: (BuildContext contextt, int index) {
              final data = widget.listas![index];
              return Builder(builder: (BuildContext innerContext) {
                return GestureDetector(
                    onTap: () {
                      //if (!widget.isIngreso) {
                        // showBottomSheet(
                        //     context: innerContext,
                        //     builder: (context) => BottomSheetCustomMasterizado(
                        //       tipoReg: data.tipoMasterizado,
                        //       codigoBarra: data.codigoBarra.toString(),
                        //       estado: [
                        //         true,
                        //         data.estado == 'PENDIENTE' ||
                        //             data.estado == 'MASTERIZADO'
                        //             ? false
                        //             : true,
                        //         true
                        //       ],
                        //       detalles: data.cajas,
                        //       cont: widget.cont,
                        //     ))
                        /* .closed.then((value) {print("object");}) */;
                      //}
                    },
                    child: Container(
                      width: widget.size.width,
                      // height: 250,
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: widget.size.width,
                          height: 24,
                          //color:Colors.yellowAccent,
                          child: Row(
                            /* mainAxisAlignment: MainAxisAlignment.center, */
                            /* mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, */
                            children: [
                              Flexible(
                                flex: 0,
                                //color: Colors.blueGrey,
                                // width: widget.size.width / 2,
                                child: Row(
                                  children: [
                                    const Icon(FontAwesomeIcons.box,
                                        color:
                                        Color.fromARGB(255, 193, 154, 107)),
                                    const SizedBox(width: 5),
                                    const Text(
                                      "Cod. Barr:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(data["codBarra"]??"")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 5),
                            width: widget.size.width,
                            height: 24,
                            //color: Colors.yellowAccent,
                            child: Row(children: [
                              Container(
                                width: widget.size.width / 2,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Cod Pdt:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(data['codProducto']??"")
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  const Text(
                                    "Talla:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(data["talla"]??"")
                                ],
                              ),

                            ])),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: widget.size.width,
                          height: 24,
                          //color:Colors.yellowAccent,
                          child: Row(
                            /* mainAxisAlignment: MainAxisAlignment.center, */
                            /* mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, */
                            children: [
                              Container(
                                //color: Colors.blueGrey,
                                width: widget.size.width / 2,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Lote P.:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(data['lote']??"")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const Text(
                                      "Lote M:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(data["loteM"] ?? "",
                                    style: const TextStyle(fontSize: 12.5, height: 1),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          width: widget.size.width,
                          height: 24,
                          //color:Colors.yellowAccent,
                          child: Row(
                            /* mainAxisAlignment: MainAxisAlignment.center, */
                            /* mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, */
                            children: [
                              Flexible(
                                flex: 2,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Tipo:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(data["tipo"]??"")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ]),
                    ));
              });
            }));
  }
}
