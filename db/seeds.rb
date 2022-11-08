# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email:    'kanri1@example.com',
   password: '000000',
)

customers = Customer.create!(
   [
      { last_name: '令和', first_name: '道子', last_name_kana: 'レイワ', first_name_kana: 'ミチコ', user_name: 'みちこ', email: 'michiko@example.com', password: '111111' },
      { last_name: '平成', first_name: '太郎', last_name_kana: 'ヘイセイ', first_name_kana: 'タロウ', user_name: 'たろう', email: 'taro@example.com', password: '222222' },
      { last_name: '昭和', first_name: '一郎', last_name_kana: 'ショウワ', first_name_kana: 'イチロウ', user_name: 'いちろう', email: 'ichiro@example.com', password: '333333' },
      { last_name: '大正', first_name: '二郎', last_name_kana: 'タイショウ', first_name_kana: 'ジロウ', user_name: 'じろう', email: 'ziro@example.com', password: '444444' },
      { last_name: '明治', first_name: '三郎', last_name_kana: 'メイジ', first_name_kana: 'サブロウ', user_name: 'さぶろう', email: 'saburo@example.com', password: '555555' },
   ]
)

tags = ["20代", "30代", "腹筋", "背筋", "ジョギング","ピラティス"]
tags.length.times do |i|
 Tag.create!(
    name: tags[i]
)
end

customers.length.times do |i|
   Post.create!(
      title: '肥満解消',
      introduction: '運動不足解消に手軽なものを探しています',
      customer_id: i+1
   )
end

posts = Post.all
posts.length.times do |i|
   TagList.create!(
      post_id: i+1,
      tag_id: i+1
   )
end