import 'package:flutter/material.dart';
import '../../controller/comida_controlador.dart';
import '../../model/pedido_comida_model.dart';
import '../moleculas/formulario_pedido_comida.dart';

class VistaComidaRapida extends StatefulWidget {
  const VistaComidaRapida({super.key});

  @override
  State<VistaComidaRapida> createState() => _VistaComidaRapidaState();
}

class _VistaComidaRapidaState extends State<VistaComidaRapida> {
  final clienteCtrl = TextEditingController();
  final cantidadCtrl = TextEditingController();
  final controlador = ComidaControlador();
  final List<ItemPedido> items = [];

  String productoSeleccionado = '';
  String comboSeleccionado = '';

  final productos = [
    'Hamburguesa',
    'Salchipapa',
    'Hot Dog',
    'Perro Caliente Especial',
    'Empanada',
    'Arepa con queso'
  ];
  final combos = [
    'Solo producto',
    'Combo con papas',
    'Combo completo'
  ];

  void _agregarProducto() {
    final error = controlador.validarCampos(
      nombreCliente: clienteCtrl.text.trim(),
      producto: productoSeleccionado,
      tipoCombo: comboSeleccionado,
      cantidad: cantidadCtrl.text.trim(),
    );

    if (error != null) {
      _mostrarError(error);
      return;
    }

    if (controlador.validarNombreClienteVacio(clienteCtrl.text.trim())) {
      _mostrarError('Ingrese el nombre del cliente');
      return;
    }

    final cantidad = int.parse(cantidadCtrl.text.trim());
    final nuevoItem = controlador.crearItem(
      producto: productoSeleccionado,
      tipoCombo: comboSeleccionado,
      cantidad: cantidad,
    );

    setState(() {
      items.add(nuevoItem);
      cantidadCtrl.clear();
      productoSeleccionado = '';
      comboSeleccionado = '';
    });

    _mostrarExito('Producto agregado');
  }


  void _eliminarItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _finalizarPedido() {
    if (controlador.validarPedidoVacio(items.length)) {
      _mostrarError('Agregue al menos un producto');
      return;
    }

    final pedido = controlador.crearPedido(
      nombreCliente: clienteCtrl.text.trim(),
      items: items,
    );

    Navigator.pushNamed(
      context,
      '/notaVentaComida',
      arguments: pedido,
    );
  }

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  void _mostrarExito(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _VistaComidaContenido(
      clienteCtrl: clienteCtrl,
      cantidadCtrl: cantidadCtrl,
      productoSeleccionado: productoSeleccionado,
      comboSeleccionado: comboSeleccionado,
      productos: productos,
      combos: combos,
      items: items,
      onCambiarProducto: (valor) {
        setState(() {
          productoSeleccionado = valor ?? '';
        });
      },
      onCambiarCombo: (valor) {
        setState(() {
          comboSeleccionado = valor ?? '';
        });
      },
      onAgregarProducto: _agregarProducto,
      onEliminarItem: _eliminarItem,
      onFinalizarPedido: _finalizarPedido,
      subtotalActual: controlador.calcularSubtotalItems(items),
    );
  }

  @override
  void dispose() {
    clienteCtrl.dispose();
    cantidadCtrl.dispose();
    super.dispose();
  }
}

class _VistaComidaContenido extends StatelessWidget {
  final TextEditingController clienteCtrl;
  final TextEditingController cantidadCtrl;
  final String productoSeleccionado;
  final String comboSeleccionado;
  final List<String> productos;
  final List<String> combos;
  final List<ItemPedido> items;
  final ValueChanged<String?> onCambiarProducto;
  final ValueChanged<String?> onCambiarCombo;
  final VoidCallback onAgregarProducto;
  final Function(int) onEliminarItem;
  final VoidCallback onFinalizarPedido;
  final double subtotalActual;

  const _VistaComidaContenido({
    required this.clienteCtrl,
    required this.cantidadCtrl,
    required this.productoSeleccionado,
    required this.comboSeleccionado,
    required this.productos,
    required this.combos,
    required this.items,
    required this.onCambiarProducto,
    required this.onCambiarCombo,
    required this.onAgregarProducto,
    required this.onEliminarItem,
    required this.onFinalizarPedido,
    required this.subtotalActual,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido de comida rápida'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Datos del cliente',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: clienteCtrl,
                            decoration: InputDecoration(
                              labelText: 'Nombre del cliente',
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Ej: Juan García',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Agregar productos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  FormularioPedidoComida(
                    cantidadCtrl: cantidadCtrl,
                    productoSeleccionado: productoSeleccionado,
                    comboSeleccionado: comboSeleccionado,
                    productos: productos,
                    combos: combos,
                    onCambiarProducto: onCambiarProducto,
                    onCambiarCombo: onCambiarCombo,
                    onAgregarProducto: onAgregarProducto,
                  ),
                ],
              ),
            ),
            if (items.isNotEmpty) ...[
              const Divider(height: 32, thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Productos agregados (${items.length})',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    ...items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.producto,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      item.tipoCombo,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Cantidad: ${item.cantidad} x \$${item.precioUnitario.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${item.subtotal.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFFD32F2F),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        color: Color(0xFFD32F2F)),
                                    onPressed: () => onEliminarItem(index),
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xFFD32F2F), width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Subtotal:',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\$${subtotalActual.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFD32F2F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: onFinalizarPedido,
                      icon: const Icon(Icons.receipt_long),
                      label: const Text('Generar nota de venta'),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

