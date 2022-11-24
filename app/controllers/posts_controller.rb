class PostsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
#rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_exemptions

  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])

    post.update!(post_params)

    render json: post
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  #Handle missing record
  def render_not_found_response
    render json: {error: "Post not found"}, status: :not_found
  end

  # Wont work for this lab
  # Handle exemptions
  def handle_invalid_exemptions(invalid)
    render json: {errors: invalid.record.errors.full_message}, status: :unprocessable_entity
  end

end
