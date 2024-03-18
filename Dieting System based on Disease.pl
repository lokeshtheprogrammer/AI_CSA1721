disease(diabetes, "low-carb diet").
disease(heart_disease, "low-fat diet").
disease(obesity, "calorie-controlled diet").

% Sample consultation (replace with your knowledge base)
consultation(patient('Alice'), disease(diabetes)).
consultation(patient('Bob'), disease(heart_disease)).
consultation(patient('Charlie'), disease(obesity)).

% Recommend diet based on disease
recommend_diet(Patient, Diet) :-
  consultation(Patient, Disease),
  disease(Disease, Diet).

