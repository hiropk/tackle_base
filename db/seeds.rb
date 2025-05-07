if Rails.env.development?
  User.all.each { |user| user.destroy }
  User.new(
    email_address: "admin@example.com",
    password: "P@ssword1234",
    password_confirmation: "P@ssword1234",
    is_admin: true).save
  admin = User.find_by(is_admin: true)

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

  if Tackle.count.zero?
    suffix = Time.current.strftime("%Y-%m-%d_%H:%M:%S")
    tackles = []
    rods = Rod.order("RANDOM()").limit(10).to_a
    reels = Reel.order("RANDOM()").limit(10).to_a
    leaders = Leader.order("RANDOM()").limit(10).to_a
    10.times do |i|
      tackles << { user: admin, name: "タックル#{i}_#{suffix}", rod: rods[i], reel: reels[i], knot: 1, leader: leaders[i], notes: "メモ#{suffix}" }
    end
    Tackle.create!(tackles)
  end


  menus = [ "ネギング", "ジギング", "ライトジギング", "スーパーライトジギング", "白イカ" ]
  base_date = Date.today
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
          notes: Log::RECORD_TEXT,
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
end

if Rails.env.production?
  User.new(
    email_address: "admin@example.com",
    password: "P@ssword1234",
    password_confirmation: "P@ssword1234",
    activated: true,
    is_admin: true).save
end
