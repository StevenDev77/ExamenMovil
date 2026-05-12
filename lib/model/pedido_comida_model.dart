class ItemPedido {
  String producto;
  String tipoCombo;
  int cantidad;
  double precioUnitario;
  double subtotal;

  ItemPedido({
    required this.producto,
    required this.tipoCombo,
    required this.cantidad,
    required this.precioUnitario,
    required this.subtotal,
  });
}

class PedidoComidaModelo {
  String nombreCliente;
  List<ItemPedido> items;
  double subtotal;
  double iva;
  double total;

  PedidoComidaModelo({
    required this.nombreCliente,
    required this.items,
    required this.subtotal,
    required this.iva,
    required this.total,
  });
}

