class ChatController < ApplicationController
  def home
    @chat_response = "Click the button below to start chatting!"
    if params[:chat_response].present?
      @chat_response = params[:chat_response]
    end
    if params[:voice_input].present?
      @voice = params[:voice_input]
    end
  end

  def chat
    emotion = params[:emotion]
    voice = params[:voice_input]
    unless emotion.present?
      render json: { error: 'Emotion label is required' }, status: :bad_request
      return
    end

    file_path = Rails.root.join('app', 'assets', 'config', 'animated_emoji_description.json')
    unless File.exist?(file_path)
      render json: { error: 'Configuration file not found' }, status: :internal_server_error
      return
    end

    file = File.read(file_path)
    emoji_descriptions = JSON.parse(file)
    description = emoji_descriptions[emotion]['description']

    if description
      redirect_to action: 'home', chat_response: description, voice_input: voice
    else
      render json: { error: 'Emotion label not found' }, status: :not_found
    end
  end
end
