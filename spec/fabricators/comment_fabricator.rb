Fabricator(:comment) do
  name { Faker::Name.first_name }
  content { Faker::Lorem.paragraph }
end
