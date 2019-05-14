FROM nfcore/base
LABEL authors="lorena.pantano@gmail.com" \
      description="Docker image containing all requirements for the pilm-bioinformatics/homer pipeline"

COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH /opt/conda/envs/homer-nf/bin:$PATH
