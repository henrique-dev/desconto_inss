#json.array! @schedulings, partial: "schedulings/scheduling", as: :scheduling
json.array!(@medic_evaluations) do |medic_evaluation|
    json.id medic_evaluation.id
    json.description medic_evaluation.description
    json.rating medic_evaluation.rating
    json.medic_name medic_evaluation.medic_profile.name
    json.created_at medic_evaluation.created_at.strftime("%d/%m/%Y")
end