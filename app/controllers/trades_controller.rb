# frozen_string_literal: true

class TradesController < ApplicationController
  before_action :require_login

  def create
    other_user = User.find_by!(slug: params[:user_slug])

    result = TradeComparer.new(current_user, other_user).call
    balanced = result.balanced

    # Build the balanced data to persist
    balanced_data = {
      "a_gives" => serialize_balanced_stickers(balanced, :a_gives),
      "b_gives" => serialize_balanced_stickers(balanced, :b_gives)
    }

    trade = Trade.create!(
      user_a: current_user,
      user_b: other_user,
      balanced_data: balanced_data,
      confirmed_at: Time.current
    )

    redirect_to user_path(other_user), notice: t("trades.create.success")
  end

  private

  def require_login
    redirect_to new_session_path unless current_user
  end

  def serialize_balanced_stickers(balanced, direction)
    [:shiny, :coke, :normal].flat_map do |cat|
      balanced.send(cat).send(direction).map(&:label)
    end
  end
end
