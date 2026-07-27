# Firmware

Arduino/Teensy firmware for the setup's microcontroller-driven components.

- [`touchshaker/`](touchshaker) — Teensy 4.0 firmware for the Touchshaker box: reads the spout
  lick sensors and drives the spout motors
- [`rfid_scale/`](rfid_scale) — Teensy firmware that reads an RFID tag and a load cell together,
  for automated per-animal weighing
- [`openscale/`](openscale) — Vendored [SparkFun OpenScale](https://github.com/sparkfun/OpenScale)
  firmware, used by the weighing scale hardware

See [docs/MANUAL.md](../docs/MANUAL.md) for how these boards fit into the overall setup.
