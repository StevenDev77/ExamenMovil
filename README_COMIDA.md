# 🍔 Caso Práctico: Comida Rápida - Documentación

## 📍 Paso de Argumentos entre Vistas

### **De VistaComidaRapida → VistaNotaVentaComida**

```dart
// En vista_comida_rapida.dart (línea ~82)
Navigator.pushNamed(
  context,
  '/notaVentaComida',
  arguments: pedido,  // ← Se envía el PedidoComidaModelo aquí
);
```

### **Recepción en VistaNotaVentaComida**

```dart
// En vista_nota_venta_comida.dart (línea ~11)
final pedido = ModalRoute.of(context)!.settings.arguments as PedidoComidaModelo;
```

### **Definición de Rutas**

```dart
// En main.dart (líneas ~17-21)
routes: {
  '/comida': (context) => const VistaComidaRapida(),
  '/notaVentaComida': (context) => const VistaNotaVentaComida(),
},
initialRoute: '/comida',
```

---

## 🎨 Elementos Utilizados en las Vistas

### **VISTA 1: VistaComidaRapida** (Formulario)

| Elemento | Componente | Línea | Función |
|----------|-----------|-------|---------|
| **Encabezado** | AppBar | 180 | Título "Pedido de comida rápida" |
| **Nombre Cliente** | TextField (nativo) | 200 | Captura nombre del cliente |
| **Selector Producto** | SelectorSimple (Molécula/Átomo) | 226 | Dropdown de 6 productos |
| **Selector Combo** | SelectorSimple (Molécula/Átomo) | 231 | Dropdown de 3 combos |
| **Campo Cantidad** | CampoTextoPersonalizado (Átomo) | 236 | Input numérico |
| **Botón Agregar** | ElevatedButton.icon | 240 | Agrega producto a lista |
| **Lista Productos** | Card + Row (repetida) | 264-295 | Muestra cada producto agregado |
| **Subtotal Display** | Container + Row | 315-330 | Muestra subtotal en tiempo real |
| **Botón Finalizar** | ElevatedButton.icon | 335 | Genera nota de venta |

### **VISTA 2: VistaNotaVentaComida** (Resultado/Invoice)

| Elemento | Componente | Ubicación | Función |
|----------|-----------|-----------|---------|
| **Encabezado Rojo** | Container + Column | resumen_nota_venta_comida.dart ~20 | Emoji + "NOTA DE VENTA" |
| **Info Empresa/Cliente/Fecha** | Container + Column + Row | ~55 | Datos principales de la factura |
| **Detalle Productos** | Padding + Column (repetida) | ~90 | Cada producto numerado (1. 2. 3.) |
| **Separador Rojo** | Container (1.5px) | ~130 | Línea divisora |
| **Totales** | Padding + Column | ~135 | Subtotal, IVA, TOTAL |
| **Botón Atrás** | ElevatedButton | resumen_nota_venta_comida.dart | Regresa al formulario |

---

## 🔄 Flujo de Datos

```
VistaComidaRapida (StatefulWidget)
    ↓ (usuario llena formulario)
    ↓ validarCampos() [Controller]
    ↓ crearItem() [Controller]
    ↓ items.add(nuevoItem)
    ↓ setState() → actualiza UI
    ↓ usuario presiona "Generar nota"
    ↓ crearPedido() [Controller]
    ↓ Navigator.pushNamed(..., arguments: pedido)
    ↓
VistaNotaVentaComida (StatelessWidget)
    ↓ (recibe PedidoComidaModelo)
    ↓ ResumenNotaVentaComida [Molécula]
    ↓ Muestra invoice formateada
```

---

## � ¿Cómo se Mueven los Datos? - Explicación Detallada

### **1️⃣ ENTRADA DE DATOS (Usuario escriba en Vista)**

```dart
// En vista_comida_rapida.dart - línea 16-17
final clienteCtrl = TextEditingController();      // Captura nombre cliente
final cantidadCtrl = TextEditingController();     // Captura cantidad

// Usuario escribe en TextFields → datos se guardan en estos controladores
// El usuario selecciona de dropdowns → se guardan en:
String productoSeleccionado = '';    // Qué producto eligió
String comboSeleccionado = '';       // Qué combo eligió
```

### **2️⃣ VALIDACIÓN Y CÁLCULO (Controller procesa)**

```dart
// En vista_comida_rapida.dart - método _agregarProducto() línea ~36
void _agregarProducto() {
  // 1. Valida que TODO esté completo
  final error = controlador.validarCampos(
    nombreCliente: clienteCtrl.text.trim(),      // Obtiene del TextEditingController
    producto: productoSeleccionado,               // Obtiene del State
    tipoCombo: comboSeleccionado,                 // Obtiene del State
    cantidad: cantidadCtrl.text.trim(),           // Obtiene del TextEditingController
  );
  
  // 2. Si hay error, muestra mensaje
  if (error != null) {
    _mostrarError(error);  // Notificación en pantalla
    return;
  }

  // 3. Crea el item CON TODOS LOS CÁLCULOS
  final nuevoItem = controlador.crearItem(
    producto: productoSeleccionado,
    tipoCombo: comboSeleccionado,
    cantidad: int.parse(cantidadCtrl.text),
  );
  // El Controller retorna: ItemPedido con precioUnitario, subtotal calculados

  // 4. Añade a la lista de items
  setState(() {
    items.add(nuevoItem);  // items es una List<ItemPedido>
    cantidadCtrl.clear();  // Limpia campos
    productoSeleccionado = '';
    comboSeleccionado = '';
  });
}
```

### **3️⃣ VISUALIZACIÓN EN TIEMPO REAL (setState actualiza UI)**

```dart
// En vista_comida_rapida.dart - línea ~264-295
...items.asMap().entries.map((entry) {
  final item = entry.value;  // Obtiene cada ItemPedido de la lista
  return Card(
    // Muestra: producto, combo, cantidad, subtotal
    Text(item.producto),           // De ItemPedido
    Text(item.tipoCombo),          // De ItemPedido
    Text('${item.cantidad} x \$${item.precioUnitario}'),
    Text('\$${item.subtotal}'),    // Calculado por Controller
  );
}),

// Subtotal dinámico (línea ~315-330)
Text('\$${subtotalActual.toStringAsFixed(2)}'),
// subtotalActual = controlador.calcularSubtotalItems(items)
// Suma todos los subtotales en tiempo real
```

### **4️⃣ CREACIÓN DEL PEDIDO (Se prepara para enviar)**

```dart
// En vista_comida_rapida.dart - método _finalizarPedido() línea ~76
void _finalizarPedido() {
  // Crea el pedido COMPLETO con TODOS los cálculos
  final pedido = controlador.crearPedido(
    nombreCliente: clienteCtrl.text.trim(),
    items: items,  // Envía la lista de ItemPedido acumulada
  );
  // El Controller retorna: PedidoComidaModelo con subtotal, iva, total

  // Envía el pedido a la siguiente vista
  Navigator.pushNamed(
    context,
    '/notaVentaComida',
    arguments: pedido,  // ← AQUÍ se pasa como argumento
  );
}
```

### **5️⃣ RECEPCIÓN EN SEGUNDA VISTA**

```dart
// En vista_nota_venta_comida.dart - línea ~11
final pedido = ModalRoute.of(context)!.settings.arguments as PedidoComidaModelo;
// pedido ahora contiene: nombreCliente, items[], subtotal, iva, total

// Se pasa a la Molécula ResumenNotaVentaComida
body: ResumenNotaVentaComida(pedido: pedido),
```

### **6️⃣ VISUALIZACIÓN EN FACTURA**

```dart
// En resumen_nota_venta_comida.dart - línea ~57-62
// Accede directamente al objeto PedidoComidaModelo recibido
Text(
  'Cliente: ${pedido.nombreCliente}',    // De PedidoComidaModelo
  style: TextStyle(...),
),

// Lista de productos (línea ~90-110)
...pedido.items.asMap().entries.map((entry) {
  final item = entry.value;  // ItemPedido de la lista
  return Text(
    '1. ${item.producto}',      // De ItemPedido
    '   ${item.tipoCombo}',      // De ItemPedido
    '   ${item.cantidad}x \$${item.precioUnitario}',
    '   Subtotal: \$${item.subtotal}',
  );
}),

// Totales finales (línea ~135-155)
Text('Subtotal: \$${pedido.subtotal}'),  // De PedidoComidaModelo
Text('IVA: \$${pedido.iva}'),             // De PedidoComidaModelo
Text('TOTAL: \$${pedido.total}'),         // De PedidoComidaModelo
```

---

## 📊 Diagrama Completo del Flujo de Datos

```
┌─────────────────────────────────────────────────────────────────┐
│ USUARIO ESCRIBE EN VistaComidaRapida                            │
├─────────────────────────────────────────────────────────────────┤
│ TextEditingController: clienteCtrl.text → "Juan García"        │
│ TextEditingController: cantidadCtrl.text → "2"                 │
│ String productoSeleccionado → "Hamburguesa"                    │
│ String comboSeleccionado → "Combo con papas"                   │
└────────────────┬────────────────────────────────────────────────┘
                 │
                 ↓ (presiona "Agregar producto")
                 │
┌────────────────────────────────────────────────────────────────┐
│ CONTROLLER VALIDA Y CALCULA (ComidaControlador)               │
├────────────────────────────────────────────────────────────────┤
│ ✓ validarCampos() → verifica que todo esté lleno              │
│ ✓ crearItem() → calcula:                                      │
│   - precioUnitario = 8.0 + 2.0 = 10.0                        │
│   - subtotal = 10.0 * 2 = 20.0                               │
│ ✓ Retorna ItemPedido completo                                 │
└────────────────┬────────────────────────────────────────────────┘
                 │
                 ↓ (setState actualiza UI)
                 │
┌────────────────────────────────────────────────────────────────┐
│ VISTA MUESTRA EN TIEMPO REAL                                   │
├────────────────────────────────────────────────────────────────┤
│ List<ItemPedido> items → se renderiza como Cards              │
│ Subtotal Display: \$20.00                                      │
│ (Usuario puede agregar más productos o finalizar)             │
└────────────────┬────────────────────────────────────────────────┘
                 │
                 ↓ (presiona "Generar nota de venta")
                 │
┌────────────────────────────────────────────────────────────────┐
│ CONTROLLER CREA PEDIDO COMPLETO                               │
├────────────────────────────────────────────────────────────────┤
│ crearPedido() → calcula:                                       │
│ - subtotal = suma de todos los items = 20.0                   │
│ - iva = 20.0 * 0.15 = 3.0                                     │
│ - total = 20.0 + 3.0 = 23.0                                   │
│ Retorna PedidoComidaModelo completo                           │
└────────────────┬────────────────────────────────────────────────┘
                 │
                 ↓ Navigator.pushNamed(..., arguments: pedido)
                 │
┌────────────────────────────────────────────────────────────────┐
│ SEGUNDA VISTA RECIBE EL PEDIDO                                │
├────────────────────────────────────────────────────────────────┤
│ ModalRoute.of(context)!.settings.arguments as PedidoComidaModelo
│ pedido.nombreCliente = "Juan García"                          │
│ pedido.items = [ItemPedido, ...]                              │
│ pedido.subtotal = 20.0                                        │
│ pedido.iva = 3.0                                              │
│ pedido.total = 23.0                                           │
└────────────────┬────────────────────────────────────────────────┘
                 │
                 ↓ ResumenNotaVentaComida(pedido: pedido)
                 │
┌────────────────────────────────────────────────────────────────┐
│ FACTURA SE RENDERIZA CON TODOS LOS DATOS                      │
├────────────────────────────────────────────────────────────────┤
│ Header: NOTA DE VENTA                                         │
│ Cliente: Juan García                                          │
│ 1. Hamburguesa - Combo con papas - 2x $10.00 = $20.00       │
│ Subtotal: $20.00                                              │
│ IVA (15%): $3.00                                              │
│ TOTAL: $23.00                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## �📦 Componentes Utilizados

### **Átomos**
- `CampoTextoPersonalizado` - Campo de texto con icono
- `SelectorSimple` - Dropdown selector
- `BotonPersonalizado` - Botón estilizado
- `EtiquetaTexto` - Texto con estilos

### **Moléculas**
- `FormularioPedidoComida` - Formulario de producto + combo + cantidad
- `ResumenNotaVentaComida` - Factura completa con header, detalles y totales

---

## 🎯 Resumido Rápido

**Paso de argumentos:**
- Origen: `Navigator.pushNamed(..., arguments: pedido)` en VistaComidaRapida
- Destino: `ModalRoute.of(context)!.settings.arguments as PedidoComidaModelo` en VistaNotaVentaComida

**Vista formulario:** TextField + Dropdowns (Átomos) + Botones + Lista dinámica de items

**Vista factura:** Header rojo + Info empresa + Detalle numerado + Totales en fondo crema
