# Head-fixed Behavior
This repository contains information about an open-source, multisensory head-fixed setup for operant conditioning. Here, we want to share all relevant information about the setup used in the publication ["Single-trial neural dynamics are dominated by richly varied movements"](https://www.nature.com/articles/s41593-019-0502-4) by Musall et al. One example of using the setup is the [PuffyPenguin](https://github.com/musallGroup/PuffyPenguin) paradigm for multisensory stimulation.

# Overview
Operant conditioning is essential for quantifying animal perception. We developed a head-fixed setup to measure the behavioral output of animals while recording their brain activity with optophysiological and electrophysiological methods. This setup can perform a variety of protocols ranging from auditory, visual, and tactile to multi-sensory stimulation. The protocols themselves are highly customizable so that they can be tailored precisely to the respective research objective.

# Repository structure
```
docs/         MANUAL.md and wiring reference
software/     MATLAB: Autopilot GUI/scale reading, UDP client/server, local Bpod config
firmware/     Arduino/Teensy firmware for the touchshaker and RFID/weighing scale
              (firmware/openscale vendors SparkFun's OpenScale firmware)
hardware/     STL enclosures and Altium/KiCAD PCB design files for the breakout and touchshaker boards
third_party/  Vendored Bpod_Gen2 framework
```
`third_party/bpod_gen2` and `firmware/openscale` vendor third-party projects with local
modifications on top; they are slated to become git submodules pointing at forks once those are
set up. If they've since been converted, initialize them after cloning with:
```
git submodule update --init --recursive
```

# Installation
Please refer to the [manual](docs/MANUAL.md) for detailed installation steps.


![Connections](https://github.com/user-attachments/assets/48c63050-7954-4c85-bdbc-ce866a0ca438)

# Software
The setup runs on MATLAB, with Bpod handling the behavioral state machine. For the full
step-by-step walkthrough of starting MATLAB, calibrating spouts, and running a session, see
[Running a session](docs/MANUAL.md#running-a-session) in the manual.

# Future
Stay tuned for new paradigms and new features of the head-fixed setup. Currently we are working
on automation of data management and mouse detection.

# License
This project is licensed under the GNU General Public License v3.0 — see [LICENSE](LICENSE) for
details.
