# Head-fixed Behavior
This repository contains information about an open-source, multisensory head fixed setup for operant conditioning. Here, we want to share all relevant information about the setup used in the publication ["Single-trial neural dynamics are dominated by richly varied movements"](https://www.nature.com/articles/s41593-019-0502-4) by Musall et al. One example of using the setup is the [PuffyPengiun](https://github.com/musallGroup/PuffyPenguin) paradigm for multisensory stimulation.

# Overview
Operant conditioning is essential for quantifying animal perception. We developed a head-fixed setup to  measure the behavioral output of animals while recording their brain activity with optophysiological and electrophysiological methods. This setup can perform a variety of protocols ranging from auditory, visual, tactile and even multi sensory. The protocols themselves are highly customizable so that they can be tailored precisely to the respective research objective.

# Installation
Please refer to the manual for detailed installation steps.

# Software
At the moment the setup  is running with Matlab, Bpod (Matlab based).
To prepare your experiments start Matlab and enter "bpod" into the console. This will open the Bpod GUI. Flush the spouts and press the start button after the spouts are flushed (this has to be calibrated occasionally). Afterwards,  choose your paradigm and adjust your subject and settings. Adjust your spouts positions to a proper one and press the "give water" button. Place your mouse into the setup and head fix it. The lick detection threshold may need to be adjusted. Toggle the button in the upper left from pause to run. If your experiment is done press the "stop" button.

# Future
Stay tuned for new paradigms and new features of the head-fixed setup.
### Currently we are working on automation of data management and mouse detection.
