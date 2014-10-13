json.array!(@manage_students) do |manage_student|
  json.extract! manage_student, :id, :stuid, :name, :email, :phone, :grade
  json.url manage_student_url(manage_student, format: :json)
end
