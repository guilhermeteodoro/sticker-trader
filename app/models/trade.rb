# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :user_a, class_name: "User"
  belongs_to :user_b, class_name: "User"

  validates :balanced_data, presence: true

  def confirmed?
    confirmed_at.present?
  end

  def a_gives_labels
    balanced_data.dig("a_gives") || []
  end

  def b_gives_labels
    balanced_data.dig("b_gives") || []
  end
end
