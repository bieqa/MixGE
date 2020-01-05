# MixGE
Mixed Effect Model for Genetic-Set and Environment Interaction and its Application to Tensor-Based Morphometry

Imaging genetics is an emerging field for the investigation of neuro-mechanisms linked to genetic variation. Although imaging genetics has recently shown great promise in understanding biological mechanisms for brain development and psychiatric disorders, studying the link of genetic variants with neuroimaging phenotypes remains statistically challenging due to high-dimensionality of both genetic and neuroimaging data. This becomes even more challenging when studying the effect of gene-environment interaction on brain phenotypes.

This MATLAB Toolbox provides a mixed effect model for gene-environment interaction (MixGE) on neuroimaging phenotypes, such as structural volumes and tensor-based morphometry (TBM). This model incorporates both fixed and random effects of genetic-set and environment interaction, to investigate homogeneous and heterogeneous contributions of sets of genetic variants and their interaction with environmental risks to phenotypes. To avoid direct parameter estimation in the MixGE model due to small sample size and high computational cost, score statistics were constructed for the terms associated with fixed and random effects of the genetic-set and environment interaction. They were combined into a single significance value.

This toolbox also provides examples for scalar brain measures and whole-brain measure (see readme.pdf).

Reference: 

Changqing Wang, Jianping Sun, Tian Ge, Derrek P. Hibar, Celia MT Greenwood, Anqi Qiu*, “A Mixed Effect Model for Genetic-Set and Environment Interaction and its Application to Tensor-Based Morphometry”, Frontier in Neuroscience: Brain Imaging Methods, 11:191, 2017. https://doi.org/10.3389/fnins.2017.00191
