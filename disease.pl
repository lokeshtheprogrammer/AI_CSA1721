% Disease and recommended diet facts
recommended_diet(diabetes, low_sugar_diet).
recommended_diet(hypertension, low_salt_diet).
recommended_diet(celiac_disease, gluten_free_diet).

% Query for diet based on disease
diet_for_disease(Disease, Diet) :-
    recommended_diet(Disease, Diet).

