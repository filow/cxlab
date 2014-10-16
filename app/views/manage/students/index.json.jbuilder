json.array!(@manage_students) do |manage_student|
  json.extract! manage_student, :id, :stuid, :name, :email, :phone, :grade ,:pwd
  json.avatar manage_student.avatar_url(:thumb_mini)
  json.url manage_student_url(manage_student, format: :json)
end
