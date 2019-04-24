# Readme

This is a set of datasets and code for fitting regression models to produce predictive dental ecometric models. This is to accompany a paper:
Oksanen et al. (2019). A Humboldtian approach to life and climate of the geological past: estimating palaeotemperature from dental traits of mammalian communities. To appear in Journal of Biogeography.

This repository concerns only ecometric model fitting on the present day data. Fossil species and their dental traits are given in the appendix of the paper.

## Raw datasets

This directory contains raw datasets: occurrence of species at localities, climate at localities and dental traits at present day. These datasets can be used for producing ecometric models. The datasets given in full such that interested readers could apply their own filtering. The filtering that was used in Oksanen et al (2019) is described in the paper (e.g. high elevation sites removed, sites with less than 3 species removed and more).

Directory:

	data_for_ecometrics
	
Files:

	occurence_IUCN_AF.csv -- species occurrence, Africa
	occurence_IUCN_EU.csv -- species occurrence, Eurasia
	occurence_IUCN_NA.csv -- species occurrence, North America
	occurence_IUCN_SA.csv -- species occurrence, South America
	crown_types_v12.csv -- dental traits for species
	data_sites_bio_old.csv -- climatic variables at sites, based on the old version of WorldClim (Hijmans et al 2005)
	data_sites_bio_new.csv -- climatic variables at sites, based on the new version of WorldClim (Fick and Hijmans 2017)

## Script for modeling

This directory contains a plain script for fitting regression models on present day data and plots dental trait and climate variable maps.
Data aggregation pipeline is not included here, this directory gives processed data where dental traits are averaged for each site. Raw data is given in directory data_for_ecometrics.
	
Directory:
	
	analysis
	
Run script:
	
	run_modeling.R
	
Regression models will be printed out in the common line, and the resulting plots can be found in directory:

	anaysis/plots