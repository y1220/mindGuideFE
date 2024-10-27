class ContentController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :generate

  def generate
    prompt = params[:prompt] || "Write a story about a magic backpack."
    response = GenerativeAiClient.new.generate_content(prompt)
    if response
      content_text = response.dig("candidates", 0, "content", "parts", 0, "text")
      render json: { content: content_text }
    else
      render json: { error: "Failed to generate content" }, status: :unprocessable_entity
    end
  end
end
