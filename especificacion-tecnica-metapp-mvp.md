# Especificación Técnica y Arquitectura de Desarrollo: METAPP MVP

Documento maestro de ingeniería de software, arquitectura técnica, modelo de datos y roadmap de desarrollo para el agente de inteligencia artificial encargado de construir la solución móvil (Android e iOS) y el backend de **METAPP**, plataforma especializada en la digitalización, pesaje y balance financiero en patios de reciclaje.

---

## 1. Directiva y Contexto Operativo del Sistema

El Producto Mínimo Viable (MVP) de METAPP tiene como misión resolver de forma definitiva cuatro interrogantes operativas y financieras del negocio de reciclaje:
1. **Control de Adquisición**: ¿A quién se le compró el material, de qué tipo/calidad específica y qué peso neto ingresó al negocio?
2. **Control de Flujo de Efectivo**: ¿Cuánto dinero se ha desembolsado y cuánto saldo en efectivo real queda disponible en caja para continuar comprando material en báscula?
3. **Control de Inventario y Merma**: ¿Cuánto material aprovechable existe físicamente en el patio tras procesar las mermas por impurezas, tierra, humedad o limpieza?
4. **Liquidación y Rentabilidad**: ¿Cuánto dinero se recuperó al realizar la entrega o venta consolidada a fundidoras/plantas y cuál fue la ganancia o pérdida neta real de cada operación?

### 1.1. Principios de Ergonomía y Condiciones de Campo en Patio
La aplicación opera en condiciones de patio de chatarra y bodegas de acopio, imponiendo requerimientos de diseño no negociables:
* **Operación con una sola mano y botones táctiles grandes**: La interfaz del operador de báscula debe permitir registrar transacciones con toques mínimos en pantalla, sin desplegables engorrosos ni formularios extensos.
* **Alto contraste visual para lectura bajo luz solar directa**: Paleta de colores e interfaces diseñadas para máxima legibilidad contra el reflejo del sol en exteriores.
* **Captura ultra rápida (< 30 segundos por ticket)**: Evitar a toda costa la congestión o filas de proveedores en báscula mediante accesos rápidos y perfil genérico de mostrador.
* **Arquitectura Offline-First obligatoria**: En patios periféricos la señal celular suele ser deficiente o inexistente. Ninguna compra, pesaje o salida de dinero puede interrumpirse por falta de conexión a internet.

---

## 2. Arquitectura de Software y Stack Tecnológico

La arquitectura desacopla el cliente móvil del servidor central mediante sincronización asíncrona tolerante a fallos de red.

| Componente | Tecnología Seleccionada | Justificación Técnica |
| :--- | :--- | :--- |
| **Cliente Móvil (Android & iOS)** | Flutter (Dart) | Base de código única para ambas plataformas, garantizando alto rendimiento gráfico nativo en dispositivos de gama media y baja. |
| **Persistencia Local Móvil** | SQLite / Drift | Base de datos embebida con soporte relacional completo para operar 100% desconectado con colas de sincronización. |
| **Servicio Backend & API** | Node.js + TypeScript + Fastify | Monolito modular o API REST liviana con tiempo de respuesta ultra bajo y bajo consumo de memoria en servidor. |
| **Base de Datos Servidor** | PostgreSQL + Prisma ORM | Integridad transaccional ACID estricta para garantizar consistencia en asientos de caja e inventario. |
| **Seguridad y Sesiones** | JWT (JSON Web Tokens) | Autenticación ligera mediante tokens firmados con control de expiración y roles integrados. |
| **Hardware Periférico** | Impresoras térmicas Bluetooth (ESC/POS) | Compatibilidad estándar para imprimir tickets de compra de 58 mm y 80 mm directo desde el móvil. |
| **Mensajería Externa** | Integración nativa de compartición (WhatsApp / Intent) | Envío digital inmediato del comprobante de pesaje al proveedor en formato imagen o PDF. |

### 2.1. Estrategia de Sincronización Offline-First
1. **Escritura Local Inmediata**: Cada pesaje, compra, merma o movimiento de efectivo se registra en la base de datos local SQLite con `sincronizado = false` y un UUID generado en el dispositivo móvil.
2. **Cola de Despacho en Segundo Plano**: Un servicio en segundo plano detecta la disponibilidad de red y envía los paquetes pendientes en orden cronológico ascendente.
3. **Idempotencia y Prevención de Duplicados**: El backend procesa los registros validando el UUID único para evitar la duplicación de tickets o pagos ante reintentos de red.
4. **Congelamiento Histórico de Precios**: La compra almacena de forma inmutable el precio por kilo acordado en el momento exacto de la operación. Cambios posteriores en las listas de precios remotas jamás modifican compras pasadas.

---

## 3. Matriz de Roles y Seguridad (RBAC)

El acceso al sistema se restringe a dos roles operativos indispensables para evitar filtración de costos o manipulación no autorizada:

| Funcionalidad / Privilegio | Rol: Comprador / Báscula | Rol: Administrador / Dueño |
| :--- | :---: | :---: |
| Apertura y arqueo de Turno de Caja | Sí | Sí |
| Registro de pesajes y compras en báscula | Sí | Sí |
| Alta rápida de vendedores y selección de "Público General" | Sí | Sí |
| Registro de procesos de limpieza física y mermas en patio | Sí | Sí |
| Emisión e impresión de tickets térmicos / WhatsApp | Sí | Sí |
| Edición y actualización de listas de precios de compra | No | Sí |
| Consulta de costos históricos consolidados de adquisición | No | Sí |
| Creación y cierre de Cortes de Entrega a fundidoras | No | Sí |
| Visualización de utilidades brutas, márgenes y balance global | No | Sí |
| Auditoría de cierres de caja y conciliación de diferencias | No | Sí |

---

## 4. Modelo de Datos Relacional y Esquema de Entidades

A continuación se detalla la estructura formal de tablas y relaciones que debe implementar el agente de IA tanto en Prisma ORM (backend) como en las migraciones de SQLite/Drift (móvil).

### 4.1. Catálogos y Clasificaciones
* **Material**: Categoría macro del metal.
  * Campos: `id` (UUID/BIGINT), `nombre` (VARCHAR: Acero, Bronce, Cobre, Aluminio), `unidad_medida` (VARCHAR: kg), `descripcion` (VARCHAR), `activo` (BOOLEAN).
* **TipoMaterial / CalidadMaterial**: Subdivisión operativa y nivel de pureza.
  * Campos: `id` (UUID/BIGINT), `id_material` (FK), `nombre` (VARCHAR: Cobre limpio/brillante, Cobre quemado, Cobre mixto, Acero pesado, Lámina, Perfil aluminio, Lata bote), `porcentaje_merma_sugerido` (DECIMAL), `activo` (BOOLEAN).
* **ListaPrecio**: Encabezado tarifario.
  * Campos: `id` (UUID), `nombre` (VARCHAR), `tipo` (ENUM: COMPRA, VENTA), `tipo_tarifa` (ENUM: Público, Mayorista), `fecha_inicio` (TIMESTAMP), `fecha_fin` (TIMESTAMP), `activo` (BOOLEAN).
* **ListaPrecioDetalle**: Valores específicos por calidad.
  * Campos: `id` (UUID), `id_lista_precio` (FK), `id_calidad_material` (FK), `precio_kg` (DECIMAL).

### 4.2. Sujetos y Proveedores
* **Vendedor**: Registro de personas o recolectores que venden al patio.
  * Campos: `id` (UUID), `nombre_completo` (VARCHAR), `apodo` (VARCHAR, indexado para búsqueda ágil), `telefono` (VARCHAR), `tipo_vendedor` (ENUM: Ocasional, Frecuente, Mayorista), `direccion` (VARCHAR, opcional), `identificacion` (VARCHAR, opcional), `observaciones` (TEXT), `activo` (BOOLEAN).
  * *Registro Semilla de Mostrador*: Registro por defecto reservado para `Público General` para evitar detener la fila de pesaje.
* **Cliente**: Plantas procesadoras o fundidoras compradoras.
  * Campos: `id` (UUID), `razon_social` (VARCHAR), `contacto` (VARCHAR), `telefono` (VARCHAR), `direccion_planta` (VARCHAR), `activo` (BOOLEAN).

### 4.3. Control Financiero y Turnos de Caja
* **Turno_Caja**: Control de turnos de efectivo en patio.
  * Campos: `id` (UUID), `id_usuario` (FK), `fecha_apertura` (TIMESTAMP), `fecha_cierre` (TIMESTAMP, nullable), `saldo_inicial` (DECIMAL, fondo recibido para compras), `total_comprado_efectivo` (DECIMAL, acumulado), `gastos_menores` (DECIMAL, acumulado), `saldo_final_esperado` (DECIMAL), `saldo_final_real` (DECIMAL), `diferencia_arqueo` (DECIMAL), `estado` (ENUM: Abierto, Cerrado).
* **MovimientoCaja**: Libro de movimientos detallados.
  * Campos: `id` (UUID), `id_turno` (FK), `fecha_hora` (TIMESTAMP), `tipo_movimiento` (ENUM: ENTRADA, SALIDA), `concepto` (VARCHAR), `referencia_tipo` (ENUM: CAPITAL_INICIAL, COMPRA, ENTREGA_COBRO, GASTO_PATIO, RETIRO_EFECTIVO), `referencia_id` (UUID, nullable), `importe` (DECIMAL), `observaciones` (TEXT).

### 4.4. Operación de Compras y Pesaje
* **Compra**: Encabezado del ticket de compra en báscula.
  * Campos: `id` (UUID), `folio` (VARCHAR consecutivo, ej. C-000125), `id_turno` (FK), `id_vendedor` (FK), `fecha_hora` (TIMESTAMP), `subtotal` (DECIMAL), `descuentos_merma` (DECIMAL), `total` (DECIMAL), `metodo_pago` (ENUM: Efectivo, Transferencia), `estado` (ENUM: BORRADOR, REGISTRADA, PAGADA, CANCELADA), `sincronizado` (BOOLEAN).
* **CompraDetalle**: Desglose de partidas pesadas en báscula.
  * Campos: `id` (UUID), `id_compra` (FK), `id_calidad_material` (FK), `peso_bruto_kg` (DECIMAL), `tara_kg` (DECIMAL), `peso_neto_sucio_kg` (DECIMAL), `descuento_merma_kg` (DECIMAL), `peso_pagable_kg` (DECIMAL), `precio_aplicado_kg` (DECIMAL), `importe_linea` (DECIMAL).

### 4.5. Inventario, Mermas y Transformación Física en Patio
* **Inventario**: Saldo vivo consolidado por calidad.
  * Campos: `id` (UUID), `id_calidad_material` (FK unique), `stock_actual_kg` (DECIMAL), `costo_promedio_ponderado_kg` (DECIMAL).
* **MovimientoInventario**: Trazabilidad estricta de cada kilogramo (no se admiten modificaciones directas de saldo sin movimiento).
  * Campos: `id` (UUID), `id_calidad_material` (FK), `fecha_hora` (TIMESTAMP), `tipo_movimiento` (ENUM: ENTRADA_COMPRA, SALIDA_LIMPIEZA, ENTRADA_LIMPIEZA, SALIDA_ENTREGA, AJUSTE_AUDITORIA), `peso_kg` (DECIMAL), `costo_unitario_historico` (DECIMAL), `referencia_id` (UUID).
* **RegistroMermaLimpieza**: Proceso de limpieza y separación en patio.
  * Campos: `id` (UUID), `folio` (VARCHAR), `fecha_hora` (TIMESTAMP), `id_calidad_material_origen` (FK), `id_calidad_material_destino` (FK), `peso_entrada_kg` (DECIMAL), `peso_merma_desperdicio_kg` (DECIMAL), `peso_salida_aprovechable_kg` (DECIMAL), `porcentaje_merma` (DECIMAL), `motivo` (ENUM: Suciedad, Contaminacion, Humedad, Fierro_Pegado, Plastico, Tierra), `foto_evidencia_url` (VARCHAR, opcional), `id_usuario` (FK).

### 4.6. Entregas Consolidadas y Liquidación con Fundidora
* **Corte_Entrega**: Encabezado del embarque o entrega mayorista.
  * Campos: `id` (UUID), `folio` (VARCHAR, ej. E-00015), `fecha_entrega` (TIMESTAMP), `id_cliente` (FK), `costo_total_adquisicion` (DECIMAL), `gastos_asociados` (DECIMAL, transporte/maniobras), `ingreso_total_venta` (DECIMAL), `utilidad_bruta` (DECIMAL), `margen_porcentaje` (DECIMAL), `estado` (ENUM: BORRADOR, LIQUIDADA, CANCELADA).
* **Corte_Detalle**: Partidas despachadas en la entrega.
  * Campos: `id` (UUID), `id_corte` (FK), `id_calidad_material` (FK), `kilos_teoricos_inventario` (DECIMAL), `kilos_reales_recibidos_planta` (DECIMAL), `diferencia_kilos` (DECIMAL), `precio_venta_kg` (DECIMAL), `costo_adquisicion_linea` (DECIMAL), `importe_venta_linea` (DECIMAL).

---

## 5. Motor de Reglas de Negocio, Fórmulas y Fixtures Canónicos

El agente de software debe implementar las siguientes fórmulas exactas y utilizar los escenarios de prueba canónicos para sus pruebas unitarias y de integración.

### 5.1. Fórmulas de Pesaje y Liquidación en Báscula
1. Deducción de Tara (bote, arpilla, tambo o vehículo):
   $$PesoNetoSucio = PesoBruto - Tara$$
2. Descuento de Merma Inmediata por Suciedad en Báscula:
   $$PesoPagable = PesoNetoSucio - DescuentoMermaKg$$
3. Importe del Concepto:
   $$ImporteLinea = PesoPagable \times PrecioAplicadoKg$$
4. Regla de Bloqueo: No se puede registrar ninguna compra si el operador no cuenta con un `Turno_Caja` abierto. El sistema debe alertar si el importe total supera el saldo en efectivo de la caja.

### 5.2. Proceso de Limpieza en Patio y Absorción de Costo
Cuando el material acopiado se somete a limpieza antes de embarcarse:
$$PesoSalidaAprovechable = PesoEntrada - PesoMermaDesperdicio$$
$$PorcentajeMerma = \left( \frac{PesoMermaDesperdicio}{PesoEntrada} \right) \times 100$$
$$Rendimiento = 100\% - PorcentajeMerma$$

La merma encarece el material limpio resultante. El costo original se transfiere íntegramente al peso neto aprovechable:
$$CostoRealPorKg = \frac{CostoTotalOriginal}{PesoSalidaAprovechable}$$

### 5.3. Balance Financiero por Corte de Entrega
Al liquidar un embarque con la fundidora compradora:
$$UtilidadBruta = IngresoTotalVenta - CostoTotalAdquisicion - GastosAsociados$$
$$MargenSobreVentas = \left( \frac{UtilidadBruta}{IngresoTotalVenta} \right) \times 100$$
$$EficienciaMerma = \left( \frac{KilosRealesRecibidosPlanta - KilosCompradosPagados}{KilosCompradosPagados} \right) \times 100$$

### 5.4. Fixtures de Validación Canónicos (Casos de Prueba)

#### Caso de Prueba 1: Compra en Báscula (Folio C-000125)
* Vendedor: Juan Pérez. Estado: PAGADA.
* Detalle de partidas pesadas:
  * Acero pesado: $100\text{ kg} \times \$5.00/\text{kg} = \$500.00$
  * Cobre mixto: $20\text{ kg} \times \$120.00/\text{kg} = \$2,400.00$
  * Aluminio: $50\text{ kg} \times \$25.00/\text{kg} = \$1,250.00$
* **Resultados esperados**:
  * Peso total acumulado: $170\text{ kg}$.
  * Importe total de compra: $\$4,150.00$.
  * Movimiento de caja: Salida de efectivo por $\$4,150.00$.
  * Saldo de caja (iniciando con $\$50,000.00$): $\$45,850.00$.

#### Caso de Prueba 2: Limpieza de Patio y Recálculo Económico
* Material: Cobre sucio.
* Entrada a proceso: $100\text{ kg}$ adquiridos por un costo total de $\$10,000.00$ (costo base: $\$100.00/\text{kg}$).
* Proceso físico de limpieza: se descartan $8\text{ kg}$ de impurezas (tierra y plástico).
* **Resultados esperados**:
  * Peso aprovechable limpio: $92\text{ kg}$.
  * Porcentaje de merma: $8\%$.
  * Porcentaje de rendimiento: $92\%$.
  * Costo unitario real ajustado: $\$10,000.00 / 92\text{ kg} = \$108.70/\text{kg}$.
  * En venta posterior a $\$150.00/\text{kg}$: Ingreso $=\$13,800.00$, Costo $=\$10,000.00$, Utilidad bruta $=\$3,800.00$.

#### Caso de Prueba 3: Corte de Entrega Mayorista (Folio E-00015)
* Cliente: Fundidora Central. Estado: LIQUIDADA.
* Detalle de material entregado:
  * Acero pesado: $500\text{ kg} \times \$7.00/\text{kg} = \$3,500.00$
  * Cobre limpio: $92\text{ kg} \times \$150.00/\text{kg} = \$13,800.00$
  * Aluminio: $200\text{ kg} \times \$30.00/\text{kg} = \$6,000.00$
* Parámetros financieros:
  * Peso total entregado: $792\text{ kg}$.
  * Ingreso total por venta: $\$23,300.00$.
  * Costo del material entregado (promedio ponderado): $\$17,000.00$.
  * Gastos asociados (transporte y maniobras): $\$1,000.00$.
* **Resultados esperados**:
  * Utilidad bruta estimada: $\$23,300.00 - \$17,000.00 - \$1,000.00 = \$5,300.00$.
  * Margen sobre ventas: $(\$5,300.00 / \$23,300.00) \times 100 = 22.75\%$.

---

## 6. Especificación Detallada de Módulos Funcionales y Navegación Móvil

La navegación móvil en Android e iOS se estructura mediante una barra inferior de navegación fija con 5 secciones principales, complementada con acciones flotantes rápidas.

```
+-------------------------------------------------------------+
| Barra de Navegación Inferior Móvil:                         |
| [1. Inicio]  [2. Compras]  [3. Stock]  [4. Entregas]  [5. Reportes] |
+-------------------------------------------------------------+
```

### Módulo 1: Inicio / Dashboard Operativo
* **Pantalla de Resumen en Vivo**:
  * Widget principal: Saldo Disponible en Mano para compras de material en efectivo.
  * Tarjetas métricas: Total Comprado acumulado, Material en Inventario (kg), Merma Acumulada (kg), Entregas Realizadas e Inversión en Inventario.
  * Accesos Directos de Acción Rápida: Botón "Nueva Compra", Botón "Registrar Limpieza / Merma", Botón "Nueva Entrega".

### Módulo 2: Compras y Punto de Venta en Báscula (POS)
* **Selector Rápido de Proveedor**: Buscador predictivo por nombre y por **apodo**, botón modal "Nuevo Vendedor" (solo solicita nombre y teléfono) y botón directo "Público General / Mostrador".
* **Catálogo Visual de Metales**: Tarjetas táctiles grandes con colores representativos (Cobre 1ra, Cobre quemado, Bronce, Aluminio bote, Acero pesado) indicando el precio por kg vigente.
* **Calculadora de Báscula y Tara**: Entradas numéricas grandes para `Peso Bruto`, `Tara` de contenedor y `Descuento de Merma Inmediata`.
* **Emisión de Comprobante**: Generación automática de ticket con envío vía Bluetooth a mini-impresora térmica (58/80 mm) y disparador directo para compartir vía WhatsApp.

### Módulo 3: Stock, Inventario y Control de Limpieza
* **Vista de Inventario Vivo**: Existencias en kilogramos por metal y calidad desde el último corte.
* **Formulario de Limpieza en Patio**: Registro de kilogramos descartados por impurezas físicas (tierra, plástico, humedad) para deducir kilos ficticios del stock y recalcular el costo promedio ponderado.

### Módulo 4: Entregas y Liquidación con Fundidora
* **Configuración del Embarque**: Selección de materiales acumulados en patio para despacho mayorista.
* **Conciliación de Báscula**: Captura de kilos recibidos en la báscula de la fundidora de destino para identificar desviaciones y calcular la merma no detectada o pérdida en transporte.
* **Balance Financiero por Entrega**: Detalle automático de ingresos brutos, costo de adquisición del material vendido, fletes/maniobras y utilidad neta obtenida.

### Módulo 5: Gestión de Efectivo y Reportes
* **Control de Turno de Caja**: Bloqueo de compras sin turno activo, registro de fondo inicial, monitoreo de salidas y arqueo final con control de discrepancias.
* **Reportes Clave en Pantalla y Exportables (PDF/Excel)**:
  * Compras por período y compras por material.
  * Inventario actual valorizado.
  * Historial de mermas y rendimientos.
  * Balances por corte de entrega.
  * Arqueos y movimientos de caja.
  * Balance operativo general (Efectivo disponible vs. Valor del inventario vs. Utilidad del período).

---

## 7. Roadmap de Desarrollo en Etapas / Sprints para el Agente de IA

El agente de IA debe implementar la solución en 5 etapas secuenciales, respetando estrictamente las dependencias arquitectónicas indicadas.

```
Etapa 1: Backend Core, Base de Datos y Motor Transaccional
   │
   ▼
Etapa 2: Aplicación Móvil Base, Persistencia Local y Catálogos
   │
   ▼
Etapa 3: Módulo Central de Compras en Báscula y POS Móvil
   │
   ▼
Etapa 4: Control de Patio, Mermas y Flujo de Inventario
   │
   ▼
Etapa 5: Cortes de Entrega, Liquidación Financiera y Dashboard
```

### Etapa 1: Backend Core, Base de Datos y Motor Transaccional
* **Objetivo**: Configurar la base de datos centralizada, modelos relacionales, autenticación y endpoints fundacionales.
* **Entregables de Código**:
  1. Esquema de Prisma (`schema.prisma`) con todas las entidades descritas en la Sección 4.
  2. Migraciones SQL para PostgreSQL.
  3. Módulo de autenticación con Fastify y JWT, con asignación de roles (`Comprador` y `Admin`).
  4. Endpoints CRUD para gestión de catálogos (`Material`, `CalidadMaterial`, `ListaPrecio`).
  5. Endpoints para apertura, registro de movimientos y cierre de `Turno_Caja`.
* **Criterio de Aceptación**: Tests de integración automatizados que validen la creación de usuarios, autenticación segura y restricción de endpoints administrativos mediante RBAC.

### Etapa 2: Aplicación Móvil Base, Persistencia Local y Catálogos
* **Objetivo**: Desarrollar la estructura base en Flutter con soporte nativo Offline-First y sincronización básica.
* **Entregables de Código**:
  1. Proyecto Flutter estructurado con arquitectura limpia (Clean Architecture / BLoC o Riverpod).
  2. Implementación de Drift/SQLite con tablas locales sincronizadas.
  3. Sistema de diseño para patio: tema oscuro/alto contraste y componentes táctiles de gran escala para uso con una mano.
  4. Repositorio de sincronización bidireccional para descargar catálogos y listas de precios al dispositivo.
  5. Pantallas de inicio de sesión, apertura de turno de caja y widget de saldo en tiempo real.
* **Criterio de Aceptación**: La aplicación móvil arranca, sincroniza catálogos desde el servidor, desconecta internet y permite abrir un turno de caja persistiendo los datos de forma local.

### Etapa 3: Módulo Central de Compras en Báscula y POS Móvil
* **Objetivo**: Implementar el flujo crítico de pesaje rápido en báscula y emisión de comprobantes.
* **Entregables de Código**:
  1. Pantalla POS de Nueva Compra con cuadrícula de tarjetas de colores para metales.
  2. Lógica reactiva de cálculo: $PesoNetoSucio$, $PesoPagable$ e $ImporteLinea$.
  3. Selector de vendedor con búsqueda por apodo y botón predeterminado "Público General".
  4. Integración de servicio Bluetooth ESC/POS para impresión térmica de 58 mm y 80 mm.
  5. Generador de comprobante visual compartible por WhatsApp.
  6. Encolamiento de la compra en la base de datos local SQLite con despacho background idempotente hacia PostgreSQL.
* **Criterio de Aceptación**: Simulación de pesaje de 3 materiales completada en menos de 30 segundos en modo avión, guardada localmente y sincronizada con el backend al restablecer la red sin duplicar folios.

### Etapa 4: Control de Patio, Mermas y Flujo de Inventario
* **Objetivo**: Modelar la transformación de inventario en patio, absorción de costos y cierre de turnos.
* **Entregables de Código**:
  1. Trigger o servicio de backend que convierta compras en incrementos de `Inventario` y `MovimientoInventario`.
  2. Pantalla móvil de "Registrar Limpieza / Merma" con selector de motivo y cálculo automático de rendimiento y porcentaje de pérdida.
  3. Implementación del algoritmo de recálculo de Costo Promedio Ponderado por absorción de merma.
  4. Flujo móvil de cierre y arqueo de caja con reporte de diferencias entre efectivo esperado y real.
* **Criterio de Aceptación**: Ejecución del Caso de Prueba 2 (100 kg sucios con 8 kg de merma), verificando que el stock resultante sea 92 kg y el costo unitario se ajuste a $108.70/kg.

### Etapa 5: Cortes de Entrega, Liquidación Financiera y Dashboard
* **Objetivo**: Concluir el ciclo del negocio con la venta a fundidoras, métricas ejecutivas y reportes exportables.
* **Entregables de Código**:
  1. Módulo administrativo de "Corte de Entrega" con selección de lotes despachados y captura de pesaje de báscula de destino.
  2. Cálculo automatizado de margen de venta, utilidad bruta y eficiencia de merma por metal.
  3. Pantalla de Dashboard con indicadores consolidados en tiempo real.
  4. Generador de reportes en PDF y Excel para balances por entrega y arqueos de caja.
* **Criterio de Aceptación**: Ejecución del Caso de Prueba 3 (Entrega E-00015), confirmando utilidad de $5,300.00 y margen del 22.75% con generación de reporte final descargable.

---

## 8. Delimitación de Alcance: Matriz MVP vs. Fase 2

Para garantizar un desarrollo ágil y evitar sobrecostos o dispersión técnica, se fija la frontera del MVP:

| Funcionalidad / Módulo | Alcance MVP | Justificación para Fase 2 |
| :--- | :---: | :--- |
| **Operación Offline-First Integral** | **Obligatorio** | Esencial para evitar la interrupción de compras en patios con mala conectividad. |
| **Control de Turnos y Efectivo en Mano** | **Obligatorio** | Previene fugas de dinero y asegura que siempre haya fondos para seguir comprando. |
| **Doble Nivel de Merma (Báscula + Patio)** | **Obligatorio** | Refleja el peso real comercializable y su verdadero costo de adquisición absorbido. |
| **Tickets por Bluetooth Térmico y WhatsApp** | **Obligatorio** | Da certeza y transparencia inmediata al recolector o vendedor de chatarra. |
| **Balance Financiero y Margen por Entrega** | **Obligatorio** | Permite conocer con precisión matemática si un embarque mayorista generó ganancia o pérdida. |
| **Conexión Directa RS232/Bluetooth a Báscula** | *Fase 2* | Requiere homologación de protocolos propietarios de múltiples marcas de básculas de plataforma. |
| **Soporte Multi-sucursal y Multi-patio** | *Fase 2* | Introduce transferencias entre almacenes que añaden complejidad innecesaria a la primera versión. |
| **Facturación Fiscal Electrónica (CFDI/SAT)** | *Fase 2* | La operación de compra en báscula con recolectores es predominantemente en efectivo e informal. |
| **Geolocalización de Proveedores** | *Fase 2* | No aporta valor operativo crítico en el punto fijo de recepción en patio. |
| **Módulos Contables Formales / ERP Completo** | *Fase 2* | Debe priorizarse la velocidad de pesaje y control de patio antes que la contabilidad corporativa. |
