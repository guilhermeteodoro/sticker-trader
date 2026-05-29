# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :set_user

  def show
    is_owner = current_user&.id == @user.id
    trade_result = if current_user && !is_owner
      TradeComparer.new(current_user, @user).call
    end

    render Views::Collections::Show.new(
      user: @user,
      is_owner: is_owner,
      trade_result: trade_result,
      current_user: current_user
    )
  end

  def edit
    unless current_user&.id == @user.id
      redirect_to collection_path(@user)
      return
    end

    render Views::Collections::Edit.new(user: @user)
  end

  def update
    unless current_user&.id == @user.id
      redirect_to collection_path(@user)
      return
    end

    parsed_data = parse_sticker_data
    unless parsed_data
      flash.now[:error] ||= "Could not parse sticker data. Please check your input."
      render Views::Collections::Edit.new(user: @user), status: :unprocessable_entity
      return
    end

    CollectionImporter.new(@user, parsed_data).call
    redirect_to collection_path(@user), notice: "Collection updated!"
  end

  private

  def set_user
    @user = User.find_by!(slug: params[:slug])
  end

  def parse_sticker_data
    case params[:import_method]
    when "dump"
      DumpParser.new(params[:dump]).call
    when "manual"
      ManualParser.new(
        missing_text: params[:missing_text],
        duplicates_text: params[:duplicates_text]
      ).call
    end
  rescue DumpParser::ParseError, ManualParser::ParseError => e
    flash.now[:error] = e.message
    nil
  end
end
