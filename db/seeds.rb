
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
