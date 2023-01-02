# Language:
[🇮🇹 Italiano](#emulatore-di-6502-per-game-boy-advance)

***

🇮🇹
# Emulatore di 6502 per Game Boy Advance

Questo progetto permette di emulare un computer basato sul processore 6502 sulla
console portatile 'Game Boy Advance' (GBA), rilasciata da Nintendo negli anni
2000.

Questo progetto ha come intenzione quella di riesplorare questo classico
processore, cercando di mantenere il codice quanto più chiaro e modulare
possibile, spesso al costo dell'efficienza.\
L'emulatore non è da considerarsi accurato in quanto alla velocità di
esecuzione, dato che il processore 6502 utilizza istruzioni a numero variabile
di cicli di clock, dettaglio non implementato per semplicizzare.

## Caratteristiche "hardware"
| Tipo di memoria | Grandezza |
| --------------- | --------- |
| RAM             | 4 KB      |
| VRAM            | 8 KB      |
| SRAM            | 1 KB      |
| ROM             | 31 KB     |

### Schermo
Lo schermo a disposizione è quello del GBA in "Mode 0" e fisso, cioè 30x20
tiles, con ogni tile di dimensione 8x8.\
Sono disponibili 64 tile diversi e una palette di 8 colori a scelta.\
Il framerate non è ulteriormente limitato, mantenendo quindi i circa 60 Hz
che offre il GBA.

### Bottoni
Il GBA ha 10 bottoni, di cui 8 sono a disposizione dell'emulatore: 'L' ed 'R'
sono stati rimossi.

## Interfaccia 
La ROM del programma per 6502 viene letta dal file di salvataggio del GBA.\
Il primo 1 KB viene utilizzato per la SRAM dell'emulatore.

## Motivazione
Oltre all'interesse personale per il mio primo progetto interamente in assembly,
l'obiettivo di questo progetto è di essere presentato all'esame di 'Architettura
degli Elaboratori'.\
Questo emulatore infatti presenta la struttura di base di un processore ed è
interamente realizzato in linguaggio assembly ARM 7, insegnato durante il corso.

## Risorse
Riguardo il processore 6502:
- [6502-emulator](https://github.com/Vulcalien/6502-emulator), un mio precedente
  emulatore scritto in C.
- [Questo sito](http://web.archive.org/web/20210803072420/http://www.obelisk.me.uk/6502/)
  che descrive in dettaglio le istruzioni e le modalità di indirizzamento.

Riguardo il GBA:
- [GBATEK](https://problemkaputt.de/gbatek.htm), una descrizione dettagliata
  della console.
- [Minicraft per GBA](https://github.com/Vulcalien/minicraft-gba/), un mio
  progetto da cui ho preso alcuni file di configurazione e che ho talvolta usato
  come riferimento.
