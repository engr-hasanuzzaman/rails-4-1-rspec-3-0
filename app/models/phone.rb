class Phone < ActiveRecord::Base
  belongs_to :contact

  validates :phone, presence: true, uniqueness: { scope: :contact_id }
end
