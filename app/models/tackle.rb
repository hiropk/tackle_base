class Tackle < ApplicationRecord
  belongs_to :user
  belongs_to :rod
  belongs_to :reel
  belongs_to :leader
  has_many :tackle_selections, dependent: :destroy
  has_many :logs, through: :tackle_selections

  validates :name, presence: true, uniqueness: { scope: [ :user_id ], message: "はすでに使われています" }, length: { maximum: 50 }
  validates :rod_id, presence: true, uniqueness: { scope: [ :user_id, :reel_id ], message: "とリールの組み合わせはすでに存在します" }
  validates :reel_id, presence: true
  validates :leader_id, presence: true
  validates :notes, length: { maximum: 1000 }

  enum :knot, {
    knot_none: 0,
    uni_knot: 1,
    improved_clinch_knot: 2,
    palomar_knot: 3,
    fg_knot: 4,
    albright_knot: 5,
    double_uni_knot: 6,
    blood_knot: 7,
    surgeon_knot: 8,
    loop_knot: 9,
    perfection_loop: 10,
    dropper_loop: 11,
    snell_knot: 12,
    nail_knot: 13,
    davy_knot: 14,
    trilene_knot: 15,
    arbour_knot: 16,
    spider_hitch: 17,
    bimini_twist: 18,
    haywire_twist: 19,
    san_diego_jam: 20,
    rapala_knot: 21,
    yucatan_knot: 22,
    king_sling: 23,
    non_slip_loop: 24,
    offshore_swivel_knot: 25,
    tokyo_rig_knot: 26
  }

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "knot", "leader_id", "name", "notes", "reel_id", "rod_id", "updated_at", "user_id" ]
  end
end
