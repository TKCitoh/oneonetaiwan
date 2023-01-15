# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
 email: ENV["ADMIN_EMAIL"],
 password: ENV["ADMIN_PASSWORD"]
)

end_users = EndUser.create!(
  [
    {email: 'sasaki@txt.txt', name: 'Sasaki', password: 'sasaki@txt.txt', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/annpanman.jpg"), filename:"annpanman.jpg")},
    {email: 'yamamoto@txt.txt', name: 'Yamamoto', password: 'yamamoto@txt.txt', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/castle.jpg"), filename:"castle.jpg")},
    {email: 'ohtani@txt.txt', name: 'Ohtani', password: 'ohtani@txt.txt', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/pikachu.jpg"), filename:"pikachu.jpg")}
  ]
)

posts = Post.create!(
  [
    {title: 'ランタン祭り', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/rantan.jpg"), filename:"rantan.jpg"), video: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/rantan-video.mp4"), filename:"rantan-video.mp4"), caption: '日本人にも人気な場所です。', address: '九份', latitude: '25.110160610076303', longitude: '121.84490203857422', end_user_id: end_users[0].id },
    {title: '澎湖の海岸', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/ponghu.jpg"), filename:"ponghu.jpg"), caption: '台湾屈指のリゾート地です。', address: "澎湖", latitude: "23.562728344395214", longitude: "119.46876525878906", end_user_id: end_users[1].id },
    {title: '高雄駅', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/gaoshong-station.jpg"), filename:"gaoshong-station.jpg"), caption: '台湾1綺麗な駅です。', address: "高雄", latitude: "22.62941743286282", longitude: "120.30126363862304", end_user_id: end_users[2].id }
  ]
)

tags = Tag.create!(
  [
    {name: '澎湖,海岸' },
    {name: '高雄,駅' }
  ]
)

PostTag.create!(
  [
    {post_id: posts[1].id, tag_id: tags[0].id },
    {post_id: posts[2].id, tag_id: tags[1].id }
  ]
)

Comment.create!(
  [
    {comment: 'ランタン欲しい！', post_id: posts[0].id, end_user_id: end_users[1].id },
    {comment: '世界ランキング第2位！', post_id: posts[2].id, end_user_id: end_users[0].id },
    {comment: '素晴らしい駅でした。', post_id: posts[2].id, end_user_id: end_users[0].id }
  ]
)


