% Symptoms
symptom(fever).
symptom(cough).
symptom(headache).
symptom(sore_throat).
symptom(runny_nose).
symptom(muscle_aches).
symptom(fatigue).
symptom(nausea).
symptom(vomiting).
symptom(diarrhea).
symptom(rash).

% Diseases
disease(flu, [symptom(fever), symptom(cough), symptom(headache), symptom(sore_throat), symptom(runny_nose)]).
disease(cold, [symptom(cough), symptom(sore_throat), symptom(runny_nose)]).
disease(covid19, [symptom(fever), symptom(cough), symptom(fatigue), symptom(muscle_aches)]).
disease(food_poisoning, [symptom(nausea), symptom(vomiting), symptom(diarrhea)]).
disease(allergic_reaction, [symptom(rash), symptom(itching)]).

% Diagnosis based on symptoms (consult a doctor for accurate diagnoses)
diagnose(Symptoms, Disease) :-
  disease(Disease, DiseaseSymptoms),
  length(DiseaseSymptoms, NumSymptoms),
  count_matching_symptoms(Symptoms, DiseaseSymptoms, Count),
  Count >= floor(NumSymptoms * 0.7).  % Adjust threshold as needed

count_matching_symptoms([], _, 0).
count_matching_symptoms([Symptom | Rest], DiseaseSymptoms, Count) :-
  member(Symptom, DiseaseSymptoms),  % Check if symptom matches disease
  !,  % Cut to avoid redundant checks
  count_matching_symptoms(Rest, DiseaseSymptoms, Count1),
  Count is Count1 + 1.
count_matching_symptoms([_ | Rest], DiseaseSymptoms, Count) :-
  count_matching_symptoms(Rest, DiseaseSymptoms, Count).

% Example usage (replace with actual symptoms)
symptoms([symptom(fever), symptom(cough), symptom(fatigue)]).
query(diagnose(symptoms, Disease)).

