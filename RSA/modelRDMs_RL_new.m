function Models = modelRDMs_RL_new()
%

Models.Stimulus_selective  = [
    1 0 0 1
    0 1 1 0
    0 1 1 0
    1 0 0 1];% Dissimilarity matrix (RDM)--Stimulus_selective model

Models.Outcome_selective  = [
    0 0 1 1
    0 0 1 1
    1 1 0 0
    1 1 0 0];% Dissimilarity matrix (RDM)--Outcome_selective model

Models.Outcome_selective2  = [
    0 1 1 1
    1 0 1 1
    1 1 0 1
    1 1 1 0];% Dissimilarity matrix (RDM)--Stimulus_selective model



% Models.main_clusters1 = [
% 			0 0 1 0
% 			0 0 1 0
% 			1 1 0 0
% 			0 0 1 0];% Dissimilarity matrix (RDM)--model1
%
% Models.main_clusters2 = [
% 			0 0 0 1
% 			0 0 0 1
% 			0 0 0 1
% 			1 1 1 0];% Dissimilarity matrix (RDM)--model2
%
% Models.main_clusters3 = [
% 			0 0 1 1
% 			0 0 1 1
% 			1 1 0 0
% 			1 1 0 0];% Dissimilarity matrix (RDM)--model3
%
% Models.main_clusters4 = [
% 			0 1 1 1
% 			1 0 0 0
% 			1 0 0 0
% 			1 0 0 0];% Dissimilarity matrix (RDM)--model4
%
% Models.main_clusters5 = [
% 			0 1 0 0
% 			1 0 1 1
% 			0 1 0 0
% 			0 1 0 0];% Dissimilarity matrix (RDM)--model5



end%function
