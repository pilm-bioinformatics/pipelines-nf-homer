# pipelines-nf-homer

[![Build Status](https://travis-ci.org/pilm-bioinformatics/pipelines-nf-homer.svg?branch=master)](https://travis-ci.org/pilm-bioinformatics/pipelines-nf-homer)
[![Nextflow](https://img.shields.io/badge/nextflow-%E2%89%A50.32.0-brightgreen.svg)](https://www.nextflow.io/)
[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/)


Run [homer](http://homer.ucsd.edu/homer/introduction/configure.html) find motif pipeline:

It accepts multiple input files that will use the same background file.

## test data

`nextflow run pilm-bioinformatics/pipelines-nf-homer -profile test,conda --install`

## Real data

`nextflow run pilm-bioinformatics/pipelines-nf-homer --deg "PATH/your_intpus*.txt" --bg "PATH/your_background.txt" --len "6,10" --outdir results/human_NeuNn --species human`

## Install Netflow

```
# Make sure that Java v8+ is installed:
java -version

# Install Nextflow
curl -fsSL get.nextflow.io | bash

# Add Nextflow binary to your PATH:
mv nextflow ~/bin/
# OR system-wide installation:
# sudo mv nextflow /usr/local/bin
```


## Usage in the openMind cluster

If you are an user from the Picower Institute, you can follow this intruction: Not yet available.
