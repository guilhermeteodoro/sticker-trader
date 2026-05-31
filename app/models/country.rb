# frozen_string_literal: true

# == Schema Information
#
# Table name: countries
#
#  id    :integer          not null, primary key
#  code  :string           not null
#  emoji :string           not null
#
# Indexes
#
#  index_countries_on_code  (code) UNIQUE
#
class Country < ApplicationRecord
  has_many :stickers, dependent: :restrict_with_error

  validates :code, presence: true, uniqueness: true
  validates :emoji, presence: true

  def name
    I18n.t("countries.#{code}")
  end
end
