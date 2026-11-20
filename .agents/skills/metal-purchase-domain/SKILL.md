---
name: metal-purchase-domain
description: >-
  Use this skill when implementing or modifying metal purchase calculations, dirt waste
  (merma por tierra) deductions, quality grade pricing, or financial/weight summary reports
  in MatApp.
---

# Metal Purchase & Dirt Waste Domain Skill

Este skill gobierna las reglas de negocio de compra de metales (**Acero, Bronce, Cobre, Aluminio**), cálculo de merma por tierra y liquidación financiera en **MatApp**.

---

## 1. Fórmulas Matemáticas Invariantes (`PurchaseCalculation`)

Toda lógica de cálculo debe residir o delegar en `lib/features/purchases/domain/entities/purchase_entity.dart`:

1. **Peso Neto (`netWeightKg`)**:
   $$\text{netWeightKg} = \text{grossWeightKg} - \text{dirtWeightKg}$$
2. **Porcentaje de Merma por Tierra (`wastePercentage`)**:
   $$\text{wastePercentage} = \left(\frac{\text{dirtWeightKg}}{\text{grossWeightKg}}\right) \times 100$$
3. **Importe Total a Pagar (`totalPaid`)**:
   $$\text{totalPaid} = \text{netWeightKg} \times \text{pricePerKg}$$
4. **Costo Equivalente de Tierra Descontada (`dirtValueDiscounted`)**:
   $$\text{dirtValueDiscounted} = \text{dirtWeightKg} \times \text{pricePerKg}$$

---

## 2. Reglas de Validación y Casos Borde

1. **Pesos Inválidos**:
   - Si `grossWeightKg <= 0`: Rechazar con `ValidationFailure('El peso bruto debe ser mayor a 0 kg')`.
   - Si `dirtWeightKg < 0`: Rechazar con `ValidationFailure('La merma de tierra no puede ser negativa')`.
   - Si `dirtWeightKg >= grossWeightKg`: Rechazar con `ValidationFailure('La merma de tierra no puede ser igual o mayor al peso bruto')`.
2. **Precio Inválido**:
   - Si `pricePerKg <= 0`: Rechazar con `ValidationFailure('El precio por kilogramo debe ser mayor a $0.00')`.
3. **Sugerencia Automática por Calidad**:
   - Al seleccionar un grado de calidad (`QualityGrade`), el formulario debe prellenar automáticamente `pricePerKg` con `grade.defaultPricePerKg` y mostrar como referencia visual la merma típica (`grade.typicalDirtPercent`), permitiendo al operador ajustarlos manualmente según la inspección física del lote.

---

## 3. Verificación Obligatoria
- Todo cambio en `PurchaseCalculation` o casos de uso de compra/merma debe ir acompañado de pruebas unitarias en `test/purchase_calculation_test.dart`.
- Ejecuta `C:\dev\flutter\bin\flutter.bat test` y confirma que todos los casos borde pasen al 100%.
