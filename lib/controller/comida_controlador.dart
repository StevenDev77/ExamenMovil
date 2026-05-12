import '../model/pedido_comida_model.dart';

class ComidaControlador {
  // VALIDACIONES
  String? validarCampos({
    required String nombreCliente,
    required String producto,
    required String tipoCombo,
    required String cantidad,
  }) {
    if (nombreCliente.isEmpty) return 'Ingrese el nombre del cliente.';
    if (producto.isEmpty) return 'Seleccione un producto.';
    if (tipoCombo.isEmpty) return 'Seleccione el tipo de combo.';
    if (cantidad.isEmpty) return 'Ingrese la cantidad.';
    
    final cantidadNumero = int.tryParse(cantidad);
    if (cantidadNumero == null || cantidadNumero <= 0) {
      return 'La cantidad debe ser un número mayor que cero.';
    }
    return null;
  }
  bool validarPedidoVacio(int itemsCount) {
    return itemsCount == 0;
  }
  bool validarNombreClienteVacio(String nombreCliente) {
    return nombreCliente.isEmpty;
  }
  // ASIGNAR PRECIOS SEGÚN PRODUCTO Y COMBO
  double obtenerPrecioProducto(String producto) {
    switch (producto) {
      case 'Hamburguesa':
        return 8.0;
      case 'Salchipapa':
        return 7.0;
      case 'Hot Dog':
        return 6.0;
      case 'Perro Caliente Especial':
        return 7.5;
      case 'Empanada':
        return 5.0;
      case 'Arepa con queso':
        return 4.0;
      default:
        return 0.0;
    }
  }
  double obtenerPrecioCombo(String tipoCombo) {
    switch (tipoCombo) {
      case 'Solo producto':
        return 0.0;
      case 'Combo con papas':
        return 2.0;
      case 'Combo completo':
        return 4.0;
      default:
        return 0.0;
    }
  }

  // CALCULAR SUBTOTAL
  double calcularPrecioUnitario({
    required String producto,
    required String tipoCombo,
  }) {
    return obtenerPrecioProducto(producto) + obtenerPrecioCombo(tipoCombo);
  }

  double calcularSubtotalItem({
    required double precioUnitario,
    required int cantidad,
  }) {
    return precioUnitario * cantidad;
  }

  // CALCULAR IVA
  double calcularIVA(double subtotal) {
    return subtotal * 0.15;
  }

  // CALCULAR TOTAL
  double calcularTotal({
    required double subtotal,
    required double iva,
  }) {
    return subtotal + iva;
  }

  // CREAR ITEM CON TODOS LOS CÁLCULOS
  ItemPedido crearItem({
    required String producto,
    required String tipoCombo,
    required int cantidad,
  }) {
    final precioUnitario = calcularPrecioUnitario(
      producto: producto,
      tipoCombo: tipoCombo,
    );
    final subtotal = calcularSubtotalItem(
      precioUnitario: precioUnitario,
      cantidad: cantidad,
    );

    return ItemPedido(
      producto: producto,
      tipoCombo: tipoCombo,
      cantidad: cantidad,
      precioUnitario: precioUnitario,
      subtotal: subtotal,
    );
  }

  // CALCULAR SUBTOTAL DE UNA LISTA DE ITEMS
  double calcularSubtotalItems(List<ItemPedido> items) {
    return items.fold(0, (sum, item) => sum + item.subtotal);
  }

  // CREAR PEDIDO COMPLETO CON TODOS LOS CÁLCULOS
  PedidoComidaModelo crearPedido({
    required String nombreCliente,
    required List<ItemPedido> items,
  }) {
    final subtotalTotal = calcularSubtotalItems(items);
    final iva = calcularIVA(subtotalTotal);
    final total = calcularTotal(subtotal: subtotalTotal, iva: iva);

    return PedidoComidaModelo(
      nombreCliente: nombreCliente,
      items: items,
      subtotal: subtotalTotal,
      iva: iva,
      total: total,
    );
  }
}

