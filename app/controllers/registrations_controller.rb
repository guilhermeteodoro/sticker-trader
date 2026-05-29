# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    render Views::Registrations::New.new
  end

  def create
    user = User.new(name: params[:name], email: params[:email]&.downcase&.strip)

    parsed_data = parse_sticker_data
    unless parsed_data
      flash.now[:error] ||= "Could not parse sticker data. Please check your input."
      render Views::Registrations::New.new, status: :unprocessable_entity
      return
    end

    if user.save
      CollectionImporter.new(user, parsed_data).call
      session[:user_id] = user.id
      redirect_to collection_path(user), notice: "Welcome, #{user.name}!"
    else
      flash.now[:error] = user.errors.full_messages.join(", ")
      render Views::Registrations::New.new, status: :unprocessable_entity
    end
  end

  private

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
