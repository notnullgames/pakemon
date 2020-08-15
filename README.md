# Pakémon

Short for "packet monitor/monster". Gamified fun device/platform for hacking technology around you.


## software

The Pakémon runs [love2d](https://love2d.org/) to manage a collection of activities. A few libraries are available for use in mini-games or activities, so you can keep the samne look/feel, if you want, but also feel free to go crazy and make yours completely differnt than the rest. Think of it as the geocities of hacking toys.

**TODO**: document dependencies

**TODO**: document shared API

**TODO**: document dev-tools

**TODO**: document making a few types of plugins

## related

These other projects are related:

### plugins

If you prefix your plugin repo-name with `pakemon-plugin-`, it'll show up on the device for easy install, under "Community Plugins".

**TODO**

### tools

* [pakemon-personalitybuilder](https://github.com/notnullgames/pakemon-personalitybuilder) - tools to build a new personality for Pakémon
* [pakemon-icon-server](https://github.com/notnullgames/pakemon-icon-server) - this is used to create icon images for maps with scaling & rotation

## ideas

These are just a colleciton of ideas, and could change drastically.


## Abstract:
What if Pokemon and Tomagotchi got together with some AI 
to learn a new trick, but all three had a baby and made 

## A suite of fun devices:

### The GoodBuy Buddy
* a drop box, collects infos, spreads mesh, helps make 
friends probably likes to live in RAM.
* a drop box could be upgraded with more power to help compute
* "The Goodbuy Buddy" usually doesn’t come with a head, 
and is prone to a short life, please handle with care, 
maybe feed them electricity for extra points from time to time. 

### HackX/HackBoi/HackGRRL (call them what you will, it’s the main handheld)
* This will need a joystick and screen at minimum,
plus your choice interfaces.
* This document will focus on the larger variant, 
with reference to making it even smaller.    


# Hardware approach
This design will feature the RPi zero W as the main SoC 
and focus on a modular approach for hardware, though given 
a large enough chassis, the selected features could be built 
monolithic with all components housed internally. 

* (Expect prototypes to not be modular.) 

An ideal module could be stored in a game cartridge and supply 
various features to the device via an external facing bus via GPIO. 

* (Solution unknown)  

## Minimal hardware requirements:
Raspberry Pi zero W
A battery
(seeking a cheaper solution for a drop off “Goodbuy Buddy” SoC )

### optional hardware: 
display, joystick, buttons, cc1111, standard rtl-srd, (some unknown NFC) 

#### other optional: 
hackRF, solar-power 

## Screens:
cheap LCD, e-paper

## Batteries:

## Joystick boards: 

## Suggested cases:

## Full kits:

### GameBoy form factor: 

https://www.renegadelabs.net/product/gameboy-cm3-phoenix-diy-kit/
https://www.renegadelabs.net/product/gameboy-zero-raspberry-pi-modded-gameboy/
https://www.experimentalpi.com/PiBoy-DMG--Full-Kit_p_18.html

### GBA Form factor
https://www.renegadelabs.net/product/gameboy-zero-ez-gba-diy-kit/

### Other:
https://learn.adafruit.com/pigrrl-raspberry-pi-gameboy
https://learn.adafruit.com/pigrrl-2
https://learn.adafruit.com/pigrrl-zero

* Ebay.com or your closet.

Any existing handheld gaming system that fits your needs!  
Things you can Imagine! Really, anything that fits all the 
goodies you want and feel comfortable using. 

# Software approach 

## A simplified UI Concept pipe dream:

### The Buddy System! 
* Packets as Pocket Monsters; e.g. Collect enough packets and 
level up your buddy for a special ability.
* (hard mode? Buddy gets neglected and loses XP! ( oh no! Level down! ( scoreboard? ) )
* Buddy makes friends over LoRa, or otherwise to lend a hand, get help and share infos.  
* Buddies know where the party is at and can share way points to “fun” zones. 
* Your Buddy has room for baggage and can plug-in modules for custom moves. 

### Home away from home. 
* After your "Packet Monsters" level up enough, they can help your buddy set up shop.
* Buddies love to setup a few different vacation homes and sometimes employ house sitters.  
* Some house sitters enjoy mining. 
* Others like solving cryptic puzzles.
* Then there's the ones that sleep until their buddies hit them up to party. 

### Less abstract 
* hot key sequence to switch "game" modes. 
* write a massive portable C library that wraps utils that can be used in a high level languge 
 * like this pseudo code: 

```lua
while gets_signals(430mhz) = i_want; then 
  packat_monster.signal(430mhz).add(happy(2)) 
 else 
  packet_monster.signal(430mhz).add(sad(2)) 
end

if packet_monster.signal(430mhz.is(mood) = "happy" ; then
  packet_monster.signal(430mhz).special_move(garageDoor.at(waypoint))
fi
```

* things should be pretty auto, with an optional manual mode out of the box.
* there should be a "bring your own UX" potential.  

## AI concept
to rework the pwnagotchi's [A2C](https://hackernoon.com/intuitive-rl-intro-to-advantage-actor-critic-a2c-4ff545978752) [AI](https://pwnagotchi.ai/usage/#training-the-ai) to support DeepExploit. 


## utils/tools/frameworks
As a note: there are a ton of tools out there, some do the same thing, but in a different way.
A best solution could be to find projects with a good track record of up-stream development, and 
use those. 


* [nmap]() Plate, and flatware. 
* [metasploit]() bread and butter
* [bettercap]() wireless packet capture
* [p0f](https://lcamtuf.coredump.cx/p0f3) A passive packet fingerprint scanner. 
[unofficial github](https://github.com/p0f/p0f)


* [rpitx](https://github.com/F5OEO/rpitx) SDR built with only a RPi! 


## Networking
* https://github.com/meshtastic/Meshtastic-device
* https://github.com/crockpotveggies/lora-mesh-rs
 * a lossy ipv4 network stack written in rust.
* DASH7 Open Source Stack [oss7](http://mosaic-lopow.github.io/dash7-ap-open-source-stack/) 
 * [oss](https://github.com/MOSAIC-LoPoW/dash7-ap-open-source-stack) github. 
 * DASH7 python support[pyd7a](https://github.com/MOSAIC-LoPoW/pyd7a)



## Libs
* [libpcap]()

### UI
* [love2d](https://love2d.org/)
* [termbox](https://github.com/nsf/termbox)

## Issues
[DeepExploit](https://github.com/13o-bbr-bbq/machine_learning_security/tree/master/DeepExploit)
has a few issues scanning all the types of networks available and only works from certain vectors.
A solution could be better info gathering AI, perhaps "3 modes"; "passive, normal, aggresive and custom".

~~will not talk about plan9/inferno OS~~

# Resources: 

## Pentesting
* https://github.com/enaqx/awesome-pentest

## AI

* [an AI challange](https://aichallenge.cyberweek.ae/) Working on Deep Exploit
* https://towardsdatascience.com/artificial-intelligence-framework-a-visual-introduction-to-machine-learning-and-ai-d7e36b304f87
* [A Master Attack Methodology for an AI-Based Automated Attack Planner for Smart Cities](https://scienceimpact.mit.edu/sites/default/files/documents/08449268.pdf)
* [A2C:](https://hackernoon.com/intuitive-rl-intro-to-advantage-actor-critic-a2c-4ff545978752) Advantage-Actor-Critic
* [Explore-Exploit: A Framework for Interactive and Online Learning](https://arxiv.org/abs/1812.00116?context=cs.AI) a [PDF](https://arxiv.org/pdf/1812.00116.pdf) from Cornell.  

### RNN (recurrent-neural-networks)
* https://stanford.edu/~shervine/teaching/cs-230/cheatsheet-recurrent-neural-networks
* https://www.tensorflow.org/guide/keras/rnn

## influenced by: 
* [pwnagotchi](https://github.com/evilsocket/pwnagotchi)
* [DeepExploit](https://github.com/13o-bbr-bbq/machine_learning_security/tree/master/DeepExploit)
* [flipper one / flipper zero](https://flipperzero.one/)
* [hackRF + custom firmware (current: Mayhem) and UI](https://github.com/eried/portapack-mayhem) 

[GPi  case]()
[Piboy DMG (unreleased)](https://www.experimentalpi.com/PiBoy-DMG--Full-Kit_p_18.html)
[GameBoy Zero EZ-GBA DIY kiy](https://www.renegadelabs.net/product/gameboy-zero-ez-gba-diy-kit/)
[PiGRRL](https://learn.adafruit.com/pigrrl-zero)



