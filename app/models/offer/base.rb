# == Schema Information
#
# Table name: offers
#
#  id            :uuid             not null, primary key
#  user_id       :uuid
#  title         :string(128)
#  summary       :string(255)
#  description   :text
#  location      :spatial          point, 4326
#  address1      :string(128)
#  address2      :string(128)
#  postal_code   :string(32)
#  neighbourhood :string(128)
#  city          :string(128)
#  province      :string(128)
#  country       :string(128)
#  timeframe     :string(128)
#  length        :integer
#  created_at    :datetime
#  updated_at    :datetime
#  deleted_at    :datetime
#  type          :string(128)
#
# Indexes
#
#  index_offers_on_user_id  (user_id)
#

class Offer::Base < ActiveRecord::Base
  include StiBase
  include HasLatLngAccessiblePoint

  acts_as_paranoid
  acts_as_taggable
  acts_as_taggable_on :availabilities
  acts_as_sti_base

  self.table_name = :offers

  lat_lng_accessible_point_columns :location

  belongs_to :user, inverse_of: :offers

  validates :user, presence: true

  def self.policy_class
    OfferPolicy
  end
end
