
rods = []
100.times do |i|
  rods << { name: "ロッド#{i+1}", brand: "ブランド#{i+1}", length: 6.5, fishing_type: 0, power: 0, reel_type: 0, min_weight: 100, max_weight: 200, purchase_date: Date.current,  notes: "メモ#{i+1}" }
end

Rod.create(rods)
