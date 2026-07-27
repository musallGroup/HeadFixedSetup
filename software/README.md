# Software

MATLAB code for controlling and monitoring the setup.

- [`autopilot/`](autopilot) — Autopilot GUI app for spout position adjustment and animal-weight
  recording during a session
- [`udp/`](udp) — UDP client/server that lets a behavioral (setup) PC and a server PC coordinate
  automated sessions: the setup PC sends the RFID/weight reading it picked up for the animal that
  just entered, and the server looks up that subject's paradigm, settings, and stage and sends
  them back
- [`bpod_local/`](bpod_local) — Local Bpod calibration reference files; the `settings/` and
  `data/` subfolders are machine-specific and gitignored (Bpod recreates them per install)

See [docs/MANUAL.md](../docs/MANUAL.md) for how to set up and run Bpod, and the
[Running a session](../docs/MANUAL.md#running-a-session) section for day-to-day operation.
