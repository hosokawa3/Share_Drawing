# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

hosokawa = EndUser.find_or_create_by!(email: "hoso@hoso") do |enduser|
  enduser.name = "ほそかわ"
  enduser.password = "hosohoso"
  enduser.introduction = "上達のためのアドバイスをいただきたいです！"
  enduser.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

aka = EndUser.find_or_create_by!(email: "aka@aka") do |enduser|
  enduser.name = "赤"
  enduser.password = "akaaka"
  enduser.introduction = "リアルさを追求したい。。"
  enduser.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

suisai = EndUser.find_or_create_by!(email: "suisai@suisai") do |enduser|
  enduser.name = "水彩"
  enduser.password = "suisaisuisai"
  enduser.introduction = "アナログ多めです"
  enduser.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

Post.find_or_create_by!(title: "女性") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.caption = "色塗りの工程が安定しない"
  post.end_user = hosokawa
end

Post.find_or_create_by!(title: "元気") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg")
  post.caption = "リハビリです"
  post.end_user = hosokawa
end

Post.find_or_create_by!(title: "果実") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg")
  post.caption = "リアルに見せたい"
  post.end_user = aka
end

Post.find_or_create_by!(title: "視線の先") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg")
  post.caption = "何が見えるのか"
  post.end_user = suisai
end

Post.find_or_create_by!(title: "男性") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.JPG"), filename:"sample-post5.JPG")
  post.caption = "向けられる微笑み"
  post.end_user = suisai
end

Post.find_or_create_by!(title: "頬杖") do |post|
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg")
  post.caption = "穏やかな雰囲気を意識しました"
  post.end_user = hosokawa
end