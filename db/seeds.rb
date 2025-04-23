
admin = User.find_by(is_admin: true)
if admin.nil?
  admin = User.new(email_address: "admin@example.com", password: "password", password_confirmation: "password")
  admin.save
end

rods_num = Rod.count
if rods_num <= 100
  add_rods_num = 100 - rods_num
  suffix = Time.current.strftime("%Y-%m-%d_%H:%M:%S")
  rods = []
  add_rods_num.times do |i|
    rods << { user: admin, name: "ロッド#{i}_#{suffix}", brand: "ロッド#{i}_ブランド#{suffix}", length: 6.5, fishing_type: 0, power: 0, reel_type: 0, min_weight: 100, max_weight: 200, purchase_date: Date.current, price: 12345,  notes: "メモ#{suffix}" }
  end
  Rod.create!(rods)
end

lines_num = Line.count
if lines_num <= 100
  add_lines_num = 100 - lines_num
  suffix = Time.current.strftime("%Y-%m-%d_%H:%M:%S")
  lines = []
  add_lines_num.times do |i|
    lines << { user: admin, name: "ライン#{i}_#{suffix}", brand: "ブランド#{i}_#{suffix}", pe_rating: 1.5, length: 700, strand_count: 2, marker: true, purchase_date: Date.current, price: 12345,  notes: "メモ#{suffix}" }
  end
  Line.create!(lines)
end

leaders_num = Leader.count
if leaders_num <= 100
  add_leaders_num = 100 - leaders_num
  suffix = Time.current.strftime("%Y-%m-%d_%H:%M:%S")
  leaders = []
  add_leaders_num.times do |i|
    leaders << { user: admin, name: "リーダー#{i}_#{suffix}", brand: "リーダー#{i}_#{suffix}", leader_rating: 1.5, length: 700, material: 1, purchase_date: Date.current, price: 12345,  notes: "メモ#{suffix}" }
  end
  Leader.create!(leaders)
end

reels_num = Reel.count
if reels_num <= 100
  add_reels_num = 100 - reels_num
  suffix = Time.current.strftime("%Y-%m-%d_%H:%M:%S")
  reels = []
  line = Line.last
  add_reels_num.times do |i|
    reels << { user: admin, name: "リール#{i}_#{suffix}", brand: "リール#{i}_ブランド#{suffix}", reel_type: 1, gear_type: 2, line: line, purchase_date: Date.current, price: 12345,  notes: "メモ#{suffix}" }
  end
  Reel.create!(reels)
end

tackles_num = Tackle.count
if tackles_num <= 100
  add_tackles_num = 100 - tackles_num
  suffix = Time.current.strftime("%Y-%m-%d_%H:%M:%S")
  tackles = []
  rod = Rod.last
  reel = Reel.last
  leader = Leader.last
  add_tackles_num.times do |i|
    tackles << { user: admin, name: "タックル#{i}_#{suffix}", rod: rod, reel: reel, knot: 1, leader: leader, notes: "メモ#{suffix}" }
  end
  Tackle.create!(tackles)
end


menus = [ "ネギング", "ジギング", "ライトジギング", "スーパーライトジギング", "白イカ" ]
base_date = Date.today

record_text = <<~TEXT
  【ネギングwith初心者様2名便🔰】

  遊漁船ファミリアです！
  昨日は、釣り初体験でいきなりオフショア参戦兄さんと、オフショア2回目の兄さんを連れて出船〜🚢

  予報では前日からの西風の影響で西側エリアは厳しいとのこと。最近行ってなかった東のポイントへGO💨
  到着してからひと流し目はポロポロと！この調子で行くといいんじゃない？🤔
  なんて思ってたらきました。修行の時間。🧘
  最近本当に潮が悪く苦戦します。。。

  そこから強まる西風。なんとか耐えながら、凪いたタイミングで一気に沖へ！
  そこからはポツリポツリまだマシになっていき、ジジー！っと鳴る初心者さんのリール！きた！と思って上がったのはまさかの良型のイカ…🦑(多分ヤリイカ…)😮‍💨
  そこからはなんとかデカウッカリに、真鯛、アオハタが当たりました。😌

  なかなか当たりがなく厳しい1日でしたが、楽しむ姿も見られ救われました🙏
  また良いご案内ができるよう精進します😇

  #遊漁船ファミリア
  #島根
  #鳥取
  #境港
  #遊漁船
  #スーパーライトジギング
  #ライトジギング
  #ジギング
  #ネギング
  #初心者歓迎
  #開業準備
  #xesta
  #scramble
  #superrightspec
  #turboslj
  #白イカ
  #山陰白イカ
  #オモリグ
  #イカメタル
  #大剣乱舞
  #山陰イカ釣り
  #山陰イカ釣り遊漁船
TEXT

notes_text = "アシストフック1/0が足りないので補充する。"

existing_count = Log.count
missing_count = 100 - existing_count
all_tackles = Tackle.all.to_a

if all_tackles.empty?
  puts "⚠️ Tackleが存在しません。Tackleを先に作成してください。"
else
  if missing_count > 0
    missing_count.times do |i|
      fishing_date = base_date + (existing_count + i) * 3
      log = Log.create!(
        user: admin,
        fishing_date: fishing_date,
        start_time: fishing_date.to_datetime.change(hour: 8),
        end_time: fishing_date.to_datetime.change(hour: 16),
        area: "日本海",
        fishing_guide_boat: "遊漁船ファミリア",
        menu: menus.sample,
        notes: record_text,
        other: notes_text
      )

      # タックルを1〜3個ランダムに選択
      used_tackles = all_tackles.sample(rand(1..3))
      used_tackles.each do |tackle|
        TackleSelection.create!(log: log, tackle: tackle)
      end
    end
    puts "#{missing_count}件のLogレコードと関連付けられたTackleSelectionを追加しました。"
  else
    puts "Logはすでに100件以上存在しています（#{existing_count}件）"
  end
end
