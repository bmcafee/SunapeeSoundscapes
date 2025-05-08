# The *Listening to Lakes* Project

We can see water color, we can feel lake turnover, but can we hear the bustling lake ecosystem? The *Listening to Lakes* seeks to turn the underwater soundscape into an indicator of biological activity.

## Methods
### Data Collection

A hydrophone (SoundTrap ST600, Ocean Instruments NZ) is deployed on the Lake Sunapee Protective Association (LSPA) GLEON Buoy collecting acoustic data throughout the summer. At the end of the season, this data should be exported from the hydrophone and stored in a local file system, to be shared later.

### Manual Data Annotation

1. Download and install the Raven Lite 2 software using the instructions at <https://www.ravensoundsoftware.com/software/raven-lite/>. Raven is a free software program that allows for the annotation of audio files.
2. Ensure that the `*.xml` and `*.wav` files exported from the hydrophone are located in any of the `Downloaded *` folders within a copy of this repository.
3. Run the `00_FileOrganization.R` script in R to create the `audio_and_annotation_file_guide.csv` file. This script extracts the metadata for each audio file and saves it alongside a path to the audio file and a template path to the annotation file. The annotation file will be created ising Raven.
4. Use Raven to create annotations of the audio files. Upon opening an audio file, disable the waveform view so that only the spectrogram view is visible. Each annotation is saved as a start time, end time, minimum frequency, and maximum frequency, with a single-letter label denoting the type of sound. The labels currently used are:
    - B = Boat or other motorized watercraft
    - C = High surface activity, likely from anthropogenic source (such as a boat's wake)
5. After annotating a file, save the selection table to the `annotations` folder using the default filename. This should line up with a path described in `audio_and_annotation_file_guide.csv`.
6. Continue to annotate audio files until there are approximately 200 positive identifications of each of the annotation types of interest. These annotations will be the training data for our automated annotation system.

### Automated Annotation [WIP]

- [WIP] Run the `01_TrainingDataCreation.R` script to sort the annotation guide into annotated and unannotated files.
- [WIP] Train a convolutional neural network (CNN) to automatically annotate files. This will likely be based on the procedure used by [Lapp et al. (2024)](https://www.journals.uchicago.edu/doi/full/10.1086/729422).
