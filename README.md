# Sparse-Multidimensional-PR
This repository contains all code used in the final version of the paper http://personal.psu.edu/sew347/Sparse_Turnpike_in_Multiple_Dimensions.pdf (submitted). Code is written in MATLAB.

Our main algorithm, MISTR, can be tested through the file "testIt.m". This calls the testing protocol "testHandler.m" to generate test data and call the main algorithm MISTR.m.

To test full support recovery for phase retrieval when data is corrupted by noise, use the file "runTestPhaseRetrieval.m". This calls the testing protocol "testHandlerPhaseRetrieval.m" to generate test data, threshold noise, and run MISTR.m.

Other files are helper functions for these algorithms.

This code is licensed under a GNU General Public License v3.0. Additional details can be found here: https://choosealicense.com/licenses/gpl-3.0/.
