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

  def show_content
    @content = "Once upon a time, there was a magic backpack that could fly."
  end

  def custom_content
    @id = params[:id]
    @summary = ['summary1', 'summary2', 'summary3']
    @point_of_view = ['point_of_view1', 'point_of_view2', 'point_of_view3']
    @pick_up = ['pick_up_line1', 'pick_up_line2', 'pick_up_line3']
    render :custom_content,  id: params[:id]
  end
end
