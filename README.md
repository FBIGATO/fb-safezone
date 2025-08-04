# 🔐 Safe Zones + Red Zones + Zona de Carga (XR Phone Charger)

Este recurso permite crear zonas especiales en tu servidor de FiveM:

- ✅ **Zona Segura**: desactiva disparos y muestra HUD + notificación.
- ❌ **Zona Roja**: alerta visual de peligro (PvP activado).
- ⚡ **Zona de Carga**: permite cargar el teléfono (`lb-phone`) automáticamente.

---

## 📦 Instalación

1. **Coloca la carpeta** del recurso en tu directorio `resources`.

2. Asegúrate de que el recurso se llame exactamente:
   ```
   fb-safezone
   ```
   ⚠️ El script **no funcionará** si se renombra.

3. En tu `server.cfg`, añade:
   ```
   ensure fb-safezone
   ```

4. Requisitos adicionales:
   - `lb-phone` (opcional, solo si usas la zona de carga).
   - `vms_notifyv2` (por defecto) o tu sistema de notificaciones.

---

## 🛠️ Cambiar sistema de notificaciones

El sistema usa por defecto `vms_notifyv2`, pero puedes reemplazarlo fácilmente modificando esta función en `client.lua`:

### 🔁 Usando `vms_notifyv2` (por defecto):
```lua
local function Notify(title, msg, tipo)
    exports['vms_notifyv2']:Notification({
        title = title,
        description = msg,
        type = tipo or "info",
        icon = "fa-solid fa-circle-info",
        time = 4000,
        color = "#3daeff"
    })
end
```

---

### 🔁 Cambiar a `ESX.ShowNotification`:
```lua
local function Notify(title, msg, tipo)
    ESX.ShowNotification('[' .. title .. '\n' .. msg)
end
```

---

### 🔁 Cambiar a `QBCore.Functions.Notify`:
```lua
local function Notify(title, msg, tipo)
    QBCore.Functions.Notify('[' .. title .. '] ' .. msg, tipo or "primary")
end
```

---

✅ Puedes adaptar cualquier otro sistema fácilmente reemplazando la función `Notify(...)`.

---

## 🧠 Información adicional

- Todos los textos y colores del HUD se pueden personalizar desde `client.lua`.
- Puedes añadir más zonas editando `config.lua`.

---

## 👤 Autor

- 💻 Desarrollado por: **fbigato_j**
- 🛒 Adquiere más scripts en: [https://crrd.tebex.io](https://crrd.tebex.io)

Gracias por apoyar el desarrollo profesional para tu servidor.
