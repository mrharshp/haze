class VotesController < ApplicationController
  def create
    @list_item = ListItem.find(params[:list_item_id])
    @has_voted = false
    @list_item.votes.each do |vote|
      @has_voted = true if vote.user == current_user
    end
    @vote = Vote.new
    authorize @vote
    if @has_voted

    else
      @vote.user = current_user
      @vote.list_item = @list_item
      @vote.upvote = params[:upvote]
      @vote.upvote == true ? upvote : downvote
      @vote.save
    end
  end

  private

  def upvote
    @list_item.upvote += 1
    @list_item.save
  end

  def downvote
    @list_item.downvote += 1
    @list_item.save
  end
end
