# MutePets

![WoW Forever](https://img.shields.io/badge/WoW-Forever-c79c6e)
![Interface](https://img.shields.io/badge/interface-16001-blue)
![Version](https://img.shields.io/badge/version-0.3.0-brightgreen)

MutePets silencia los sonidos de los pets en WoW Forever (brujo y cazador): todos a la vez, o solo los que elijas, e incluso solo ciertos tipos de sonido (ataques, heridas, voces...). Pensado para quien no quiere oír al Diablillo, al Abisario o al Guardia vil durante horas.

## Por qué existe este addon
El propósito de este addon fue quitar el sonido de la Súcubo (invocación del brujo), y eso dio inicio a este proyecto. Ahora también se pueden silenciar las mascotas del cazador, además de las del brujo. El mago no tiene invocaciones en WoW Forever, por lo que no forma parte de la lista.

## Language version
- [English](README.md)
- [Español](README_ES.md)

El addon elige su idioma automáticamente según el idioma del cliente de WoW: los clientes en español (esES, esMX) lo ven en español y el resto en inglés.

## Download
Descarga la [última versión](../../releases/latest) (`MutePets-x.y.z.zip`) y sigue la guía de instalación de abajo.

## Install
**Requisitos:** WoW Forever (Interface 16001). No es compatible con Classic Era ni con otros clientes.

1. Descomprime el zip.
2. Copia la carpeta `MutePets` en:

```
World of Warcraft/_forever_/Interface/AddOns/MutePets/
```

3. La carpeta debe llamarse exactamente `MutePets`, igual que el archivo `.toc`.
4. Entra al juego o escribe `/reload`.

## Features
- Silencia **todos** los pets con una sola casilla, o todos los de una clase con la casilla de su encabezado.
- Los pets están agrupados por clase y colapsados por defecto:
  - **Brujo:** Imp, Voidwalker, Felhunter, Succubus, Incubus, Felguard, Wrathguard, Shivarra, Observer, Voidlord, Infernal y Doomguard.
  - **Cazador:** Lobo, Oso, Jabalí, Felino, Cangrejo, Gorila, Raptor, Hiena, Búho, Águila, Carroñero, Devastador, Murciélago de esporas, Acechador deformador, Zancaalta, Quimera, Wyvern, Quilen, Zorro, Basilisco, Hidra, Puercoespín y Araña.
- Haz clic en el nombre de un pet para ver el **desglose** y elegir qué sonidos callar. Cada tipo de sonido tiene un botón de reproducción para escuchar sus sonidos uno por uno (el fileID de cada uno se registra en el chat):
  - Grito de combate
  - Ataques
  - Heridas
  - Muerte
  - Voces
  - Movimiento (donde el juego los tiene como sonidos separados, por ejemplo la Araña)
  - Otros
- Muestra el estado de cada pet: `(silenciado)` o `(parcial 3/5)`.
- Guarda tu configuración entre sesiones.
- Inglés y español, elegidos automáticamente según el idioma del cliente.

## Slash Commands

| Command              | Description                                   |
|----------------------|-----------------------------------------------|
| `/mp` or `/mutepets` | Abre el panel de opciones                     |
| `/mp on`             | Silencia todos los pets                       |
| `/mp off`            | Reactiva todos los pets                       |
| `/mp lang <código>` | Fuerza un idioma, por ejemplo `/mp lang en` o `/mp lang es` (recarga la interfaz) |
| `/mp lang auto`    | Vuelve al idioma del juego (recarga la interfaz) |

El panel también está en Opciones > AddOns > MutePets.

## Information
- Usa `MuteSoundFile`, así que el sonido se silencia en todo el juego. Los enemigos que compartan el mismo archivo (por ejemplo un Imp hostil) también dejarán de oírse.
- No es posible silenciar solo el pet propio ni los de otros jugadores.
- Si un pet sigue sonando o falta un sonido, abre un [issue](../../issues) indicando el pet y, si puedes, qué sonido es.
- Los pets del cazador usan los mismos archivos de sonido que los animales salvajes: silenciar "Lobo" silencia a todos los lobos del mundo, no solo al tuyo. Tampoco se pueden silenciar por separado los pets de otros jugadores.

## Contribution
Las contribuciones son bienvenidas: abre un Pull Request en GitHub.

**¿Quieres agregar tu idioma?** Solo necesitas un archivo de texto pequeño, sin programar. Mira la guía paso a paso en [CONTRIBUTING.md](CONTRIBUTING.md) (en inglés).

- `Data.lua` contiene los FileDataIDs agrupados por pet y por tipo de sonido. Se generó a partir del [community listfile de WoW](https://github.com/wowdev/wow-listfile).
- Para agregar un grupo nuevo, añade una entrada en `ns.GROUPS` con sus `cats` (`aggro`, `attack`, `wound`, `death`, `voice`, `other`).
