Fabricator(:story) do
  title { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph }
  approved_at { Time.now }
end
