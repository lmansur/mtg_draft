class DraftsController < ApplicationController
  def new
    @sets = CardSet.where(set_type: 'expansion').order(release_date: :desc)
    @draft = Draft.new
    3.times { @draft.boosters.build }
  end

  def create
    @draft = Draft.new
    booster_set_ids.map do |set_id|
      @draft.boosters.build(card_set_id: set_id)
    end
    @draft.save
  end

  private
  
  def booster_set_ids
    params.select { |k, _| k.starts_with?("booster") }.values
  end
end
